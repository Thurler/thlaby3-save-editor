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
  hpTraining('HP Training', 3, levelGate: LevelGate.second, column: 0),
  hpTraining2(
    'HP Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 0,
    requirements: <Skill>[StatSkill.hpTraining],
  ),
  hpTraining3(
    'HP Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 0,
    requirements: <Skill>[StatSkill.hpTraining2, StatSkill.mpTraining3],
  ),
  hpTraining4(
    'HP Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 0,
    requirements: <Skill>[StatSkill.hpTraining3],
  ),
  mpTraining('MP Training', 3, levelGate: LevelGate.first, column: 0),
  mpTraining2(
    'MP Training+',
    4,
    levelGate: LevelGate.third,
    column: 0,
    requirements: <Skill>[StatSkill.mpTraining],
  ),
  mpTraining3(
    'MP Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 0,
    requirements: <Skill>[
      StatSkill.hpTraining2,
      StatSkill.mpTraining2,
      StatSkill.tpTraining2,
    ],
  ),
  mpTraining4(
    'MP Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 0,
    requirements: <Skill>[StatSkill.mpTraining3],
  ),
  tpTraining('TP Training', 3, levelGate: LevelGate.second, column: 1),
  tpTraining2(
    'TP Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 1,
    requirements: <Skill>[StatSkill.tpTraining],
  ),
  tpTraining3(
    'TP Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 1,
    requirements: <Skill>[StatSkill.tpTraining2, StatSkill.mpTraining3],
  ),
  tpTraining4(
    'TP Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 1,
    requirements: <Skill>[StatSkill.tpTraining3],
  ),
  atkTraining('ATK Training', 3, levelGate: LevelGate.first, column: 2),
  atkTraining2(
    'ATK Training+',
    4,
    levelGate: LevelGate.third,
    column: 2,
    requirements: <Skill>[StatSkill.atkTraining],
  ),
  atkTraining3(
    'ATK Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 2,
    requirements: <Skill>[StatSkill.atkTraining2, StatSkill.defTraining3],
  ),
  atkTraining4(
    'ATK Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 2,
    requirements: <Skill>[StatSkill.atkTraining3],
  ),
  defTraining('DEF Training', 3, levelGate: LevelGate.second, column: 2),
  defTraining2(
    'DEF Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 2,
    requirements: <Skill>[StatSkill.defTraining],
  ),
  defTraining3(
    'DEF Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 2,
    requirements: <Skill>[StatSkill.atkTraining2, StatSkill.defTraining2],
  ),
  defTraining4(
    'DEF Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 2,
    requirements: <Skill>[StatSkill.defTraining3],
  ),
  magTraining('MAG Training', 3, levelGate: LevelGate.first, column: 3),
  magTraining2(
    'MAG Training+',
    4,
    levelGate: LevelGate.third,
    column: 3,
    requirements: <Skill>[StatSkill.magTraining],
  ),
  magTraining3(
    'MAG Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 3,
    requirements: <Skill>[StatSkill.magTraining2, StatSkill.mndTraining3],
  ),
  magTraining4(
    'MAG Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 3,
    requirements: <Skill>[StatSkill.magTraining3],
  ),
  mndTraining('MND Training', 3, levelGate: LevelGate.second, column: 3),
  mndTraining2(
    'MND Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 3,
    requirements: <Skill>[StatSkill.mndTraining],
  ),
  mndTraining3(
    'MND Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 3,
    requirements: <Skill>[StatSkill.magTraining2, StatSkill.mndTraining2],
  ),
  mndTraining4(
    'MND Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 3,
    requirements: <Skill>[StatSkill.mndTraining3],
  ),
  spdTraining('SPD Training', 3, levelGate: LevelGate.first, column: 4),
  spdTraining2(
    'SPD Training+',
    4,
    levelGate: LevelGate.third,
    column: 4,
    requirements: <Skill>[StatSkill.spdTraining],
  ),
  spdTraining3(
    'SPD Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 4,
    requirements: <Skill>[StatSkill.spdTraining2, StatSkill.accTraining3],
  ),
  spdTraining4(
    'SPD Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 4,
    requirements: <Skill>[StatSkill.spdTraining3],
  ),
  accTraining('ACC Training', 3, levelGate: LevelGate.second, column: 4),
  accTraining2(
    'ACC Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 4,
    requirements: <Skill>[StatSkill.accTraining],
  ),
  accTraining3(
    'ACC Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 4,
    requirements: <Skill>[
      StatSkill.spdTraining2,
      StatSkill.accTraining2,
      StatSkill.evaTraining2,
    ],
  ),
  accTraining4(
    'ACC Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 4,
    requirements: <Skill>[StatSkill.accTraining3],
  ),
  evaTraining('EVA Training', 3, levelGate: LevelGate.first, column: 5),
  evaTraining2(
    'EVA Training+',
    4,
    levelGate: LevelGate.third,
    column: 5,
    requirements: <Skill>[StatSkill.evaTraining],
  ),
  evaTraining3(
    'EVA Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 5,
    requirements: <Skill>[StatSkill.accTraining3, StatSkill.evaTraining2],
  ),
  evaTraining4(
    'EVA Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 5,
    requirements: <Skill>[StatSkill.evaTraining3],
  ),
  elementalResistTraining(
    'Elemental Resist Training',
    3,
    levelGate: LevelGate.second,
    column: 5,
  ),
  elementalResistTraining2(
    'Elemental Resist Training+',
    4,
    levelGate: LevelGate.fourth,
    column: 5,
    requirements: <Skill>[StatSkill.elementalResistTraining],
  ),
  elementalResistTraining3(
    'Elemental Resist Training++',
    5,
    levelGate: LevelGate.sixth,
    column: 5,
    requirements: <Skill>[
      StatSkill.elementalResistTraining2,
      StatSkill.ailmentResistTraining2,
    ],
  ),
  elementalResistTraining4(
    'Elemental Resist Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 5,
    requirements: <Skill>[StatSkill.elementalResistTraining3],
  ),
  ailmentResistTraining(
    'Ailment Resist Training',
    3,
    levelGate: LevelGate.first,
    column: 6,
  ),
  ailmentResistTraining2(
    'Ailment Resist Training+',
    4,
    levelGate: LevelGate.third,
    column: 6,
    requirements: <Skill>[StatSkill.ailmentResistTraining],
  ),
  ailmentResistTraining3(
    'Ailment Resist Training++',
    5,
    levelGate: LevelGate.fifth,
    column: 6,
    requirements: <Skill>[
      StatSkill.elementalResistTraining3,
      StatSkill.ailmentResistTraining2,
      StatSkill.handsOnLearning,
    ],
  ),
  ailmentResistTraining4(
    'Ailment Resist Training+++',
    6,
    levelGate: LevelGate.seventh,
    column: 6,
    requirements: <Skill>[StatSkill.ailmentResistTraining3],
  ),
  ambitious('Ambitious', 3, levelGate: LevelGate.second, column: 6),
  ambitious2(
    'Ambitious+',
    4,
    levelGate: LevelGate.fourth,
    column: 6,
    requirements: <Skill>[StatSkill.ambitious],
  ),
  handsOnLearning(
    'Hands-On Learning',
    5,
    levelGate: LevelGate.sixth,
    column: 6,
    requirements: <Skill>[
      StatSkill.ailmentResistTraining2,
      StatSkill.ambitious2,
    ],
  ),
  handsOnLearning2(
    'Hands-On Learning+',
    6,
    levelGate: LevelGate.eighth,
    column: 6,
    requirements: <Skill>[StatSkill.handsOnLearning],
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
    column: 8,
    masteryRequirement: (index: 2, level: 1), // Tertiary mastery
  ),
  body2(
    'Overall Body Training+',
    4,
    levelGate: LevelGate.sixth,
    column: 8,
    requirements: <Skill>[BodySkill.body],
    masteryRequirement: (index: 1, level: 2), // Secondary mastery
  ),
  body3(
    'Overall Body Training++',
    5,
    levelGate: LevelGate.seventh,
    column: 7,
    requirements: <Skill>[BodySkill.body2],
    masteryRequirement: (index: 0, level: 3), // Primary mastery
  ),
  body4(
    'Overall Body Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 7,
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
    column: 10,
    personalityRequirement: (index: 2, level: 1), // Tertiary personality
  ),
  mind2(
    'Overall Mind Training+',
    4,
    levelGate: LevelGate.sixth,
    column: 10,
    requirements: <Skill>[MindSkill.mind],
    personalityRequirement: (index: 1, level: 2), // Secondary personality
  ),
  mind3(
    'Overall Mind Training++',
    5,
    levelGate: LevelGate.seventh,
    column: 9,
    requirements: <Skill>[MindSkill.mind2],
    personalityRequirement: (index: 0, level: 3), // Primary personality
  ),
  mind4(
    'Overall Mind Training+++',
    6,
    levelGate: LevelGate.eighth,
    column: 9,
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

/// A tuple defining a context for mastery and personality skills
typedef ContextLevelTuple = ({int index, int level});

/// A Map that matches context tuples to the respective [LevelGate] associated
/// with that tuple
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

/// A Map that matches context tuples to another tuple, relaying which tuple has
/// which tuple as an additional requirement
typedef SkillRequirementMap = Map<ContextLevelTuple, ContextLevelTuple>;

/// A mastery skill from the mastery section of the common training skill tree
enum MasterySkill with _ContextualPositionSkill {
  arcane('Arcane Mastery', 1),
  arcane2('Arcane Mastery+', 2, requirements: <Skill>[MasterySkill.arcane]),
  arcane3('Arcane Mastery++', 3, requirements: <Skill>[MasterySkill.arcane2]),
  bestial('Bestial Mastery', 1),
  bestial2('Bestial Mastery+', 2, requirements: <Skill>[MasterySkill.bestial]),
  bestial3(
    'Bestial Mastery++',
    3,
    requirements: <Skill>[MasterySkill.bestial2],
  ),
  botanical('Botanical Mastery', 1),
  botanical2(
    'Botanical Mastery+',
    2,
    requirements: <Skill>[MasterySkill.botanical],
  ),
  botanical3(
    'Botanical Mastery++',
    3,
    requirements: <Skill>[MasterySkill.botanical2],
  ),
  cultural('Cultural Mastery', 1),
  cultural2(
    'Cultural Mastery+',
    2,
    requirements: <Skill>[MasterySkill.cultural],
  ),
  cultural3(
    'Cultural Mastery++',
    3,
    requirements: <Skill>[MasterySkill.cultural2],
  ),
  divine('Divine Mastery', 1),
  divine2('Divine Mastery+', 2, requirements: <Skill>[MasterySkill.divine]),
  divine3('Divine Mastery++', 3, requirements: <Skill>[MasterySkill.divine2]),
  elemental('Elemental Mastery', 1),
  elemental2(
    'Elemental Mastery+',
    2,
    requirements: <Skill>[MasterySkill.elemental],
  ),
  elemental3(
    'Elemental Mastery++',
    3,
    requirements: <Skill>[MasterySkill.elemental2],
  ),
  engineering('Engineering Mastery', 1),
  engineering2(
    'Engineering Mastery+',
    2,
    requirements: <Skill>[MasterySkill.engineering],
  ),
  engineering3(
    'Engineering Mastery++',
    3,
    requirements: <Skill>[MasterySkill.engineering2],
  ),
  garment('Garment Mastery', 1),
  garment2('Garment Mastery+', 2, requirements: <Skill>[MasterySkill.garment]),
  garment3(
    'Garment Mastery++',
    3,
    requirements: <Skill>[MasterySkill.garment2],
  ),
  heavy('Heavy Mastery', 1),
  heavy2('Heavy Mastery+', 2, requirements: <Skill>[MasterySkill.heavy]),
  heavy3('Heavy Mastery++', 3, requirements: <Skill>[MasterySkill.heavy2]),
  inorganic('Inorganic Mastery', 1),
  inorganic2(
    'Inorganic Mastery+',
    2,
    requirements: <Skill>[MasterySkill.inorganic],
  ),
  inorganic3(
    'Inorganic Mastery++',
    3,
    requirements: <Skill>[MasterySkill.inorganic2],
  ),
  madness('Madness Mastery', 1),
  madness2('Madness Mastery+', 2, requirements: <Skill>[MasterySkill.madness]),
  madness3(
    'Madness Mastery++',
    3,
    requirements: <Skill>[MasterySkill.madness2],
  ),
  mythical('Mythical Mastery', 1),
  mythical2(
    'Mythical Mastery+',
    2,
    requirements: <Skill>[MasterySkill.mythical],
  ),
  mythical3(
    'Mythical Mastery++',
    3,
    requirements: <Skill>[MasterySkill.mythical2],
  ),
  protective('Protective Mastery', 1),
  protective2(
    'Protective Mastery+',
    2,
    requirements: <Skill>[MasterySkill.protective],
  ),
  protective3(
    'Protective Mastery++',
    3,
    requirements: <Skill>[MasterySkill.protective2],
  ),
  vigor('Vigor Mastery', 1),
  vigor2('Vigor Mastery+', 2, requirements: <Skill>[MasterySkill.vigor]),
  vigor3('Vigor Mastery++', 3, requirements: <Skill>[MasterySkill.vigor2]),
  weaponry('Weaponry Mastery', 1),
  weaponry2(
    'Weaponry Mastery+',
    2,
    requirements: <Skill>[MasterySkill.weaponry],
  ),
  weaponry3(
    'Weaponry Mastery++',
    3,
    requirements: <Skill>[MasterySkill.weaponry2],
  );

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
  int column(int masteryIndex) => <int>[7, 8, 8][masteryIndex];

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
  arcane(<MasterySkill>[
    MasterySkill.arcane,
    MasterySkill.arcane2,
    MasterySkill.arcane3,
  ]),
  bestial(<MasterySkill>[
    MasterySkill.bestial,
    MasterySkill.bestial2,
    MasterySkill.bestial3,
  ]),
  botanical(<MasterySkill>[
    MasterySkill.botanical,
    MasterySkill.botanical2,
    MasterySkill.botanical3,
  ]),
  cultural(<MasterySkill>[
    MasterySkill.cultural,
    MasterySkill.cultural2,
    MasterySkill.cultural3,
  ]),
  divine(<MasterySkill>[
    MasterySkill.divine,
    MasterySkill.divine2,
    MasterySkill.divine3,
  ]),
  elemental(<MasterySkill>[
    MasterySkill.elemental,
    MasterySkill.elemental2,
    MasterySkill.elemental3,
  ]),
  engineering(<MasterySkill>[
    MasterySkill.engineering,
    MasterySkill.engineering2,
    MasterySkill.engineering3,
  ]),
  garment(<MasterySkill>[
    MasterySkill.garment,
    MasterySkill.garment2,
    MasterySkill.garment3,
  ]),
  heavy(<MasterySkill>[
    MasterySkill.heavy,
    MasterySkill.heavy2,
    MasterySkill.heavy3,
  ]),
  inorganic(<MasterySkill>[
    MasterySkill.inorganic,
    MasterySkill.inorganic2,
    MasterySkill.inorganic3,
  ]),
  madness(<MasterySkill>[
    MasterySkill.madness,
    MasterySkill.madness2,
    MasterySkill.madness3,
  ]),
  mythical(<MasterySkill>[
    MasterySkill.mythical,
    MasterySkill.mythical2,
    MasterySkill.mythical3,
  ]),
  protective(<MasterySkill>[
    MasterySkill.protective,
    MasterySkill.protective2,
    MasterySkill.protective3,
  ]),
  vigor(<MasterySkill>[
    MasterySkill.vigor,
    MasterySkill.vigor2,
    MasterySkill.vigor3,
  ]),
  weaponry(<MasterySkill>[
    MasterySkill.weaponry,
    MasterySkill.weaponry2,
    MasterySkill.weaponry3,
  ]);

  /// The skills associated with this mastery
  final List<MasterySkill> skills;

  const Mastery(this.skills);
}

/// A personality skill from the personality section of the common training
/// skill tree
enum PersonalitySkill with _ContextualPositionSkill {
  actuallyNice('Actually Nice', 1),
  actuallyNice2('Actually Nice+', 2, requirements: <Skill>[actuallyNice]),
  actuallyNice3('Actually Nice++', 3, requirements: <Skill>[actuallyNice2]),
  airheaded('Airheaded', 1),
  airheaded2('Airheaded+', 2, requirements: <Skill>[airheaded]),
  airheaded3('Airheaded++', 3, requirements: <Skill>[airheaded2]),
  alluring('Alluring', 1),
  alluring2('Alluring+', 2, requirements: <Skill>[alluring]),
  alluring3('Alluring++', 3, requirements: <Skill>[alluring2]),
  altruistic('Altruistic', 1),
  altruistic2('Altruistic+', 2, requirements: <Skill>[altruistic]),
  altruistic3('Altruistic++', 3, requirements: <Skill>[altruistic2]),
  brainy('Brainy', 1),
  brainy2('Brainy+', 2, requirements: <Skill>[brainy]),
  brainy3('Brainy++', 3, requirements: <Skill>[brainy2]),
  caretaker('Caretaker', 1),
  caretaker2('Caretaker+', 2, requirements: <Skill>[caretaker]),
  caretaker3('Caretaker++', 3, requirements: <Skill>[caretaker2]),
  challengeSeeker('Challenge Seeker', 1),
  challengeSeeker2(
    'Challenge Seeker+',
    2,
    requirements: <Skill>[challengeSeeker],
  ),
  challengeSeeker3(
    'Challenge Seeker++',
    3,
    requirements: <Skill>[challengeSeeker2],
  ),
  cheapskate('Cheapskate', 1),
  cheapskate2('Cheapskate+', 2, requirements: <Skill>[cheapskate]),
  cheapskate3('Cheapskate++', 3, requirements: <Skill>[cheapskate2]),
  cheerful('Cheerful', 1),
  cheerful2('Cheerful+', 2, requirements: <Skill>[cheerful]),
  cheerful3('Cheerful++', 3, requirements: <Skill>[cheerful2]),
  clumsy('Clumsy', 1),
  clumsy2('Clumsy+', 2, requirements: <Skill>[clumsy]),
  clumsy3('Clumsy++', 3, requirements: <Skill>[clumsy2]),
  competitive('Competitive', 1),
  competitive2('Competitive+', 2, requirements: <Skill>[competitive]),
  competitive3('Competitive++', 3, requirements: <Skill>[competitive2]),
  coolHeaded('Cool-Headed', 1),
  coolHeaded2('Cool-Headed+', 2, requirements: <Skill>[coolHeaded]),
  coolHeaded3('Cool-Headed++', 3, requirements: <Skill>[coolHeaded2]),
  courageous('Courageous', 1),
  courageous2('Courageous+', 2, requirements: <Skill>[courageous]),
  courageous3('Courageous++', 3, requirements: <Skill>[courageous2]),
  creative('Creative', 1),
  creative2('Creative+', 2, requirements: <Skill>[creative]),
  creative3('Creative++', 3, requirements: <Skill>[creative2]),
  crude('Crude', 1),
  crude2('Crude+', 2, requirements: <Skill>[crude]),
  crude3('Crude++', 3, requirements: <Skill>[crude2]),
  dense('Dense', 1),
  dense2('Dense+', 2, requirements: <Skill>[dense]),
  dense3('Dense++', 3, requirements: <Skill>[dense2]),
  diligent('Diligent', 1),
  diligent2('Diligent+', 2, requirements: <Skill>[diligent]),
  diligent3('Diligent++', 3, requirements: <Skill>[diligent2]),
  divine('Divine', 1),
  divine2('Divine+', 2, requirements: <Skill>[divine]),
  divine3('Divine++', 3, requirements: <Skill>[divine2]),
  earnest('Earnest', 1),
  earnest2('Earnest+', 2, requirements: <Skill>[earnest]),
  earnest3('Earnest++', 3, requirements: <Skill>[earnest2]),
  easygoing('Easygoing', 1),
  easygoing2('Easygoing+', 2, requirements: <Skill>[easygoing]),
  easygoing3('Easygoing++', 3, requirements: <Skill>[easygoing2]),
  facilitator('Facilitator', 1),
  facilitator2('Facilitator+', 2, requirements: <Skill>[facilitator]),
  facilitator3('Facilitator++', 3, requirements: <Skill>[facilitator2]),
  finisher('Finisher', 1),
  finisher2('Finisher+', 2, requirements: <Skill>[finisher]),
  finisher3('Finisher++', 3, requirements: <Skill>[finisher2]),
  freeSpirited('Free-Spirited', 1),
  freeSpirited2('Free-Spirited+', 2, requirements: <Skill>[freeSpirited]),
  freeSpirited3('Free-Spirited++', 3, requirements: <Skill>[freeSpirited2]),
  goodPerson('Good Person', 1),
  goodPerson2('Good Person+', 2, requirements: <Skill>[goodPerson]),
  goodPerson3('Good Person++', 3, requirements: <Skill>[goodPerson2]),
  grandiose('Grandiose', 1),
  grandiose2('Grandiose+', 2, requirements: <Skill>[grandiose]),
  grandiose3('Grandiose++', 3, requirements: <Skill>[grandiose2]),
  hardWorker('Hard Worker', 1),
  hardWorker2('Hard Worker+', 2, requirements: <Skill>[hardWorker]),
  hardWorker3('Hard Worker++', 3, requirements: <Skill>[hardWorker2]),
  harmonyWithNature('Harmony With Nature', 1),
  harmonyWithNature2(
    'Harmony With Nature+',
    2,
    requirements: <Skill>[harmonyWithNature],
  ),
  harmonyWithNature3(
    'Harmony With Nature++',
    3,
    requirements: <Skill>[harmonyWithNature2],
  ),
  heroic('Heroic', 1),
  heroic2('Heroic+', 2, requirements: <Skill>[heroic]),
  heroic3('Heroic++', 3, requirements: <Skill>[heroic2]),
  innerFacing('Inner-Facing', 1),
  innerFacing2('Inner-Facing+', 2, requirements: <Skill>[innerFacing]),
  innerFacing3('Inner-Facing++', 3, requirements: <Skill>[innerFacing2]),
  intellectual('Intellectual', 1),
  intellectual2('Intellectual+', 2, requirements: <Skill>[intellectual]),
  intellectual3('Intellectual++', 3, requirements: <Skill>[intellectual2]),
  laborer('Laborer', 1),
  laborer2('Laborer+', 2, requirements: <Skill>[laborer]),
  laborer3('Laborer++', 3, requirements: <Skill>[laborer2]),
  laidback('Laidback', 1),
  laidback2('Laidback+', 2, requirements: <Skill>[laidback]),
  laidback3('Laidback++', 3, requirements: <Skill>[laidback2]),
  lively('Lively', 1),
  lively2('Lively+', 2, requirements: <Skill>[lively]),
  lively3('Lively++', 3, requirements: <Skill>[lively2]),
  loner('Loner', 1),
  loner2('Loner+', 2, requirements: <Skill>[loner]),
  loner3('Loner++', 3, requirements: <Skill>[loner2]),
  loyal('Loyal', 1),
  loyal2('Loyal+', 2, requirements: <Skill>[loyal]),
  loyal3('Loyal++', 3, requirements: <Skill>[loyal2]),
  mysterious('Mysterious', 1),
  mysterious2('Mysterious+', 2, requirements: <Skill>[mysterious]),
  mysterious3('Mysterious++', 3, requirements: <Skill>[mysterious2]),
  nihilist('Nihilist', 1),
  nihilist2('Nihilist+', 2, requirements: <Skill>[nihilist]),
  nihilist3('Nihilist++', 3, requirements: <Skill>[nihilist2]),
  nonconformist('Nonconformist', 1),
  nonconformist2('Nonconformist+', 2, requirements: <Skill>[nonconformist]),
  nonconformist3('Nonconformist++', 3, requirements: <Skill>[nonconformist2]),
  outgoing('Outgoing', 1),
  outgoing2('Outgoing+', 2, requirements: <Skill>[outgoing]),
  outgoing3('Outgoing++', 3, requirements: <Skill>[outgoing2]),
  overwhelmingPresence('Overwhelming Presence', 1),
  overwhelmingPresence2(
    'Overwhelming Presence+',
    2,
    requirements: <Skill>[overwhelmingPresence],
  ),
  overwhelmingPresence3(
    'Overwhelming Presence++',
    3,
    requirements: <Skill>[overwhelmingPresence2],
  ),
  passionate('Passionate', 1),
  passionate2('Passionate+', 2, requirements: <Skill>[passionate]),
  passionate3('Passionate++', 3, requirements: <Skill>[passionate2]),
  perfectionist('Perfectionist', 1),
  perfectionist2('Perfectionist+', 2, requirements: <Skill>[perfectionist]),
  perfectionist3('Perfectionist++', 3, requirements: <Skill>[perfectionist2]),
  prankster('Prankster', 1),
  prankster2('Prankster+', 2, requirements: <Skill>[prankster]),
  prankster3('Prankster++', 3, requirements: <Skill>[prankster2]),
  prodigy('Prodigy', 1),
  prodigy2('Prodigy+', 2, requirements: <Skill>[prodigy]),
  prodigy3('Prodigy++', 3, requirements: <Skill>[prodigy2]),
  secretlyCrazy('Secretly Crazy', 1),
  secretlyCrazy2('Secretly Crazy+', 2, requirements: <Skill>[secretlyCrazy]),
  secretlyCrazy3('Secretly Crazy++', 3, requirements: <Skill>[secretlyCrazy2]),
  selfReliant('Self-Reliant', 1),
  selfReliant2('Self-Reliant+', 2, requirements: <Skill>[selfReliant]),
  selfReliant3('Self-Reliant++', 3, requirements: <Skill>[selfReliant2]),
  sensitive('Sensitive', 1),
  sensitive2('Sensitive+', 2, requirements: <Skill>[sensitive]),
  sensitive3('Sensitive++', 3, requirements: <Skill>[sensitive2]),
  solitary('Solitary', 1),
  solitary2('Solitary+', 2, requirements: <Skill>[solitary]),
  solitary3('Solitary++', 3, requirements: <Skill>[solitary2]),
  soltiary('Soltiary', 1),
  soltiary2('Soltiary+', 2, requirements: <Skill>[soltiary]),
  soltiary3('Soltiary++', 3, requirements: <Skill>[soltiary2]),
  speedy('Speedy', 1),
  speedy2('Speedy+', 2, requirements: <Skill>[speedy]),
  speedy3('Speedy++', 3, requirements: <Skill>[speedy2]),
  sturdy('Sturdy', 1),
  sturdy2('Sturdy+', 2, requirements: <Skill>[sturdy]),
  sturdy3('Sturdy++', 3, requirements: <Skill>[sturdy2]),
  supportive('Supportive', 1),
  supportive2('Supportive+', 2, requirements: <Skill>[supportive]),
  supportive3('Supportive++', 3, requirements: <Skill>[supportive2]),
  thorough('Thorough', 1),
  thorough2('Thorough+', 2, requirements: <Skill>[thorough]),
  thorough3('Thorough++', 3, requirements: <Skill>[thorough2]),
  upfront('Upfront', 1),
  upfront2('Upfront+', 2, requirements: <Skill>[upfront]),
  upfront3('Upfront++', 3, requirements: <Skill>[upfront2]);

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
  int column(int personalityIndex) => <int>[9, 10, 10][personalityIndex];

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
  actuallyNice(<PersonalitySkill>[
    PersonalitySkill.actuallyNice,
    PersonalitySkill.actuallyNice2,
    PersonalitySkill.actuallyNice3,
  ]),
  airheaded(<PersonalitySkill>[
    PersonalitySkill.airheaded,
    PersonalitySkill.airheaded2,
    PersonalitySkill.airheaded3,
  ]),
  alluring(<PersonalitySkill>[
    PersonalitySkill.alluring,
    PersonalitySkill.alluring2,
    PersonalitySkill.alluring3,
  ]),
  altruistic(<PersonalitySkill>[
    PersonalitySkill.altruistic,
    PersonalitySkill.altruistic2,
    PersonalitySkill.altruistic3,
  ]),
  brainy(<PersonalitySkill>[
    PersonalitySkill.brainy,
    PersonalitySkill.brainy2,
    PersonalitySkill.brainy3,
  ]),
  caretaker(<PersonalitySkill>[
    PersonalitySkill.caretaker,
    PersonalitySkill.caretaker2,
    PersonalitySkill.caretaker3,
  ]),
  challengeSeeker(<PersonalitySkill>[
    PersonalitySkill.challengeSeeker,
    PersonalitySkill.challengeSeeker2,
    PersonalitySkill.challengeSeeker3,
  ]),
  cheapskate(<PersonalitySkill>[
    PersonalitySkill.cheapskate,
    PersonalitySkill.cheapskate2,
    PersonalitySkill.cheapskate3,
  ]),
  cheerful(<PersonalitySkill>[
    PersonalitySkill.cheerful,
    PersonalitySkill.cheerful2,
    PersonalitySkill.cheerful3,
  ]),
  clumsy(<PersonalitySkill>[
    PersonalitySkill.clumsy,
    PersonalitySkill.clumsy2,
    PersonalitySkill.clumsy3,
  ]),
  competitive(<PersonalitySkill>[
    PersonalitySkill.competitive,
    PersonalitySkill.competitive2,
    PersonalitySkill.competitive3,
  ]),
  coolHeaded(<PersonalitySkill>[
    PersonalitySkill.coolHeaded,
    PersonalitySkill.coolHeaded2,
    PersonalitySkill.coolHeaded3,
  ]),
  courageous(<PersonalitySkill>[
    PersonalitySkill.courageous,
    PersonalitySkill.courageous2,
    PersonalitySkill.courageous3,
  ]),
  creative(<PersonalitySkill>[
    PersonalitySkill.creative,
    PersonalitySkill.creative2,
    PersonalitySkill.creative3,
  ]),
  crude(<PersonalitySkill>[
    PersonalitySkill.crude,
    PersonalitySkill.crude2,
    PersonalitySkill.crude3,
  ]),
  dense(<PersonalitySkill>[
    PersonalitySkill.dense,
    PersonalitySkill.dense2,
    PersonalitySkill.dense3,
  ]),
  diligent(<PersonalitySkill>[
    PersonalitySkill.diligent,
    PersonalitySkill.diligent2,
    PersonalitySkill.diligent3,
  ]),
  divine(<PersonalitySkill>[
    PersonalitySkill.divine,
    PersonalitySkill.divine2,
    PersonalitySkill.divine3,
  ]),
  earnest(<PersonalitySkill>[
    PersonalitySkill.earnest,
    PersonalitySkill.earnest2,
    PersonalitySkill.earnest3,
  ]),
  easygoing(<PersonalitySkill>[
    PersonalitySkill.easygoing,
    PersonalitySkill.easygoing2,
    PersonalitySkill.easygoing3,
  ]),
  facilitator(<PersonalitySkill>[
    PersonalitySkill.facilitator,
    PersonalitySkill.facilitator2,
    PersonalitySkill.facilitator3,
  ]),
  finisher(<PersonalitySkill>[
    PersonalitySkill.finisher,
    PersonalitySkill.finisher2,
    PersonalitySkill.finisher3,
  ]),
  freeSpirited(<PersonalitySkill>[
    PersonalitySkill.freeSpirited,
    PersonalitySkill.freeSpirited2,
    PersonalitySkill.freeSpirited3,
  ]),
  goodPerson(<PersonalitySkill>[
    PersonalitySkill.goodPerson,
    PersonalitySkill.goodPerson2,
    PersonalitySkill.goodPerson3,
  ]),
  grandiose(<PersonalitySkill>[
    PersonalitySkill.grandiose,
    PersonalitySkill.grandiose2,
    PersonalitySkill.grandiose3,
  ]),
  hardWorker(<PersonalitySkill>[
    PersonalitySkill.hardWorker,
    PersonalitySkill.hardWorker2,
    PersonalitySkill.hardWorker3,
  ]),
  harmonyWithNature(<PersonalitySkill>[
    PersonalitySkill.harmonyWithNature,
    PersonalitySkill.harmonyWithNature2,
    PersonalitySkill.harmonyWithNature3,
  ]),
  heroic(<PersonalitySkill>[
    PersonalitySkill.heroic,
    PersonalitySkill.heroic2,
    PersonalitySkill.heroic3,
  ]),
  innerFacing(<PersonalitySkill>[
    PersonalitySkill.innerFacing,
    PersonalitySkill.innerFacing2,
    PersonalitySkill.innerFacing3,
  ]),
  intellectual(<PersonalitySkill>[
    PersonalitySkill.intellectual,
    PersonalitySkill.intellectual2,
    PersonalitySkill.intellectual3,
  ]),
  laborer(<PersonalitySkill>[
    PersonalitySkill.laborer,
    PersonalitySkill.laborer2,
    PersonalitySkill.laborer3,
  ]),
  laidback(<PersonalitySkill>[
    PersonalitySkill.laidback,
    PersonalitySkill.laidback2,
    PersonalitySkill.laidback3,
  ]),
  lively(<PersonalitySkill>[
    PersonalitySkill.lively,
    PersonalitySkill.lively2,
    PersonalitySkill.lively3,
  ]),
  loner(<PersonalitySkill>[
    PersonalitySkill.loner,
    PersonalitySkill.loner2,
    PersonalitySkill.loner3,
  ]),
  loyal(<PersonalitySkill>[
    PersonalitySkill.loyal,
    PersonalitySkill.loyal2,
    PersonalitySkill.loyal3,
  ]),
  mysterious(<PersonalitySkill>[
    PersonalitySkill.mysterious,
    PersonalitySkill.mysterious2,
    PersonalitySkill.mysterious3,
  ]),
  nihilist(<PersonalitySkill>[
    PersonalitySkill.nihilist,
    PersonalitySkill.nihilist2,
    PersonalitySkill.nihilist3,
  ]),
  nonconformist(<PersonalitySkill>[
    PersonalitySkill.nonconformist,
    PersonalitySkill.nonconformist2,
    PersonalitySkill.nonconformist3,
  ]),
  outgoing(<PersonalitySkill>[
    PersonalitySkill.outgoing,
    PersonalitySkill.outgoing2,
    PersonalitySkill.outgoing3,
  ]),
  overwhelmingPresence(<PersonalitySkill>[
    PersonalitySkill.overwhelmingPresence,
    PersonalitySkill.overwhelmingPresence2,
    PersonalitySkill.overwhelmingPresence3,
  ]),
  passionate(<PersonalitySkill>[
    PersonalitySkill.passionate,
    PersonalitySkill.passionate2,
    PersonalitySkill.passionate3,
  ]),
  perfectionist(<PersonalitySkill>[
    PersonalitySkill.perfectionist,
    PersonalitySkill.perfectionist2,
    PersonalitySkill.perfectionist3,
  ]),
  prankster(<PersonalitySkill>[
    PersonalitySkill.prankster,
    PersonalitySkill.prankster2,
    PersonalitySkill.prankster3,
  ]),
  prodigy(<PersonalitySkill>[
    PersonalitySkill.prodigy,
    PersonalitySkill.prodigy2,
    PersonalitySkill.prodigy3,
  ]),
  secretlyCrazy(<PersonalitySkill>[
    PersonalitySkill.secretlyCrazy,
    PersonalitySkill.secretlyCrazy2,
    PersonalitySkill.secretlyCrazy3,
  ]),
  selfReliant(<PersonalitySkill>[
    PersonalitySkill.selfReliant,
    PersonalitySkill.selfReliant2,
    PersonalitySkill.selfReliant3,
  ]),
  sensitive(<PersonalitySkill>[
    PersonalitySkill.sensitive,
    PersonalitySkill.sensitive2,
    PersonalitySkill.sensitive3,
  ]),
  solitary(<PersonalitySkill>[
    PersonalitySkill.solitary,
    PersonalitySkill.solitary2,
    PersonalitySkill.solitary3,
  ]),
  soltiary(<PersonalitySkill>[
    PersonalitySkill.soltiary,
    PersonalitySkill.soltiary2,
    PersonalitySkill.soltiary3,
  ]),
  speedy(<PersonalitySkill>[
    PersonalitySkill.speedy,
    PersonalitySkill.speedy2,
    PersonalitySkill.speedy3,
  ]),
  sturdy(<PersonalitySkill>[
    PersonalitySkill.sturdy,
    PersonalitySkill.sturdy2,
    PersonalitySkill.sturdy3,
  ]),
  supportive(<PersonalitySkill>[
    PersonalitySkill.supportive,
    PersonalitySkill.supportive2,
    PersonalitySkill.supportive3,
  ]),
  thorough(<PersonalitySkill>[
    PersonalitySkill.thorough,
    PersonalitySkill.thorough2,
    PersonalitySkill.thorough3,
  ]),
  upfront(<PersonalitySkill>[
    PersonalitySkill.upfront,
    PersonalitySkill.upfront2,
    PersonalitySkill.upfront3,
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
  List<Skill> get requirements => const <Skill>[];

  const UniqueSkill(this.prettyName, this.cost);
}
