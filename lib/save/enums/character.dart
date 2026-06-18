import 'package:thlaby3_save_editor/save/enums/skills/training.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// The characters in the game and the static data relating to their in-game
/// attributes
enum Character {
  reimu(
    <Mastery>[Mastery.mythical, Mastery.divine, Mastery.arcane],
    <Personality>[
      Personality.prodigy,
      Personality.freeSpirited,
      Personality.facilitator,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  renko(
    <Mastery>[Mastery.cultural, Mastery.madness, Mastery.engineering],
    <Personality>[
      Personality.facilitator,
      Personality.brainy,
      Personality.altruistic,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  maribel(
    <Mastery>[Mastery.cultural, Mastery.divine, Mastery.arcane],
    <Personality>[
      Personality.upfront,
      Personality.airheaded,
      Personality.innerFacing,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  meiling(
    <Mastery>[Mastery.vigor, Mastery.botanical, Mastery.heavy],
    <Personality>[
      Personality.laborer,
      Personality.easygoing,
      Personality.sturdy,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  alice(
    <Mastery>[Mastery.inorganic, Mastery.arcane, Mastery.engineering],
    <Personality>[
      Personality.perfectionist,
      Personality.creative,
      Personality.actuallyNice,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  nitori(
    <Mastery>[Mastery.engineering, Mastery.cultural, Mastery.heavy],
    <Personality>[
      Personality.cheapskate,
      Personality.diligent,
      Personality.outgoing,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  aya(
    <Mastery>[Mastery.weaponry, Mastery.bestial, Mastery.inorganic],
    <Personality>[
      Personality.speedy,
      Personality.nihilist,
      Personality.perfectionist,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  patchouli(
    <Mastery>[Mastery.arcane, Mastery.elemental, Mastery.cultural],
    <Personality>[Personality.brainy, Personality.loner, Personality.dense],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  cirno(
    <Mastery>[Mastery.vigor, Mastery.elemental, Mastery.botanical],
    <Personality>[
      Personality.prankster,
      Personality.lively,
      Personality.courageous,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  keine(
    <Mastery>[Mastery.cultural, Mastery.mythical, Mastery.protective],
    <Personality>[
      Personality.diligent,
      Personality.altruistic,
      Personality.caretaker,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  doremy(
    <Mastery>[Mastery.madness, Mastery.garment, Mastery.vigor],
    <Personality>[
      Personality.freeSpirited,
      Personality.mysterious,
      Personality.supportive,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  yukari(
    <Mastery>[Mastery.mythical, Mastery.arcane, Mastery.cultural],
    <Personality>[
      Personality.overwhelmingPresence,
      Personality.innerFacing,
      Personality.caretaker,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  marisa(
    <Mastery>[Mastery.arcane, Mastery.garment, Mastery.elemental],
    <Personality>[
      Personality.hardWorker,
      Personality.heroic,
      Personality.passionate,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  koishi(
    <Mastery>[Mastery.madness, Mastery.inorganic, Mastery.garment],
    <Personality>[
      Personality.selfReliant,
      Personality.innerFacing,
      Personality.finisher,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  sumireko(
    <Mastery>[Mastery.divine, Mastery.engineering, Mastery.cultural],
    <Personality>[
      Personality.challengeSeeker,
      Personality.courageous,
      Personality.heroic,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  ran(
    <Mastery>[Mastery.bestial, Mastery.arcane, Mastery.divine],
    <Personality>[Personality.alluring, Personality.earnest, Personality.loyal],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  chen(
    <Mastery>[Mastery.bestial, Mastery.vigor, Mastery.botanical],
    <Personality>[Personality.lively, Personality.clumsy, Personality.speedy],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  sanae(
    <Mastery>[Mastery.garment, Mastery.cultural, Mastery.engineering],
    <Personality>[
      Personality.laidback,
      Personality.supportive,
      Personality.harmonyWithNature,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  kanako(
    <Mastery>[Mastery.heavy, Mastery.engineering, Mastery.inorganic],
    <Personality>[
      Personality.divine,
      Personality.outgoing,
      Personality.overwhelmingPresence,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  suwako(
    <Mastery>[Mastery.botanical, Mastery.mythical, Mastery.garment],
    <Personality>[
      Personality.cheerful,
      Personality.airheaded,
      Personality.divine,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  remilia(
    <Mastery>[Mastery.heavy, Mastery.vigor, Mastery.mythical],
    <Personality>[
      Personality.grandiose,
      Personality.overwhelmingPresence,
      Personality.thorough,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  sakuya(
    <Mastery>[Mastery.weaponry, Mastery.inorganic, Mastery.madness],
    <Personality>[
      Personality.mysterious,
      Personality.secretlyCrazy,
      Personality.coolHeaded,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  junko(
    <Mastery>[Mastery.divine, Mastery.arcane, Mastery.bestial],
    <Personality>[
      Personality.coolHeaded,
      Personality.mysterious,
      Personality.divine,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  hecatia(
    <Mastery>[Mastery.heavy, Mastery.elemental, Mastery.madness],
    <Personality>[
      Personality.nonconformist,
      Personality.divine,
      Personality.selfReliant,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  youmu(
    <Mastery>[Mastery.weaponry, Mastery.protective, Mastery.inorganic],
    <Personality>[
      Personality.hardWorker,
      Personality.laborer,
      Personality.dense,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  rumia(
    <Mastery>[Mastery.elemental, Mastery.vigor, Mastery.garment],
    <Personality>[
      Personality.laidback,
      Personality.dense,
      Personality.airheaded,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  kogasa(
    <Mastery>[Mastery.inorganic, Mastery.botanical, Mastery.protective],
    <Personality>[
      Personality.laborer,
      Personality.sensitive,
      Personality.loyal,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  reisen(
    <Mastery>[Mastery.madness, Mastery.bestial, Mastery.divine],
    <Personality>[
      Personality.thorough,
      Personality.hardWorker,
      Personality.facilitator,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  rin(
    <Mastery>[Mastery.bestial, Mastery.weaponry, Mastery.madness],
    <Personality>[
      Personality.upfront,
      Personality.alluring,
      Personality.nihilist,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  kasen(
    <Mastery>[Mastery.botanical, Mastery.bestial, Mastery.heavy],
    <Personality>[
      Personality.caretaker,
      Personality.goodPerson,
      Personality.harmonyWithNature,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  yuugi(
    <Mastery>[Mastery.heavy, Mastery.protective, Mastery.madness],
    <Personality>[
      Personality.competitive,
      Personality.challengeSeeker,
      Personality.sturdy,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  suika(
    <Mastery>[Mastery.inorganic, Mastery.heavy, Mastery.weaponry],
    <Personality>[
      Personality.crude,
      Personality.freeSpirited,
      Personality.thorough,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  wriggle(
    <Mastery>[Mastery.botanical, Mastery.protective, Mastery.elemental],
    <Personality>[
      Personality.harmonyWithNature,
      Personality.clumsy,
      Personality.laborer,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  mystia(
    <Mastery>[Mastery.bestial, Mastery.vigor, Mastery.weaponry],
    <Personality>[
      Personality.laidback,
      Personality.cheerful,
      Personality.passionate,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  eirin(
    <Mastery>[Mastery.mythical, Mastery.divine, Mastery.weaponry],
    <Personality>[
      Personality.intellectual,
      Personality.brainy,
      Personality.coolHeaded,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  byakuren(
    <Mastery>[Mastery.arcane, Mastery.mythical, Mastery.vigor],
    <Personality>[
      Personality.altruistic,
      Personality.goodPerson,
      Personality.speedy,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  iku(
    <Mastery>[Mastery.garment, Mastery.protective, Mastery.elemental],
    <Personality>[
      Personality.supportive,
      Personality.harmonyWithNature,
      Personality.easygoing,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  momiji(
    <Mastery>[Mastery.protective, Mastery.weaponry, Mastery.bestial],
    <Personality>[Personality.loyal, Personality.earnest, Personality.diligent],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  tenshi(
    <Mastery>[Mastery.protective, Mastery.botanical, Mastery.heavy],
    <Personality>[Personality.crude, Personality.grandiose, Personality.sturdy],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  yuyuko(
    <Mastery>[Mastery.garment, Mastery.heavy, Mastery.divine],
    <Personality>[
      Personality.freeSpirited,
      Personality.prankster,
      Personality.alluring,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  mokou(
    <Mastery>[Mastery.elemental, Mastery.vigor, Mastery.mythical],
    <Personality>[
      Personality.solitary,
      Personality.challengeSeeker,
      Personality.actuallyNice,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  kokoro(
    <Mastery>[Mastery.inorganic, Mastery.weaponry, Mastery.madness],
    <Personality>[
      Personality.laidback,
      Personality.solitary,
      Personality.clumsy,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  satori(
    <Mastery>[Mastery.garment, Mastery.madness, Mastery.botanical],
    <Personality>[
      Personality.coolHeaded,
      Personality.loner,
      Personality.sensitive,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  utsuho(
    <Mastery>[Mastery.elemental, Mastery.bestial, Mastery.vigor],
    <Personality>[
      Personality.airheaded,
      Personality.cheerful,
      Personality.nonconformist,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  kaguya(
    <Mastery>[Mastery.elemental, Mastery.mythical, Mastery.cultural],
    <Personality>[
      Personality.thorough,
      Personality.nihilist,
      Personality.finisher,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  flandre(
    <Mastery>[Mastery.madness, Mastery.heavy, Mastery.arcane],
    <Personality>[
      Personality.secretlyCrazy,
      Personality.loner,
      Personality.competitive,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  sagume(
    <Mastery>[Mastery.protective, Mastery.mythical, Mastery.divine],
    <Personality>[
      Personality.soltiary,
      Personality.creative,
      Personality.mysterious,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  ),
  miko(
    <Mastery>[Mastery.mythical, Mastery.weaponry, Mastery.inorganic],
    <Personality>[
      Personality.prodigy,
      Personality.grandiose,
      Personality.nonconformist,
    ],
    <LevelGate, Map<int, UniqueSkill>>{},
  );

  /// The filename to use when reading character portraits
  String get filename => (index + 1).toString().padLeft(3, '0');

  /// The unique skills in this character's unique skill tree
  final Map<LevelGate, Map<int, UniqueSkill>> uniqueSkills;

  /// The masteries this character has in the training skill tree
  final List<Mastery> masteries;

  /// The personalities this character has in the training skill tree
  final List<Personality> personalities;

  const Character(
    this.masteries,
    this.personalities,
    this.uniqueSkills,
  );
}
