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

  /// Return the bytes representation of the character data
  Iterable<int> toBytes(Endian endianness) {
    Iterable<int> bytes = <int>[];
    bytes = bytes.followedBy(level.toU32(endianness));
    bytes = bytes.followedBy(maxLevel.toU32(endianness));
    bytes = bytes.followedBy(experience.toU64(endianness));
    bytes = bytes.followedBy(libraryLevels.toBytes(endianness));
    bytes = bytes.followedBy(levelBonus.toBytes(endianness));
    bytes = bytes.followedBy(shrineItems.toBytes(endianness));
    bytes = bytes.followedBy(skills.toBytes(endianness));
    bytes = bytes.followedBy(unusedUniqueSkillPoints.toU32(endianness));
    bytes = bytes.followedBy(unusedTrainingSkillPoints.toU32(endianness));
    bytes = bytes.followedBy(bp.toU32(endianness));
    bytes = bytes.followedBy(mainEquipLevel.toU32(endianness));
    for (SubEquip equip in subEquips) {
      bytes = bytes.followedBy(equip.toBytes(endianness));
    }
    for (AwakeningEquip equip in mainEquips) {
      bytes = bytes.followedBy(equip.toBytes(endianness));
    }
    return bytes;
  }

  @override
  String toString() => character.name;
}
