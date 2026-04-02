import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// The class representing the common attributes between skill types
abstract interface class Skill {
  /// The skill's name as displayed in-game
  String get prettyName;

  /// The amount of skill points required to learn the skill
  int get cost;

  /// The skill's hard-coded requirements in the skill tree
  ///
  /// The complete requirements may depend on the character holding the skill,
  /// this only lists the requirements that are present for all characters
  ///
  /// In order to access a skill's requirements for a specific skill tree's
  /// instance, refer to the [SkillNode.requirements] getter
  List<Skill> get requirements;
}

/// A mixin for [Skill] that adds a fixed position in the skill tree
mixin _FixedPositionSkill implements Skill {
  /// The skill's associated level gate, which determines the row it will be in
  LevelGate get levelGate;

  /// The skill's associated column in the row it resides in
  int get column;
}

/// A skill from the common training skill tree that every character shares,
/// regardless of their traits
enum StatSkill with _FixedPositionSkill {
  hpTraining('HP Training', 3, levelGate: LevelGate.first, column: 0),
  hpTraining2(
    'HP Training+',
    4,
    levelGate: LevelGate.second,
    column: 0,
    requirements: <Skill>[StatSkill.hpTraining],
  );

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  @override
  final LevelGate levelGate;

  @override
  final int column;

  const StatSkill(
    this.prettyName,
    this.cost, {
    required this.levelGate,
    required this.column,
    this.requirements = const <Skill>[],
  }) : assert(cost > 0, 'Skill cost must be at least 1');
}

/// The overall body training skills from the common training skill tree every
/// character shares
enum BodySkill with _FixedPositionSkill {
  body(
    'Overall Body Training',
    3,
    levelGate: LevelGate.fifth,
    column: 0,
    masteryRequirement: (index: 2, level: 1), // Tertiary mastery
  ),
  body2(
    'Overall Body Training+',
    4,
    levelGate: LevelGate.sixth,
    column: 0,
    requirements: <Skill>[BodySkill.body],
    masteryRequirement: (index: 1, level: 2), // Secondary mastery
  ),
  body3(
    'Overall Body Training++',
    5,
    levelGate: LevelGate.seventh,
    column: 0,
    requirements: <Skill>[BodySkill.body2],
    masteryRequirement: (index: 0, level: 3), // Primary mastery
  ),
  body4(
    'Overall Body Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 0,
    requirements: <Skill>[BodySkill.body3],
  );

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  @override
  final LevelGate levelGate;

  @override
  final int column;

  /// The additional requirement from the mastery skill tree
  final ContextLevelTuple? masteryRequirement;

  const BodySkill(
    this.prettyName,
    this.cost, {
    required this.levelGate,
    required this.column,
    this.requirements = const <Skill>[],
    this.masteryRequirement,
  }) : assert(cost > 0, 'Skill cost must be at least 1');
}

/// The overall mind training skills from the common training skill tree every
/// character shares
enum MindSkill with _FixedPositionSkill {
  mind(
    'Overall Mind Training',
    3,
    levelGate: LevelGate.fifth,
    column: 0,
    personalityRequirement: (index: 2, level: 1), // Tertiary personality
  ),
  mind2(
    'Overall Mind Training+',
    4,
    levelGate: LevelGate.sixth,
    column: 0,
    requirements: <Skill>[MindSkill.mind],
    personalityRequirement: (index: 1, level: 2), // Secondary personality
  ),
  mind3(
    'Overall Mind Training++',
    5,
    levelGate: LevelGate.seventh,
    column: 0,
    requirements: <Skill>[MindSkill.mind2],
    personalityRequirement: (index: 0, level: 3), // Primary personality
  ),
  mind4(
    'Overall Mind Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 0,
    requirements: <Skill>[MindSkill.mind3],
  );

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  @override
  final LevelGate levelGate;

  @override
  final int column;

  /// The additional requirement from the personality skill tree
  final ContextLevelTuple? personalityRequirement;

  const MindSkill(
    this.prettyName,
    this.cost, {
    required this.levelGate,
    required this.column,
    this.requirements = const <Skill>[],
    this.personalityRequirement,
  }) : assert(cost > 0, 'Skill cost must be at least 1');
}

typedef ContextLevelTuple = ({int index, int level});
typedef _ContextualLevelGateMap = Map<ContextLevelTuple, LevelGate>;

/// A mixin for [Skill] that adds a contextual position in the skill tree,
/// usually the max level associated with the [Mastery] or [Personality]
mixin _ContextualPositionSkill implements Skill {
  /// A map that relates the [LevelGate] associated with a contextually
  /// positioned skill and its level, accounting for the max level that the
  /// mastery/personality can reach
  static const _ContextualLevelGateMap _levelGateMap =
      <ContextLevelTuple, LevelGate>{
    // Main mastery / personality
    (index: 0, level: 1): LevelGate.first,
    (index: 0, level: 2): LevelGate.third,
    (index: 0, level: 3): LevelGate.fifth,
    // Secondary mastery / personality
    (index: 1, level: 1): LevelGate.second,
    (index: 1, level: 2): LevelGate.fourth,
    // Tertiary mastery / personality
    (index: 2, level: 1): LevelGate.third,
  };

  /// The skill's associated level gate, which determines the row it will be in
  LevelGate levelGate(int context);

  /// The skill's associated column in the row it resides in
  int column(int context);
}

typedef SkillRequirementMap = Map<ContextLevelTuple, ContextLevelTuple>;

/// A mastery skill from the mastery section of the common training skill tree
enum MasterySkill with _ContextualPositionSkill {
  heavy('Heavy Mastery', 1),
  heavy2('Heavy Mastery+', 2, requirements: <Skill>[MasterySkill.heavy]),
  heavy3('Heavy Mastery++', 3, requirements: <Skill>[MasterySkill.heavy2]);

  static const SkillRequirementMap extraRequirements =
      <ContextLevelTuple, ContextLevelTuple>{
    // Main mastery depends on secondary previous level
    (index: 0, level: 2): (index: 1, level: 1),
    (index: 0, level: 3): (index: 1, level: 2),
    // Secondary mastery depends on main same level then tertiary previous level
    (index: 1, level: 1): (index: 0, level: 1),
    (index: 1, level: 2): (index: 2, level: 1),
    // Tertiary mastery depends on secondary same level
    (index: 2, level: 1): (index: 1, level: 1),
  };

  @override
  final String prettyName;

  @override
  final List<Skill> requirements;

  /// The level of mastery associated with this skill
  final int level;

  // Cost is hard-coded for all mastery skills based on level
  @override
  int get cost => <int>[3, 4, 5][level - 1];

  @override
  LevelGate levelGate(int masteryIndex) {
    try {
      // Refer to the Map defined above, throw on invalid combos
      return _ContextualPositionSkill._levelGateMap[(
        index: masteryIndex,
        level: level,
      )]!;
    } catch (err) {
      throw Exception(
        'Impossible combination of masteryIndex and mastery skill level '
        'encountered: ($masteryIndex, $level)',
      );
    }
  }

  // Column is hard-coded based on the max mastery level attainable
  @override
  int column(int maxMasteryLevel) => <int>[8, 9, 10][maxMasteryLevel - 1];

  const MasterySkill(
    this.prettyName,
    this.level, {
    this.requirements = const <Skill>[],
  }) :
    assert(level >= 1, 'Level must be at least 1'),
    assert(level <= 3, 'Level must be at most 3');
}

/// The mastery associated with a character, holding the list of mastery skills
/// associated with it
enum Mastery {
  heavy(<MasterySkill>[
    MasterySkill.heavy,
    MasterySkill.heavy2,
    MasterySkill.heavy3,
  ]);

  /// The skills associated with this mastery
  final List<MasterySkill> skills;

  const Mastery(this.skills);
}

/// A personality skill from the personality section of the common training
/// skill tree
enum PersonalitySkill with _ContextualPositionSkill {
  sturdy('Sturdy', 1),
  sturdy2('Sturdy+', 2, requirements: <Skill>[PersonalitySkill.sturdy]),
  sturdy3('Sturdy++', 3, requirements: <Skill>[PersonalitySkill.sturdy2]);

  static const SkillRequirementMap extraRequirements =
      <ContextLevelTuple, ContextLevelTuple>{
    // Secondary personality initially depends on main same level
    (index: 1, level: 1): (index: 0, level: 1),
    // Tertiary personality depends on secondary same level
    (index: 2, level: 1): (index: 1, level: 1),
  };

  @override
  final String prettyName;

  @override
  final List<Skill> requirements;

  /// The level of mastery associated with this skill
  final int level;

  // Cost is hard-coded for all mastery skills to be 3
  @override
  int get cost => 3;

  @override
  LevelGate levelGate(int personalityIndex) {
    try {
      // Refer to the Map defined above, throw on invalid combos
      return _ContextualPositionSkill._levelGateMap[(
        index: personalityIndex,
        level: level,
      )]!;
    } catch (err) {
      throw Exception(
        'Impossible combination of personalityIndex and personality skill '
        'level encountered: ($personalityIndex, $level)',
      );
    }
  }

  // Column is hard-coded based on the max mastery level attainable
  @override
  int column(int maxMasteryLevel) => <int>[8, 9, 10][maxMasteryLevel - 1];

  const PersonalitySkill(
    this.prettyName,
    this.level, {
    this.requirements = const <Skill>[],
  }) :
    assert(level >= 1, 'Level must be at least 1'),
    assert(level <= 3, 'Level must be at most 3');
}

/// The mastery associated with a character, holding the list of mastery skills
/// associated with it
enum Personality {
  heavy(<PersonalitySkill>[
    PersonalitySkill.sturdy,
    PersonalitySkill.sturdy2,
    PersonalitySkill.sturdy3,
  ]);

  /// The skills associated with this personality
  final List<PersonalitySkill> skills;

  const Personality(this.skills);
}

/// A skill from a character's unique skill tree
enum UniqueSkill implements Skill {
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  const UniqueSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <Skill>[],
  });
}
