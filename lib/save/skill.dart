import 'dart:typed_data';

import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// All of a character's skill data, collecting all of their skill trees
class SkillData {
  /// How many rows the save file reserves for skill data, per tree
  static const int skillRowCount = 21;

  /// The size, in bytes, of a skill tree's data
  static const int skillTreeByteSize =
      skillRowCount * SkillTree.columnCount * 4;

  /// The character's unique skill tree
  final SkillTree uniqueSkillTree;

  /// The character's training skill tree
  final SkillTree trainingSkillTree;

  SkillData({
    required this.uniqueSkillTree,
    required this.trainingSkillTree,
  });

  /// Initialize the skill tree data from the provided [bytes] or the given
  /// [character]
  SkillData.fromBytes(
    Character character,
    Endian endianness,
    Uint8List bytes,
    int offset,
  ) :
    uniqueSkillTree = SkillTree.uniqueTree(character),
    trainingSkillTree = SkillTree.trainingTree(character) {
    // Trees are adjacent in bytes, so the training offset is shifted over by
    // [skillRowCount] * [SkillTree.columnCount] * sizeof(skill) bytes
    int trainingOffset = offset + skillTreeByteSize;
    // Iterate on every available row in the save file
    for (int i = 0; i < skillRowCount; i++) {
      // Discard the skills currently unused in the game
      if (i < 1 || i > LevelGate.values.length) {
        continue;
      }
      // For each row, iterate on each column to load the bytes data into the
      // skill node, if it exists in the skill tree
      for (int j = 0; j < SkillTree.columnCount; j++) {
        // Compute the bytes offset for this skill in the skill tree bytes
        int skillOffset = ((i * SkillTree.columnCount) + j) * 4;
        // Make sure a skill node exists at the given position in the unique
        // tree, and update the learned flag based on the bytes value
        SkillNode? uniqueNode =
            uniqueSkillTree.findNodeByPosition(LevelGate.values[i - 1], j);
        uniqueNode?.isLearned =
            bytes.getU32(endianness, offset: offset + skillOffset) > 0;
        // Do the exact same thing but with the training skill tree offset
        SkillNode? trainingNode =
            trainingSkillTree.findNodeByPosition(LevelGate.values[i - 1], j);
        trainingNode?.isLearned =
            bytes.getU32(endianness, offset: trainingOffset + skillOffset) > 0;
      }
    }
  }

  /// Patch the 4-byte bytes representation of the skill tree data
  void patchBytes(Endian endianness, Uint8List bytes, int offset) {
    // For each unique skill in the unique skill tree, we patch the bytes
    // refering to the skill position
    for (SkillNode node in uniqueSkillTree.skills) {
      int value = node.isLearned ? 1 : 0;
      int skillOffset = (node.levelGate.index + 1) * node.column * 4;
      bytes.setRange(
        offset + skillOffset,
        offset + skillOffset + 4,
        value.toU32(endianness),
      );
    }
    // Do the same for the training skill tree, using the appropriate offset
    for (SkillNode node in trainingSkillTree.skills) {
      int value = node.isLearned ? 1 : 0;
      int skillOffset = (node.levelGate.index + 1) * node.column * 4;
      bytes.setRange(
        offset + skillTreeByteSize + skillOffset,
        offset + skillTreeByteSize + skillOffset + 4,
        value.toU32(endianness),
      );
    }
  }

  @override
  String toString() => 'Unique skills learned:\n$uniqueSkillTree\n'
      'Training skills learned:\n$trainingSkillTree';
}
