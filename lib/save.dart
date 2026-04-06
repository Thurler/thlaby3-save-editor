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

  /// Internal flag for the [loadedWithErrors] getter
  bool _loadedWithErrors = false;

  /// Whether the save file loading encountered logic errors
  bool get loadedWithErrors => _loadedWithErrors;

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

  /// Initialize a [SaveFile] instance from the save file contents in the
  /// [baseDir] directory
  static Future<SaveFile> fromSaveDir(String baseDir) async {
    SaveFile saveFile = SaveFile();
    // Read PGD file with general game data
    Uint8List generalBytes = await File('$baseDir/PGD.txt').readAsBytes();
    saveFile._rawBytes['PGD.txt'] = generalBytes;
    // Read the party configuration from the general data
    for (int i = 0; i < partySlotCount; i++) {
      int characterIndex =
          generalBytes.getU32(Endian.big, offset: 0x190 + (i * 4));
      saveFile.partyData.add(
        characterIndex > 0
          ? PartySlot.withCharacter(Character.values[characterIndex - 1])
          : PartySlot.empty(),
      );
    }
    // Read C files with character data for known indexes
    for (Character character in Character.values) {
      String filename = 'C${character.index.toString().padLeft(3, '0')}.txt';
      Uint8List bytes = await File('$baseDir/$filename}').readAsBytes();
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
        Uint8List bytes = await File('$baseDir/$filename').readAsBytes();
        // Save raw bytes and initialize floor data from them
        saveFile._rawBytes[filename.toString()] = bytes;
        saveFile.mapData[filename] = FloorData.fromBytes(bytes);
      }
    }
    // Read EE files with item data
    Uint8List itemFlagBytes = await File('$baseDir/EEF.txt').readAsBytes();
    Uint8List itemLevelBytes = await File('$baseDir/EEH.txt').readAsBytes();
    Uint8List itemAmountBytes = await File('$baseDir/EEN.txt').readAsBytes();
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
    Uint8List eventBytes = await File('$baseDir/EVF.txt').readAsBytes();
    saveFile._rawBytes['EVF.txt'] = eventBytes;
    // Read PKO file with bestiary kill data
    Uint8List bestiaryBytes = await File('$baseDir/PKO.txt').readAsBytes();
    saveFile._rawBytes['PKO.txt'] = bestiaryBytes;
    // Read SHD file with summary data
    Uint8List summaryBytes = await File('$baseDir/SHD.txt').readAsBytes();
    saveFile._rawBytes['SHD.txt'] = summaryBytes;
    return saveFile;
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
    // Patch the raw bytes with the new data
    _patchRawBytes();
    // And then export all files into the target directory
    for (MapEntry<String, Uint8List> entry in _rawBytes.entries) {
      String filename = '$baseDir/${entry.key}';
      await File(filename).writeAsBytes(entry.value);
    }
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
