import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/debuff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

const DamageSpell eagerSupport = _EagerSupport();
const NaturalAugment eagerSupportCleanse = _EagerSupportCleanse();
const SpellAugmentSkill eagerSupportMentalCare = _EagerSupportMentalCare();

const DamageSpell firstAid = _FirstAid();
const SpellAugmentSkill firstAidTraining = _FirstAidTraining();

const SpellSkill warningBeacon = _WarningBeacon();
const SpellAugmentSkill warningBeacon2 = _WarningBeacon2();

const SpellSkill signalBeacon = _SignalBeacon();
const SpellAugmentSkill signalBeacon2 = _SignalBeacon2();

const SpellSkill swiftBeacon = _SwiftBeacon();
const SpellSkill targetBeacon = _TargetBeacon();

const NaturalAugment _beaconSpecialist = _BeaconSpecialist();
const SkillAugmentSkill adeptBeaconSpecialist = _AdeptBeaconSpecialist();

const UniqueSkill readingStars = _ReadingStars();

const RaceSlayerSkill knowledgeStrangeThings = _KnowledgeStrangeThings();

const UniqueSkill maryShield = _MaryShield();

class _EagerSupport
    implements
        MagicSpell,
        NaturallyAugmentedSkill,
        CooldownSpell,
        FlatMpHealer,
        AtbIncreaser {
  const _EagerSupport();

  @override
  String get prettyName => 'Eager Support';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<NaturalAugment> get naturalAugments =>
      const <NaturalAugment>[eagerSupportCleanse];

  @override
  int get mpCost => 4;

  @override
  int get delay => 7000;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.mys];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  int get accModifider => 10000;

  @override
  double get multiplier => 50;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 0;

  @override
  double get magFactor => -10;

  @override
  int get mpHealAmount => 6;

  @override
  int get atbIncrease => 1200;
}

class _EagerSupportCleanse
    implements
        NaturalAugment,
        TerrorCleanser,
        SilenceCleanser,
        AllDebuffCleanser {
  const _EagerSupportCleanse();

  @override
  UniqueSkill get baseSkill => eagerSupport;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[RandomNumberRequirement(50)];
}

class _EagerSupportMentalCare
    implements SpellNaturalAugmentChainSkill, ConditionedEffect {
  const _EagerSupportMentalCare();

  @override
  String get prettyName => 'Eager Support: Mental Care Boost';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[eagerSupport];

  @override
  SpellSkill get baseSkill => eagerSupport;

  @override
  NaturalAugment get baseAugment => eagerSupportCleanse;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[RandomNumberRequirement(80)];
}

class _FirstAid implements DirectSpell, MagicSpell, CooldownSpell {
  const _FirstAid();

  @override
  String get prettyName => 'First Aid';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 6;

  @override
  int get delay => 6000;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.phy];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  int get accModifider => 10000;

  @override
  double get multiplier => 150;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => -12;

  @override
  double get magFactor => -12;
}

class _FirstAidTraining implements SpellAugmentSkill, MultiplierAugment {
  const _FirstAidTraining();

  @override
  String get prettyName => 'First Aid: First Aid Training';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[firstAid];

  @override
  DamageSpell get baseSkill => firstAid;

  @override
  double get multiplier => 50;
}

abstract class _BeaconSpell
    implements ConditionedSpellSkill, NaturallyAugmentedSkill {
  const _BeaconSpell();

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allAllies;

  @override
  List<NaturalAugment> get naturalAugments =>
      const <NaturalAugment>[_beaconSpecialist];
}

class _BeaconSpecialist
    implements NaturalAugment, CustomAugmentRange, DamageReceivedBuffAugment {
  const _BeaconSpecialist();

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.beaconSpecialist),
  ];

  @override
  UniqueSkill get baseSkill =>
      throw Exception('Beacon Specialist applies to multiple skills');

  @override
  AugmentRange get augmentRange => AugmentRange.self;

  @override
  double get dmgReceivedBuff => 15;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _AdeptBeaconSpecialist
    implements NaturalAugmentChainSkill, DamageReceivedBuffAugment {
  const _AdeptBeaconSpecialist();

  @override
  String get prettyName => 'Adept Beacon Specialist';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[swiftBeacon, PassiveSkill.beaconSpecialist, targetBeacon];

  @override
  UniqueSkill get baseSkill =>
      throw Exception('Adept Beacon Specialist applies to multiple skills');

  @override
  NaturalAugment get baseAugment => _beaconSpecialist;

  @override
  double get dmgReceivedBuff => 25;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _WarningBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, DefenseBuffer, MindBuffer {
  const _WarningBeacon();

  @override
  String get prettyName => 'Warning Beacon';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 10;

  @override
  int get delay => 5000;

  @override
  List<Element> get elements => const <Element>[Element.cld];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get defBuff => 22;

  @override
  int get mndBuff => 22;
}

class _WarningBeacon2
    implements SpellAugmentSkill, DefenseBuffAugment, MindBuffAugment {
  const _WarningBeacon2();

  @override
  String get prettyName => 'Warning Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[warningBeacon];

  @override
  SpellSkill get baseSkill => warningBeacon;

  @override
  int get defBuff => 8;

  @override
  int get mndBuff => 8;
}

class _SignalBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, AttackBuffer, MagicBuffer {
  const _SignalBeacon();

  @override
  String get prettyName => 'Signal Beacon';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 10;

  @override
  int get delay => 5000;

  @override
  List<Element> get elements => const <Element>[Element.fir];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get atkBuff => 15;

  @override
  int get magBuff => 15;
}

class _SignalBeacon2
    implements SpellAugmentSkill, AttackBuffAugment, MagicBuffAugment {
  const _SignalBeacon2();

  @override
  String get prettyName => 'Signal Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[signalBeacon];

  @override
  SpellSkill get baseSkill => signalBeacon;

  @override
  int get atkBuff => 7;

  @override
  int get magBuff => 7;
}

class _SwiftBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, SpeedBuffer {
  const _SwiftBeacon();

  @override
  String get prettyName => 'Swift Beacon';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[warningBeacon];

  @override
  int get mpCost => 12;

  @override
  int get delay => 5000;

  @override
  List<Element> get elements => const <Element>[Element.wnd];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get spdBuff => 22;
}

class _TargetBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, AccuracyBuffer {
  const _TargetBeacon();

  @override
  String get prettyName => 'Target Beacon';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[signalBeacon];

  @override
  int get mpCost => 12;

  @override
  int get delay => 5000;

  @override
  List<Element> get elements => const <Element>[Element.ntr];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get accBuff => 15;
}

class _ReadingStars implements UniqueSkill, AtbInitiativeIncreaser {
  const _ReadingStars();

  @override
  String get prettyName => "Reading the Stars' Positions";

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get atbIncrease => 800;

  @override
  InitiativeRange get initiativeRange => InitiativeRange.frontline;
}

class _KnowledgeStrangeThings implements RaceSlayerSkill, ConditionedEffect {
  const _KnowledgeStrangeThings();

  @override
  String get prettyName => 'Knowledge of Strange Things';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  List<EnemyRace> get races => const <EnemyRace>[EnemyRace.other];

  @override
  double get slayBonus => 12;
}

class _MaryShield
    implements
        UniqueSkill,
        ConditionedEffect,
        AllIncreaser,
        PercentDamageReducer {
  const _MaryShield();

  @override
  String get prettyName => "Mary's Shield";

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    FrontlineSelfRequirement(),
    FrontlineCharacterRequirement(Character.maribel),
  ];

  @override
  int get atkIncrease => 10;

  @override
  int get defIncrease => 10;

  @override
  int get magIncrease => 10;

  @override
  int get mndIncrease => 10;

  @override
  int get spdIncrease => 10;

  @override
  int get accIncrease => 10;

  @override
  int get evaIncrease => 10;

  @override
  double get dmgReducedPercent => 12;
}
