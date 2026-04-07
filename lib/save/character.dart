import 'dart:typed_data';
import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/item.dart';
import 'package:thlaby3_save_editor/save/levelbonus.dart';
import 'package:thlaby3_save_editor/save/library.dart';
import 'package:thlaby3_save_editor/save/shrine_item.dart';
import 'package:thlaby3_save_editor/save/skill.dart';

/// A struct collecting all of a character's save data
class CharacterData {
  /// The character that is being referenced in this instance
  final Character character;

  /// The character's current level
  final int level;

  /// The character's highest achieved level
  final int maxLevel;

  /// The character's main equip upgrade level
  final int mainEquipLevel;

  /// The character's unused skill points for the unique skill tree
  final int unusedUniqueSkillPoints;

  /// The character's unused training points for the unique skill tree
  final int unusedTrainingSkillPoints;

  /// The character's battle point count
  final int bp;

  /// The character's held experience points
  final BigInt experience;

  /// The character's library level data
  final LibraryData libraryLevels;

  /// The character's level bonus data
  final LevelBonus levelBonus;

  /// The character's skill tree data
  final SkillData skills;

  /// The character's shrine item data
  final ShrineItemData shrineItems;

  /// The character's main equipment
  final List<AwakeningEquip> mainEquips;

  /// The character's sub equipment
  final List<SubEquip> subEquips;

  /// Whether this character is Renko, used to determine if Renko-specific data
  /// should be parsed
  bool get isRenko => character == Character.renko;

  CharacterData({
    required this.character,
    required this.level,
    required this.maxLevel,
    required this.mainEquipLevel,
    required this.unusedUniqueSkillPoints,
    required this.unusedTrainingSkillPoints,
    required this.bp,
    required this.experience,
    required this.libraryLevels,
    required this.levelBonus,
    required this.skills,
    required this.shrineItems,
    required this.mainEquips,
    required this.subEquips,
  });

  /// Initialize the character data from the provided [bytes]
  CharacterData.fromBytes({
    required this.character,
    required Endian endianness,
    required Uint8List bytes,
  }) :
    level = bytes.getU32(endianness),
    maxLevel = bytes.getU32(endianness, offset: 0x4),
    experience = bytes.getU64(endianness, offset: 0x8),
    libraryLevels = LibraryData.fromBytes(endianness, bytes, 0x10),
    levelBonus = LevelBonus.fromBytes(endianness, bytes, 0x48),
    shrineItems = ShrineItemData.fromBytes(endianness, bytes, 0x60),
    skills = SkillData.fromBytes(character, endianness, bytes, 0x8c),
    unusedUniqueSkillPoints = bytes.getU32(endianness, offset: 0x86c),
    unusedTrainingSkillPoints = bytes.getU32(endianness, offset: 0x870),
    bp = bytes.getU32(endianness, offset: 0x874),
    mainEquipLevel = bytes.getU32(endianness, offset: 0x878),
    subEquips = List<SubEquip>.generate(
      3,
      (int i) => SubEquip.fromId(
        bytes.getU32(endianness, offset: 0x87c + (i * 4)),
      ),
    ),
    mainEquips = List<AwakeningEquip>.generate(
      5,
      (int i) => AwakeningEquip.fromId(
        bytes.getU32(endianness, offset: 0x894 + (i * 4)),
      ),
    );

  /// Patch the bytes representation of the character data
  void patchBytes(Endian endianness, Uint8List bytes) {
    bytes.setRange(0x0, 0x4, level.toU32(endianness));
    bytes.setRange(0x4, 0x8, maxLevel.toU32(endianness));
    bytes.setRange(0x8, 0x10, experience.toU64(endianness));
    libraryLevels.patchBytes(endianness, bytes, 0x10);
    levelBonus.patchBytes(endianness, bytes, 0x48);
    shrineItems.patchBytes(endianness, bytes, 0x60);
    skills.patchBytes(endianness, bytes, 0x8c);
    bytes.setRange(0x86c, 0x870, unusedUniqueSkillPoints.toU32(endianness));
    bytes.setRange(0x870, 0x874, unusedTrainingSkillPoints.toU32(endianness));
    bytes.setRange(0x874, 0x878, bp.toU32(endianness));
    bytes.setRange(0x878, 0x87c, mainEquipLevel.toU32(endianness));
    for ((int, SubEquip) indexedEquip in subEquips.indexed) {
      int offset = 0x87c + (indexedEquip.$1 * 4);
      bytes.setRange(offset, offset + 4, indexedEquip.$2.toBytes(endianness));
    }
    for ((int, AwakeningEquip) indexedEquip in mainEquips.indexed) {
      int offset = 0x894 + (indexedEquip.$1 * 4);
      bytes.setRange(offset, offset + 4, indexedEquip.$2.toBytes(endianness));
    }
  }

  @override
  String toString() => '''
> ${character.name}
Lv: $level / Max: $maxLevel
EXP: $experience / BP: $bp
Unused points: $unusedUniqueSkillPoints / $unusedTrainingSkillPoints
$libraryLevels
$levelBonus
$shrineItems
Main equip level: $mainEquipLevel
Sub equips: ${subEquips.map((SubEquip equip) => equip.prettyName).join(' / ')}
Awakenings: ${mainEquips.map((AwakeningEquip equip) => equip.prettyName).join(' / ')}
$skills
''';
}
