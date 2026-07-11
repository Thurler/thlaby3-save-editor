import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/training.dart';

/// The level at which a new skill tree row becomes available
enum LevelGate {
  first(1),
  second(10),
  third(22),
  fourth(36),
  fifth(50),
  sixth(64),
  seventh(80),
  eighth(99);

  /// The numerical value for the level
  final int level;

  const LevelGate(this.level);
}

/// A node in a [SkillTree] that houses the data for a [Skill]
class SkillNode {
  /// The skill that is housed in this node
  final Skill skill;

  /// The level gate required to make this skill learnable
  final LevelGate levelGate;

  /// The column this node occupies in the roww
  final int column;

  /// Additional requirements to learn the skill, as imposed by the skill tree
  final List<Skill> additionalRequirements;

  /// Whether the skill in this node has been learned or not
  bool isLearned;

  SkillNode({
    required this.skill,
    required this.levelGate,
    required this.column,
    this.isLearned = false,
    this.additionalRequirements = const <Skill>[],
  }) :
    assert(column >= 0, 'Column must not be negative'),
    assert(
      column < SkillTree.columnCount,
      'Column value must not exceed ${SkillTree.columnCount}',
    );

  /// Copy this node's data from another node
  SkillNode.from(SkillNode other) :
    skill = other.skill,
    levelGate = other.levelGate,
    column = other.column,
    additionalRequirements = other.additionalRequirements,
    isLearned = other.isLearned;

  /// The complete requirements for this skill node, adding the skill's base
  /// requirements with the additional requirements imposed by the tree
  List<Skill> get requirements => skill.requirements + additionalRequirements;

  @override
  bool operator ==(Object other) => other is SkillNode && skill == other.skill;

  @override
  int get hashCode => skill.hashCode;
}

/// A representation of a skill tree, uniting logic that is common between all
/// types of skill trees. Must be initialized from a character's data, using a
/// specific constructor that will initiate a specific type of skill tree from
/// the game
class SkillTree {
  /// How many columns each row in the tree can have
  static const int columnCount = 12;

  /// The set of skill nodes in this tree
  final Set<SkillNode> _skills = <SkillNode>{};

  /// A getter that returns the skills set as an [Iterable], so that callers can
  /// iterate on the [SkillNode]s but not alter the contents of the set struct
  Iterable<SkillNode> get skills => _skills;

  /// Creates a representation of a character's unique skill tree
  SkillTree.uniqueTree(Character character) {
    // Simply add all unique skills with the character-specific level gates and
    // column data
    for (LevelGate levelGate in character.uniqueSkills.keys) {
      for (int column in character.uniqueSkills[levelGate]!.keys) {
        Skill skill = character.uniqueSkills[levelGate]![column]!;
        _skills.add(
          SkillNode(
            skill: skill,
            levelGate: levelGate,
            column: column,
            // Add the additional requirements based on the character's
            // additional requirements map
            additionalRequirements:
                character.additionalSkillRequirements[skill] ?? const <Skill>[],
          ),
        );
      }
    }
  }

  /// Creates a representation of a character's training skill tree
  SkillTree.trainingTree(Character character) {
    // Add all common stat skills
    for (StatSkill skill in StatSkill.values) {
      _skills.add(
        SkillNode(
          skill: skill,
          levelGate: skill.levelGate,
          column: skill.column,
        ),
      );
    }
    // Add all mastery skills
    for ((int, Mastery) data in character.masteries.indexed) {
      int masteryIndex = data.$1;
      Mastery mastery = data.$2;
      // Mastery skill limit works backwards from index
      int maxLevel = 3 - masteryIndex;
      for (MasterySkill skill in mastery.skills.sublist(0, maxLevel)) {
        ContextLevelTuple? extra = MasterySkill.extraRequirements[(
          index: masteryIndex,
          level: skill.level,
        )];
        _skills.add(
          SkillNode(
            skill: skill,
            levelGate: skill.levelGate(masteryIndex),
            column: skill.column(masteryIndex),
            // Add the additional requirements based on the [MasterySkill] extra
            // requirements map
            additionalRequirements: <Skill>[
              if (extra != null)
                character.masteries[extra.index].skills[extra.level - 1],
            ],
          ),
        );
      }
    }
    // Add all personality skills
    for ((int, Personality) data in character.personalities.indexed) {
      int personalityIndex = data.$1;
      Personality personality = data.$2;
      // Personality skill limit works backwards from index
      int maxLevel = 3 - personalityIndex;
      for (PersonalitySkill skill in personality.skills.sublist(0, maxLevel)) {
        ContextLevelTuple? extra = PersonalitySkill.extraRequirements[(
          index: personalityIndex,
          level: skill.level,
        )];
        _skills.add(
          SkillNode(
            skill: skill,
            levelGate: skill.levelGate(personalityIndex),
            column: skill.column(personalityIndex),
            // Add the additional requirements based on the [PersonalitySkill]
            // extra requirements map
            additionalRequirements: <Skill>[
              if (extra != null)
                character.personalities[extra.index].skills[extra.level - 1],
            ],
          ),
        );
      }
    }
    // Add all body and mind skills, with their mastery/personality dependencies
    for (BodySkill skill in BodySkill.values) {
      ContextLevelTuple? extra = skill.masteryRequirement;
      _skills.add(
        SkillNode(
          skill: skill,
          levelGate: skill.levelGate,
          column: skill.column,
          additionalRequirements: <Skill>[
            if (extra != null)
              character.masteries[extra.index].skills[extra.level - 1],
          ],
        ),
      );
    }
    for (MindSkill skill in MindSkill.values) {
      ContextLevelTuple? extra = skill.personalityRequirement;
      _skills.add(
        SkillNode(
          skill: skill,
          levelGate: skill.levelGate,
          column: skill.column,
          additionalRequirements: <Skill>[
            if (extra != null)
              character.masteries[extra.index].skills[extra.level - 1],
          ],
        ),
      );
    }
  }

  /// Returns the appropriate [SkillNode] that occupies a given level gate and
  /// column, or null if that position is empty
  SkillNode? findNodeByPosition(LevelGate levelGate, int column) =>
      _skills.firstWhereOrNull(
    (SkillNode node) => node.levelGate == levelGate && node.column == column,
  );

  @override
  String toString() => skills.where(
    (SkillNode node) => node.isLearned,
  ).map(
    (SkillNode node) => '- ${node.skill.prettyName}',
  ).join('\n');
}
