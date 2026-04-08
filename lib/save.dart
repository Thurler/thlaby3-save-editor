import 'dart:io';
import 'dart:typed_data';
import 'package:tfields/extensions.dart';
import 'package:tfields/logging.dart';
import 'package:thlaby3_save_editor/save/character.dart';
import 'package:thlaby3_save_editor/save/character_unlock.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/dungeon.dart';
import 'package:thlaby3_save_editor/save/enums/item.dart';
import 'package:thlaby3_save_editor/save/item_slot.dart';
import 'package:thlaby3_save_editor/save/map.dart';
import 'package:thlaby3_save_editor/save/party_slot.dart';

/// A common interface for exceptions regarding save data parsing
abstract interface class SaveException implements Exception {
  /// The message that is displayed to the user
  String get userMessage;

  /// The message that is logged
  String get logMessage;
}

/// An exception that signifies invalid file format was encountered while
/// reading the files in the save data
class SaveFileFormatException implements SaveException {
  /// The number of expected bytes
  final int expected;

  /// The actual number of bytes encountered
  final int actual;

  /// The affected filename
  final String filename;

  const SaveFileFormatException({
    required this.filename,
    required this.actual,
    required this.expected,
  });

  @override
  String get userMessage => 'Invalid save file format';

  @override
  String get logMessage => toString();

  @override
  String toString() => 'SaveFileFormatException: expected $expected bytes in '
      'file $filename, but found $actual';
}

/// An exception that signifies invalid data was encountered while parsing save
/// data
class SaveFileParseException implements SaveException {
  @override
  final String userMessage;

  @override
  String get logMessage => toString();

  final String _logMessage;

  const SaveFileParseException({
    required this.userMessage,
    required String logMessage,
  }) : _logMessage = logMessage;

  @override
  String toString() => 'SaveFileParseException: $_logMessage';
}

/// An enumertion of save file data file types, containing validation data for
/// each of the file types
enum _SaveFileType {
  od(null, FloorData.gridSize * FloorData.gridSize),
  c(null, 0xbdc),
  eef('EEF.txt', totalItemCount + 1),
  eeh('EEH.txt', (SubEquip.totalSlots + 1) * 4),
  een('EEN.txt', (totalItemCount + 1) * 4),
  evf('EVF.txt', 30000 * 4),
  pgd('PGD.txt', 0x7537),
  pko('PKO.txt', 10000 * 4),
  shd('SHD.txt', 0);

  /// The hardcoded filename for this file type - can be null if there are
  /// variables that go into the filename, e.g.: a character's index
  final String? fixedFilename;

  /// The expected file size - reading a file with a different number of bytes
  /// will result in an error
  final int expectedSize;

  const _SaveFileType(this.fixedFilename, this.expectedSize);
}

/// A data instance of a save file, with both a high-level and a bytes-level
/// representation of the in-game data
class SaveFile with TLoggable {
  /// How many characters fit in the party in-game
  static const int partySlotCount = 12;

  /// How many dungeon IDs the game (and save file) are aware of
  static const int dungeonCount = 10;

  /// How many floor IDs the game (and save file) are aware of
  static const int floorCount = 5;

  /// The raw bytes read from the save directory, for each file that was read
  ///
  /// Changes to the underlying save structures are only propagated to this map
  /// when they are exported
  final Map<String, Uint8List> _rawBytes = <String, Uint8List>{};

  /// The map data associated with the OD files
  final Map<FloorFileName, FloorData> mapData = <FloorFileName, FloorData>{};

  /// The character data associated with the C files
  final List<CharacterData> characterData = <CharacterData>[];

  /// The item data for Awakening equips from the EE files
  final List<ItemSlot<AwakeningEquip>> mainInventoryData =
      <ItemSlot<AwakeningEquip>>[];

  /// The item data for Sub equips from the EE files
  final List<ItemSlot<SubEquip>> subInventoryData = <ItemSlot<SubEquip>>[];

  /// The item data for Materials from the EE files
  final List<ItemSlot<Material>> materialInventoryData = <ItemSlot<Material>>[];

  /// The item data for Break items from the EE files
  final List<ItemSlot<BreakItem>> breakInventoryData = <ItemSlot<BreakItem>>[];

  /// The item data for Special items from the EE files
  final List<ItemSlot<SpecialItem>> specialInventoryData =
      <ItemSlot<SpecialItem>>[];

  /// The character unlock flag data from the PGD file
  final List<CharacterUnlockFlag> characterUnlockData = <CharacterUnlockFlag>[];

  /// The party slots data from the PGD file
  final List<PartySlot> partyData = <PartySlot>[];

  /// Logic to initialize item slots data based on the flags, level and amount
  /// raw data read from the EE files
  ///
  /// Iterates on each item type's values, initializing the data into the
  /// provided [slots] list
  static void _initializeItemData<I extends Item>({
    required Iterable<I> items,
    required int baseOffset,
    required Uint8List flagsBytes,
    required Uint8List levelBytes,
    required Uint8List amountBytes,
    required List<ItemSlot<I>> slots,
  }) {
    // Pre-compute the specialized types that use the levels data
    bool isSubEquip = items.first is SubEquip;
    for (I item in items) {
      // Skip empty IDs since they don't represent a real item
      if (item.id == 0) {
        continue;
      }
      // Initialize the slot with the unlock flag data
      // Data is 1-byte long, so the base offset just adds to the index
      ItemSlot<I> slot = ItemSlot<I>(
        item,
        isUnlocked: flagsBytes[baseOffset + item.index] > 0,
      );
      // Add the amount data from the amount bytes data
      // Data is 4-bytes long, so the base offset is added to the index BEFORE
      // being multiplied by 4
      slot.amountFromBytes(
        endianness: Endian.big,
        bytes: amountBytes,
        offset: (baseOffset + item.index) * 4,
      );
      // Sub equips have level data, read in the same way amounts are
      if (isSubEquip) {
        slot.levelFromBytes(
          endianness: Endian.big,
          bytes: levelBytes,
          offset: (baseOffset + item.index) * 4,
        );
      }
      slots.add(slot);
    }
  }

  /// A helper function to read a save data's file and handle exceptions, making
  /// sure to check for raw data validity
  static Future<Uint8List> _readSaveFile(
    String baseDir,
    _SaveFileType fileType,
    Future<void> Function(TLogLevel level, dynamic message) logFunction, {
    String? filename,
  }) async {
    String filenameToUse = filename ?? fileType.fixedFilename ?? '';
    Uint8List bytes = await File('$baseDir/$filenameToUse').readAsBytes();
    // Make sure we have the right amount of bytes to read
    if (bytes.length != fileType.expectedSize) {
      throw SaveFileFormatException(
        filename: filenameToUse,
        expected: fileType.expectedSize,
        actual: bytes.length,
      );
    }
    // Debug log the whole bytes array
    await logFunction(TLogLevel.debug, '$filenameToUse: $bytes');
    return bytes;
  }

  /// Initialize a [SaveFile] instance from the save file contents in the
  /// [baseDir] directory
  static Future<SaveFile> fromSaveDir(String baseDir) async {
    SaveFile saveFile = SaveFile();
    await saveFile.log(TLogLevel.debug, '=== SAVE FILE READING BEGIN ===');
    // Read PGD file with general game data
    Uint8List generalBytes =
        await _readSaveFile(baseDir, _SaveFileType.pgd, saveFile.log);
    saveFile._rawBytes['PGD.txt'] = generalBytes;
    // Read the party configuration from the general data
    for (int i = 0; i < partySlotCount; i++) {
      int characterIndex =
          generalBytes.getU32(Endian.big, offset: 0x190 + (i * 4));
      if (characterIndex > Character.values.length) {
        throw SaveFileParseException(
          userMessage: 'Invalid character in party',
          logMessage: 'Character index $characterIndex read at position $i',
        );
      }
      PartySlot slot = characterIndex > 0
        ? PartySlot.withCharacter(Character.values[characterIndex - 1])
        : PartySlot.empty();
      saveFile.partyData.add(slot);
    }
    // Read C files with character data for known indexes
    for (Character character in Character.values) {
      String filename = 'C${character.index.toString().padLeft(3, '0')}.txt';
      Uint8List bytes = await _readSaveFile(
        baseDir,
        _SaveFileType.c,
        saveFile.log,
        filename: filename,
      );
      // Save raw bytes and initialize character data from them
      saveFile._rawBytes[filename] = bytes;
      saveFile.characterData.add(
        CharacterData.fromBytes(
          character: character,
          endianness: Endian.big,
          bytes: bytes,
        ),
      );
      // We also initialize a [CharacterUnlockFlag] for that character with the
      // data available from [generalBytes]
      saveFile.characterUnlockData.add(
        CharacterUnlockFlag(
          character: character,
          isUnlocked: generalBytes.getU32(
            Endian.big,
            offset: (character.index + 1) * 4,
          ) > 0,
        ),
      );
    }
    // Read OD files with map data for known indexes
    for (int i = 1; i <= dungeonCount; i++) {
      for (int j = 1; j <= floorCount; j++) {
        FloorFileName filename = FloorFileName(Dungeon.values[i - 1], j);
        Uint8List bytes = await _readSaveFile(
          baseDir,
          _SaveFileType.od,
          saveFile.log,
          filename: filename.toString(),
        );
        // Save raw bytes and initialize floor data from them
        saveFile._rawBytes[filename.toString()] = bytes;
        saveFile.mapData[filename] = FloorData.fromBytes(bytes);
      }
    }
    // Read EE files with item data
    Uint8List itemFlagBytes =
        await _readSaveFile(baseDir, _SaveFileType.eef, saveFile.log);
    Uint8List itemLevelBytes =
        await _readSaveFile(baseDir, _SaveFileType.eeh, saveFile.log);
    Uint8List itemAmountBytes =
        await _readSaveFile(baseDir, _SaveFileType.een, saveFile.log);
    saveFile._rawBytes['EEF.txt'] = itemFlagBytes;
    saveFile._rawBytes['EEH.txt'] = itemLevelBytes;
    saveFile._rawBytes['EEN.txt'] = itemAmountBytes;
    // Iterate on items to initialize their data
    int itemOffset = 0;
    _initializeItemData<SubEquip>(
      items: SubEquip.values,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
      slots: saveFile.subInventoryData,
    );
    itemOffset += SubEquip.totalSlots;
    _initializeItemData<Material>(
      items: Material.values,
      // Material has no empty value, so indexes are 1 off
      baseOffset: itemOffset + 1,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
      slots: saveFile.materialInventoryData,
    );
    itemOffset += Material.totalSlots;
    _initializeItemData<BreakItem>(
      items: BreakItem.values,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
      slots: saveFile.breakInventoryData,
    );
    itemOffset += BreakItem.totalSlots;
    _initializeItemData<SpecialItem>(
      items: SpecialItem.values,
      // Special has no empty value, so indexes are 1 off
      baseOffset: itemOffset + 1,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
      slots: saveFile.specialInventoryData,
    );
    itemOffset += SpecialItem.totalSlots;
    _initializeItemData<AwakeningEquip>(
      items: AwakeningEquip.values,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
      slots: saveFile.mainInventoryData,
    );
    // Read EVF file with event flag data
    Uint8List eventBytes =
        await _readSaveFile(baseDir, _SaveFileType.evf, saveFile.log);
    saveFile._rawBytes['EVF.txt'] = eventBytes;
    // Read PKO file with bestiary kill data
    Uint8List bestiaryBytes =
        await _readSaveFile(baseDir, _SaveFileType.pko, saveFile.log);
    saveFile._rawBytes['PKO.txt'] = bestiaryBytes;
    // Read SHD file with summary data
    Uint8List summaryBytes =
        await _readSaveFile(baseDir, _SaveFileType.shd, saveFile.log);
    saveFile._rawBytes['SHD.txt'] = summaryBytes;
    await saveFile.log(TLogLevel.debug, '=== SAVE FILE READING END ===');
    // Dump the debug log data and flush logs
    await saveFile._dumpHighLevelData();
    return saveFile;
  }

  /// Logs a string debug representation of the save file, in a high level
  /// format for troubleshooting data parsing logic
  Future<void> _dumpHighLevelData() async {
    await log(TLogLevel.debug, '=== SAVE FILE DUMP START ===');
    logBuffer(TLogLevel.debug, '> Party Data');
    for (PartySlot slot in partyData) {
      logBuffer(TLogLevel.debug, slot);
    }
    logBuffer(TLogLevel.debug, '> Character Unlock Flags');
    for (CharacterUnlockFlag flag in characterUnlockData) {
      logBuffer(TLogLevel.debug, flag);
    }
    logBuffer(TLogLevel.debug, '> Awakening Items');
    for (ItemSlot<AwakeningEquip> slot in mainInventoryData) {
      logBuffer(TLogLevel.debug, slot);
    }
    logBuffer(TLogLevel.debug, '> Sub Equip Items');
    for (ItemSlot<SubEquip> slot in subInventoryData) {
      logBuffer(TLogLevel.debug, slot);
    }
    logBuffer(TLogLevel.debug, '> Materials');
    for (ItemSlot<Material> slot in materialInventoryData) {
      logBuffer(TLogLevel.debug, slot);
    }
    logBuffer(TLogLevel.debug, '> Break Items');
    for (ItemSlot<BreakItem> slot in breakInventoryData) {
      logBuffer(TLogLevel.debug, slot);
    }
    logBuffer(TLogLevel.debug, '> Special Items');
    for (ItemSlot<SpecialItem> slot in specialInventoryData) {
      logBuffer(TLogLevel.debug, slot);
    }
    for (CharacterData character in characterData) {
      logBuffer(TLogLevel.debug, character);
    }
    await log(TLogLevel.debug, '=== SAVE FILE DUMP END ===');
  }

  /// Logic to patch item slots data back into the flags, level and amount bytes
  /// data for the EE files
  void _patchItemData<I extends Item>({
    required List<ItemSlot<I>> slots,
    required int baseOffset,
    required Uint8List flagsBytes,
    required Uint8List levelBytes,
    required Uint8List amountBytes,
  }) {
    // Pre-compute the specialized types that use the levels data
    bool isSubEquip = slots.first.item is SubEquip;
    for (ItemSlot<I> slot in slots) {
      // Patch the slot unlock flag data
      // Data is 1-byte long, so the base offset just adds to the index
      flagsBytes[baseOffset + slot.item.index] = slot.toUnlockByte();
      // Amount and level data are 4-bytes long, so the base offset is added to
      // the index BEFORE multiplying by 4
      int offset = (baseOffset + slot.item.index) * 4;
      // Patch the amount data
      amountBytes.setRange(offset, offset + 4, slot.toAmountBytes(Endian.big));
      // Sub equips have level data, written in the same way amounts are
      if (isSubEquip) {
        levelBytes.setRange(offset, offset + 4, slot.toLevelBytes(Endian.big));
      }
    }
  }

  /// Patch the high-level data in the class back into [_rawBytes]
  void _patchRawBytes() {
    // Patch the SHD file with summary data based on other data
    Uint8List summaryBytes = _rawBytes['SHD.txt']!;
    Uint8List generalBytes = _rawBytes['PGD.txt']!;
    // Patch the party configuration into the general data
    for (int i = 0; i < partySlotCount; i++) {
      Iterable<int> value = partyData[i].toBytes(Endian.big);
      int generalOffset = 0x190 + (i * 4);
      int summaryOffset = 0x21 + (i * 4);
      generalBytes.setRange(generalOffset, generalOffset + 4, value);
      summaryBytes.setRange(summaryOffset, summaryOffset + 4, value);
    }
    // Patch the character files with character data for known indexes, while
    // keeping track of how many are unlocked
    int allyCount = 0;
    for (Character character in Character.values) {
      String filename = 'C${character.index.toString().padLeft(3, '0')}.txt';
      Uint8List characterBytes = _rawBytes[filename]!;
      characterData[character.index].patchBytes(Endian.big, characterBytes);
      // Also patch the character unlock flag data in the general bytes
      int offset = (character.index + 1) * 4;
      bool isUnlocked = characterUnlockData[character.index].isUnlocked;
      if (isUnlocked) {
        allyCount++;
      }
      int unlockValue = isUnlocked ? 1 : 0;
      generalBytes.setRange(offset, offset + 4, unlockValue.toU32(Endian.big));
    }
    // The number of allies just adds the unlocked flags
    summaryBytes.setRange(0xd, 0x11, allyCount.toU32(Endian.big));
    // The average party level is computed from the 12 characters in the party
    int levelSum = partyData.map(
      (PartySlot slot) => slot.character,
    ).nonNulls.map(
      (Character character) => characterData[character.index],
    ).fold(0, (int total, CharacterData character) => total + character.level);
    // The average divides by 12, unless less than 12 characters have been
    // unlocked
    int averageLevel =
        levelSum ~/ (allyCount < partySlotCount ? allyCount : partySlotCount);
    summaryBytes.setRange(0x9, 0xd, averageLevel.toU32(Endian.big));
    // Patch the OD files with map data for known indexes
    for (int i = 1; i <= dungeonCount; i++) {
      for (int j = 1; j <= floorCount; j++) {
        FloorFileName filename = FloorFileName(Dungeon.values[i - 1], j);
        _rawBytes[filename.toString()] = mapData[filename]!.toBytes();
      }
    }
    // Patch the EE files with item data
    Uint8List itemFlagBytes = _rawBytes['EEF.txt']!;
    Uint8List itemLevelBytes = _rawBytes['EEH.txt']!;
    Uint8List itemAmountBytes = _rawBytes['EEN.txt']!;
    // Iterate on items to patch their data to the bytes
    int itemOffset = 0;
    _patchItemData<SubEquip>(
      slots: subInventoryData,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
    );
    itemOffset += SubEquip.totalSlots;
    _patchItemData<Material>(
      slots: materialInventoryData,
      // Material has no empty value, so indexes are 1 off
      baseOffset: itemOffset + 1,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
    );
    itemOffset += Material.totalSlots;
    _patchItemData<BreakItem>(
      slots: breakInventoryData,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
    );
    itemOffset += BreakItem.totalSlots;
    _patchItemData<SpecialItem>(
      slots: specialInventoryData,
      // Special has no empty value, so indexes are 1 off
      baseOffset: itemOffset + 1,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
    );
    itemOffset += SpecialItem.totalSlots;
    _patchItemData<AwakeningEquip>(
      slots: mainInventoryData,
      baseOffset: itemOffset,
      flagsBytes: itemFlagBytes,
      levelBytes: itemLevelBytes,
      amountBytes: itemAmountBytes,
    );
  }

  /// Exports the save data into a directory at [baseDir]
  Future<void> export(String baseDir) async {
    // Dump the debug log data and flush logs
    await _dumpHighLevelData();
    // Patch the raw bytes with the new data
    _patchRawBytes();
    // And then export all files into the target directory
    await log(TLogLevel.debug, '=== SAVE FILE EXPORT START ===');
    for (MapEntry<String, Uint8List> entry in _rawBytes.entries) {
      String filename = '$baseDir/${entry.key}';
      // Debug log the whole bytes array before writing it
      await log(TLogLevel.debug, '${entry.key}: ${entry.value}');
      await File(filename).writeAsBytes(entry.value);
    }
    await log(TLogLevel.debug, '=== SAVE FILE EXPORT END ===');
  }
}

/// A wrapper for [SaveFile] that makes it a singleton
class _SaveFileWrapper {
  /// The singleton instance
  static final _SaveFileWrapper _saveFileWrapper = _SaveFileWrapper._internal();

  /// The instance of [SaveFile]
  late SaveFile saveFile;

  factory _SaveFileWrapper() => _saveFileWrapper;

  _SaveFileWrapper._internal();
}

/// A mixin for classes that wish to have access to the singleton [SaveFile]
/// instance, with both read and write access
mixin SaveEditor {
  /// The singleton instance
  final _SaveFileWrapper _saveFileWrapper = _SaveFileWrapper();

  /// A getter that returns the reference to the savefile from the singleton
  SaveFile get saveFile => _saveFileWrapper.saveFile;
}

/// A mixin for classes that wish to change the reference pointer to the
/// savefile the [SaveFile] singleton points to
mixin SaveLoader on SaveEditor {
  /// Updates the savefile data in the singleton
  set saveFile(SaveFile file) => _saveFileWrapper.saveFile = file;
}
