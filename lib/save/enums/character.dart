import 'package:thlaby3_save_editor/save/enums/skill.dart';
import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// A struct to hold data regarding a character's unique skill data for their
/// skill tree
typedef UniqueSkillData = ({
  UniqueSkill skill,
  LevelGate levelGate,
  int column,
});

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
    <UniqueSkillData>[],
  ),
  renko(
    <Mastery>[Mastery.cultural, Mastery.madness, Mastery.engineering],
    <Personality>[
      Personality.facilitator,
      Personality.brainy,
      Personality.altruistic,
    ],
    <UniqueSkillData>[],
  ),
  maribel(
    <Mastery>[Mastery.cultural, Mastery.divine, Mastery.arcane],
    <Personality>[
      Personality.upfront,
      Personality.airheaded,
      Personality.innerFacing,
    ],
    <UniqueSkillData>[],
  ),
  meiling(
    <Mastery>[Mastery.vigor, Mastery.botanical, Mastery.heavy],
    <Personality>[
      Personality.laborer,
      Personality.easygoing,
      Personality.sturdy,
    ],
    <UniqueSkillData>[],
  ),
  alice(
    <Mastery>[Mastery.inorganic, Mastery.arcane, Mastery.engineering],
    <Personality>[
      Personality.perfectionist,
      Personality.creative,
      Personality.actuallyNice,
    ],
    <UniqueSkillData>[],
  ),
  nitori(
    <Mastery>[Mastery.engineering, Mastery.cultural, Mastery.heavy],
    <Personality>[
      Personality.cheapskate,
      Personality.diligent,
      Personality.outgoing,
    ],
    <UniqueSkillData>[],
  ),
  aya(
    <Mastery>[Mastery.weaponry, Mastery.bestial, Mastery.inorganic],
    <Personality>[
      Personality.speedy,
      Personality.nihilist,
      Personality.perfectionist,
    ],
    <UniqueSkillData>[],
  ),
  patchouli(
    <Mastery>[Mastery.arcane, Mastery.elemental, Mastery.cultural],
    <Personality>[Personality.brainy, Personality.loner, Personality.dense],
    <UniqueSkillData>[],
  ),
  cirno(
    <Mastery>[Mastery.vigor, Mastery.elemental, Mastery.botanical],
    <Personality>[
      Personality.prankster,
      Personality.lively,
      Personality.courageous,
    ],
    <UniqueSkillData>[],
  ),
  keine(
    <Mastery>[Mastery.cultural, Mastery.mythical, Mastery.protective],
    <Personality>[
      Personality.diligent,
      Personality.altruistic,
      Personality.caretaker,
    ],
    <UniqueSkillData>[],
  ),
  doremy(
    <Mastery>[Mastery.madness, Mastery.garment, Mastery.vigor],
    <Personality>[
      Personality.freeSpirited,
      Personality.mysterious,
      Personality.supportive,
    ],
    <UniqueSkillData>[],
  ),
  yukari(
    <Mastery>[Mastery.mythical, Mastery.arcane, Mastery.cultural],
    <Personality>[
      Personality.overwhelmingPresence,
      Personality.innerFacing,
      Personality.caretaker,
    ],
    <UniqueSkillData>[],
  ),
  marisa(
    <Mastery>[Mastery.arcane, Mastery.garment, Mastery.elemental],
    <Personality>[
      Personality.hardWorker,
      Personality.heroic,
      Personality.passionate,
    ],
    <UniqueSkillData>[],
  ),
  koishi(
    <Mastery>[Mastery.madness, Mastery.inorganic, Mastery.garment],
    <Personality>[
      Personality.selfReliant,
      Personality.innerFacing,
      Personality.finisher,
    ],
    <UniqueSkillData>[],
  ),
  sumireko(
    <Mastery>[Mastery.divine, Mastery.engineering, Mastery.cultural],
    <Personality>[
      Personality.challengeSeeker,
      Personality.courageous,
      Personality.heroic,
    ],
    <UniqueSkillData>[],
  ),
  ran(
    <Mastery>[Mastery.bestial, Mastery.arcane, Mastery.divine],
    <Personality>[Personality.alluring, Personality.earnest, Personality.loyal],
    <UniqueSkillData>[],
  ),
  chen(
    <Mastery>[Mastery.bestial, Mastery.vigor, Mastery.botanical],
    <Personality>[Personality.lively, Personality.clumsy, Personality.speedy],
    <UniqueSkillData>[],
  ),
  sanae(
    <Mastery>[Mastery.garment, Mastery.cultural, Mastery.engineering],
    <Personality>[
      Personality.laidback,
      Personality.supportive,
      Personality.harmonyWithNature,
    ],
    <UniqueSkillData>[],
  ),
  kanako(
    <Mastery>[Mastery.heavy, Mastery.engineering, Mastery.inorganic],
    <Personality>[
      Personality.divine,
      Personality.outgoing,
      Personality.overwhelmingPresence,
    ],
    <UniqueSkillData>[],
  ),
  suwako(
    <Mastery>[Mastery.botanical, Mastery.mythical, Mastery.garment],
    <Personality>[
      Personality.cheerful,
      Personality.airheaded,
      Personality.divine,
    ],
    <UniqueSkillData>[],
  ),
  remilia(
    <Mastery>[Mastery.heavy, Mastery.vigor, Mastery.mythical],
    <Personality>[
      Personality.grandiose,
      Personality.overwhelmingPresence,
      Personality.thorough,
    ],
    <UniqueSkillData>[],
  ),
  sakuya(
    <Mastery>[Mastery.weaponry, Mastery.inorganic, Mastery.madness],
    <Personality>[
      Personality.mysterious,
      Personality.secretlyCrazy,
      Personality.coolHeaded,
    ],
    <UniqueSkillData>[],
  ),
  junko(
    <Mastery>[Mastery.divine, Mastery.arcane, Mastery.bestial],
    <Personality>[
      Personality.coolHeaded,
      Personality.mysterious,
      Personality.divine,
    ],
    <UniqueSkillData>[],
  ),
  hecatia(
    <Mastery>[Mastery.heavy, Mastery.elemental, Mastery.madness],
    <Personality>[
      Personality.nonconformist,
      Personality.divine,
      Personality.selfReliant,
    ],
    <UniqueSkillData>[],
  ),
  youmu(
    <Mastery>[Mastery.weaponry, Mastery.protective, Mastery.inorganic],
    <Personality>[
      Personality.hardWorker,
      Personality.laborer,
      Personality.dense,
    ],
    <UniqueSkillData>[],
  ),
  rumia(
    <Mastery>[Mastery.elemental, Mastery.vigor, Mastery.garment],
    <Personality>[
      Personality.laidback,
      Personality.dense,
      Personality.airheaded,
    ],
    <UniqueSkillData>[],
  ),
  kogasa(
    <Mastery>[Mastery.inorganic, Mastery.botanical, Mastery.protective],
    <Personality>[
      Personality.laborer,
      Personality.sensitive,
      Personality.loyal,
    ],
    <UniqueSkillData>[],
  ),
  reisen(
    <Mastery>[Mastery.madness, Mastery.bestial, Mastery.divine],
    <Personality>[
      Personality.thorough,
      Personality.hardWorker,
      Personality.facilitator,
    ],
    <UniqueSkillData>[],
  ),
  rin(
    <Mastery>[Mastery.bestial, Mastery.weaponry, Mastery.madness],
    <Personality>[
      Personality.upfront,
      Personality.alluring,
      Personality.nihilist,
    ],
    <UniqueSkillData>[],
  ),
  kasen(
    <Mastery>[Mastery.botanical, Mastery.bestial, Mastery.heavy],
    <Personality>[
      Personality.caretaker,
      Personality.goodPerson,
      Personality.harmonyWithNature,
    ],
    <UniqueSkillData>[],
  ),
  yuugi(
    <Mastery>[Mastery.heavy, Mastery.protective, Mastery.madness],
    <Personality>[
      Personality.competitive,
      Personality.challengeSeeker,
      Personality.sturdy,
    ],
    <UniqueSkillData>[],
  ),
  suika(
    <Mastery>[Mastery.inorganic, Mastery.heavy, Mastery.weaponry],
    <Personality>[
      Personality.crude,
      Personality.freeSpirited,
      Personality.thorough,
    ],
    <UniqueSkillData>[],
  ),
  wriggle(
    <Mastery>[Mastery.botanical, Mastery.protective, Mastery.elemental],
    <Personality>[
      Personality.harmonyWithNature,
      Personality.clumsy,
      Personality.laborer,
    ],
    <UniqueSkillData>[],
  ),
  mystia(
    <Mastery>[Mastery.bestial, Mastery.vigor, Mastery.weaponry],
    <Personality>[
      Personality.laidback,
      Personality.cheerful,
      Personality.passionate,
    ],
    <UniqueSkillData>[],
  ),
  eirin(
    <Mastery>[Mastery.mythical, Mastery.divine, Mastery.weaponry],
    <Personality>[
      Personality.intellectual,
      Personality.brainy,
      Personality.coolHeaded,
    ],
    <UniqueSkillData>[],
  ),
  byakuren(
    <Mastery>[Mastery.arcane, Mastery.mythical, Mastery.vigor],
    <Personality>[
      Personality.altruistic,
      Personality.goodPerson,
      Personality.speedy,
    ],
    <UniqueSkillData>[],
  ),
  iku(
    <Mastery>[Mastery.garment, Mastery.protective, Mastery.elemental],
    <Personality>[
      Personality.supportive,
      Personality.harmonyWithNature,
      Personality.easygoing,
    ],
    <UniqueSkillData>[],
  ),
  momiji(
    <Mastery>[Mastery.protective, Mastery.weaponry, Mastery.bestial],
    <Personality>[Personality.loyal, Personality.earnest, Personality.diligent],
    <UniqueSkillData>[],
  ),
  tenshi(
    <Mastery>[Mastery.protective, Mastery.botanical, Mastery.heavy],
    <Personality>[Personality.crude, Personality.grandiose, Personality.sturdy],
    <UniqueSkillData>[],
  ),
  yuyuko(
    <Mastery>[Mastery.garment, Mastery.heavy, Mastery.divine],
    <Personality>[
      Personality.freeSpirited,
      Personality.prankster,
      Personality.alluring,
    ],
    <UniqueSkillData>[],
  ),
  mokou(
    <Mastery>[Mastery.elemental, Mastery.vigor, Mastery.mythical],
    <Personality>[
      Personality.solitary,
      Personality.challengeSeeker,
      Personality.actuallyNice,
    ],
    <UniqueSkillData>[],
  ),
  kokoro(
    <Mastery>[Mastery.inorganic, Mastery.weaponry, Mastery.madness],
    <Personality>[
      Personality.laidback,
      Personality.solitary,
      Personality.clumsy,
    ],
    <UniqueSkillData>[],
  ),
  satori(
    <Mastery>[Mastery.garment, Mastery.madness, Mastery.botanical],
    <Personality>[
      Personality.coolHeaded,
      Personality.loner,
      Personality.sensitive,
    ],
    <UniqueSkillData>[],
  ),
  utsuho(
    <Mastery>[Mastery.elemental, Mastery.bestial, Mastery.vigor],
    <Personality>[
      Personality.airheaded,
      Personality.cheerful,
      Personality.nonconformist,
    ],
    <UniqueSkillData>[],
  ),
  kaguya(
    <Mastery>[Mastery.elemental, Mastery.mythical, Mastery.cultural],
    <Personality>[
      Personality.thorough,
      Personality.nihilist,
      Personality.finisher,
    ],
    <UniqueSkillData>[],
  ),
  flandre(
    <Mastery>[Mastery.madness, Mastery.heavy, Mastery.arcane],
    <Personality>[
      Personality.secretlyCrazy,
      Personality.loner,
      Personality.competitive,
    ],
    <UniqueSkillData>[],
  ),
  sagume(
    <Mastery>[Mastery.protective, Mastery.mythical, Mastery.divine],
    <Personality>[
      Personality.soltiary,
      Personality.creative,
      Personality.mysterious,
    ],
    <UniqueSkillData>[],
  ),
  miko(
    <Mastery>[Mastery.mythical, Mastery.weaponry, Mastery.inorganic],
    <Personality>[
      Personality.prodigy,
      Personality.grandiose,
      Personality.nonconformist,
    ],
    <UniqueSkillData>[],
  );

  /// The filename to use when reading character portraits
  String get filename => (index + 1).toString().padLeft(3, '0');

  /// The unique skills in this character's unique skill tree
  final List<UniqueSkillData> uniqueSkills;

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
