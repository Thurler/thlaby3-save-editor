import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/debuff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/turn_count.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

const DamageSpell eagerSupport = _EagerSupport();
const NaturalAugment eagerSupportCleanse = _EagerSupportCleanse();
const SpellAugmentSkill eagerSupportMentalCare = _EagerSupportMentalCare();
const SpellAugmentSkill eagerSupportSelfCare = _EagerSupportSelfCare();
const SpellAugmentSkill eagerSupportDevotedHeart = _EagerSupportDevotedHeart();

const DamageSpell firstAid = _FirstAid();
const SpellAugmentSkill firstAidTraining = _FirstAidTraining();
const NaturalAugment firstAidCooldown = _FirstAidEmergencyCooldown();
const NaturalAugment firstAidEmergencyWarning = _FirstAidEmergencyWarning();
const NaturalAugment firstAidEmergencySignal = _FirstAidEmergencySignal();
const NaturalAugment firstAidEmergencySwift = _FirstAidEmergencySwift();
const NaturalAugment firstAidEmergencyTarget = _FirstAidEmergencyTarget();

const SpellSkill warningBeacon = _WarningBeacon();
const SpellAugmentSkill warningBeacon2 = _WarningBeacon2();

const SpellSkill signalBeacon = _SignalBeacon();
const SpellAugmentSkill signalBeacon2 = _SignalBeacon2();

const SpellSkill swiftBeacon = _SwiftBeacon();
const SpellAugmentSkill swiftBeacon2 = _SwiftBeacon2();

const SpellSkill targetBeacon = _TargetBeacon();
const SpellAugmentSkill targetBeacon2 = _TargetBeacon2();

const SpellSkill assaultBeacon = _AssaultBeacon();
const SpellAugmentSkill assaultBeaconTurnGauge = _AssaultBeaconTurnGauge();
const SpellAugmentSkill assaultBeaconTurnConversion =
    _AssaultBeaconTurnConversion();
const SpellAugmentSkill assaultBeacon2 = _AssaultBeacon2();
const SpellAugmentSkill assaultBeaconHpLoss = _AssaultBeaconHpLoss();

const SpellSkill skillfulTreatment = _SkillfulTreatment();
const NaturalAugment skillfulTreatmentEmergencyWarning =
    _SkillfulTreatmentEmergencyWarning();
const NaturalAugment skillfulTreatmentEmergencySignal =
    _SkillfulTreatmentEmergencySignal();
const NaturalAugment skillfulTreatmentEmergencySwift =
    _SkillfulTreatmentEmergencySwift();
const NaturalAugment skillfulTreatmentEmergencyTarget =
    _SkillfulTreatmentEmergencyTarget();

const SpellSkill celestialStasis = _CelestialStasis();
const NaturalAugment celestialStasisPartyAtbCost =
    _CelestialStasisPartyAtbCost();
const SpellAugmentSkill celestialStasisTurnGauge = _CelestialStasisTurnGauge();
const SpellAugmentSkill celestialStasisTurnConversion =
    _CelestialStasisTurnConverion();

const NaturalAugment _beaconSpecialist = _BeaconSpecialist();
const SkillAugmentSkill adeptBeaconSpecialist = _AdeptBeaconSpecialist();

const UniqueSkill readingStars = _ReadingStars();

const RaceSlayerSkill knowledgeStrangeStrings = _KnowledgeStrangeStrings();
const SkillAugmentSkill knowledgeStrangeStrings2 = _KnowledgeStrangeStrings2();
const RaceSlayReactioner knowledgeStrangeStringsShield =
    _KnowledgeStrangeStringsShield();

const UniqueSkill maryShield = _MaryShield();
const SkillAugmentSkill maryKnight = _MaryKnight();

const UniqueSkill abilityReadStars = _AbilityReadStars();
const NaturalAugment abilityReadStarsFront = _AbilityReadStarsFront();

const UniqueSkill abilityReadMoon = _AbilityReadMoon();
const NaturalAugment abilityReadMoonFront = _AbilityReadMoonFront();

const UniqueSkill firCldDamage = _FirCldDamage();
const SkillAugmentSkill firCldDamage2 = _FirCldDamage2();

const UniqueSkill wndNtrDamage = _WndNtrDamage();
const SkillAugmentSkill wndNtrDamage2 = _WndNtrDamage2();

const UniqueSkill mysSpiDamage = _MysSpiDamage();
const SkillAugmentSkill mysSpiDamage2 = _MysSpiDamage2();

const UniqueSkill drkPhyDamage = _DrkPhyDamage();
const SkillAugmentSkill drkPhyDamage2 = _DrkPhyDamage2();

const UniqueSkill directDamage = _DirectDamage();
const SkillAugmentSkill directDamage2 = _DirectDamage2();

const UniqueSkill magicDamage = _MagicDamage();
const SkillAugmentSkill magicDamage2 = _MagicDamage2();

const UniqueSkill ailmentBoost = _AilmentBoost();
const UniqueSkill buffDebuffBoost = _BuffDebuffBoost();

class _EagerSupport
    with UniqueSkill
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
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

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
  int get accModifier => 10000;

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

  @override
  String get description => 'Cleanse Effect';
}

class _EagerSupportMentalCare
    with UniqueSkill, SkillAugmentSkill
    implements SpellNaturalAugmentChainSkill, ConditionedEffect {
  const _EagerSupportMentalCare();

  @override
  String get prettyName => 'Eager Support: Mental Care Boost';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[eagerSupport];

  @override
  SpellSkill get baseSkill => eagerSupport;

  @override
  NaturalAugment get baseAugment => eagerSupportCleanse;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[RandomNumberRequirement(80)];
}

class _EagerSupportSelfCare
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DamageReceivedBuffAugment {
  const _EagerSupportSelfCare();

  @override
  String get prettyName => 'Eager Support: Self-Care Reminder';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[eagerSupportMentalCare];

  @override
  SpellSkill get baseSkill => eagerSupport;

  @override
  double get dmgReceivedBuff => 20;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _EagerSupportDevotedHeart
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentSkill,
        DamageDealtBuffAugment,
        CooldownAugment,
        AtbIncreaseAugment {
  const _EagerSupportDevotedHeart();

  @override
  String get prettyName => 'Eager Support: Devoted Heart';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[eagerSupportSelfCare];

  @override
  SpellSkill get baseSkill => eagerSupport;

  @override
  double get dmgDealtBuff => 20;

  @override
  int get dmgDealtBuffDuration => 1;

  @override
  int get cooldown => 1;

  @override
  int get atbIncrease => 600;
}

class _FirstAid
    with UniqueSkill
    implements DirectSpell, MagicSpell, CooldownSpell, NaturallyAugmentedSkill {
  const _FirstAid();

  @override
  String get prettyName => 'First Aid';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<NaturalAugment> get naturalAugments => const <NaturalAugment>[
    firstAidCooldown,
    firstAidEmergencyWarning,
    firstAidEmergencySignal,
    firstAidEmergencySwift,
    firstAidEmergencyTarget,
  ];

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
  int get accModifier => 10000;

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

class _FirstAidTraining
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, MultiplierAugment {
  const _FirstAidTraining();

  @override
  String get prettyName => 'First Aid: First Aid Training';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[firstAid];

  @override
  DamageSpell get baseSkill => firstAid;

  @override
  double get multiplier => 50;
}

class _FirstAidEmergencyCooldown implements NaturalAugment, CooldownAugment {
  const _FirstAidEmergencyCooldown();

  @override
  SpellSkill get baseSkill => firstAid;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
  ];

  @override
  int get cooldown => 1;

  @override
  String get description => PassiveSkill.firstAidEmergencySmoke.prettyName;
}

class _FirstAidEmergencyWarning
    implements NaturalAugment, DefenseBuffAugment, MindBuffAugment {
  const _FirstAidEmergencyWarning();

  @override
  SpellSkill get baseSkill => firstAid;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(warningBeacon),
  ];

  @override
  int get defBuff => _WarningBeacon.buffAmount;

  @override
  int get mndBuff => _WarningBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Warning)';
}

class _FirstAidEmergencySignal
    implements NaturalAugment, AttackBuffAugment, MagicBuffAugment {
  const _FirstAidEmergencySignal();

  @override
  SpellSkill get baseSkill => firstAid;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(signalBeacon),
  ];

  @override
  int get atkBuff => _SignalBeacon.buffAmount;

  @override
  int get magBuff => _SignalBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Signal)';
}

class _FirstAidEmergencySwift implements NaturalAugment, SpeedBuffAugment {
  const _FirstAidEmergencySwift();

  @override
  SpellSkill get baseSkill => firstAid;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(swiftBeacon),
  ];

  @override
  int get spdBuff => _SwiftBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Swift)';
}

class _FirstAidEmergencyTarget implements NaturalAugment, AccuracyBuffAugment {
  const _FirstAidEmergencyTarget();

  @override
  SpellSkill get baseSkill => firstAid;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(targetBeacon),
  ];

  @override
  int get accBuff => _TargetBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Target)';
}

abstract class _BeaconSpell
    with UniqueSkill
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

  @override
  String get description => PassiveSkill.beaconSpecialist.prettyName;
}

class _AdeptBeaconSpecialist
    with UniqueSkill, SkillAugmentSkill
    implements NaturalAugmentChainSkill, DamageReceivedBuffAugment {
  const _AdeptBeaconSpecialist();

  @override
  String get prettyName => 'Adept Beacon Specialist';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[
    swiftBeacon,
    PassiveSkill.beaconSpecialist,
    targetBeacon,
  ];

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
  static const int buffAmount = 22;

  const _WarningBeacon();

  @override
  String get prettyName => 'Warning Beacon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

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
  int get defBuff => buffAmount;

  @override
  int get mndBuff => buffAmount;
}

class _WarningBeacon2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DefenseBuffAugment, MindBuffAugment {
  const _WarningBeacon2();

  @override
  String get prettyName => 'Warning Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[warningBeacon];

  @override
  SpellSkill get baseSkill => warningBeacon;

  @override
  int get defBuff => 8;

  @override
  int get mndBuff => 8;
}

class _SignalBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, AttackBuffer, MagicBuffer {
  static const int buffAmount = 15;

  const _SignalBeacon();

  @override
  String get prettyName => 'Signal Beacon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

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
  int get atkBuff => buffAmount;

  @override
  int get magBuff => buffAmount;
}

class _SignalBeacon2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, AttackBuffAugment, MagicBuffAugment {
  const _SignalBeacon2();

  @override
  String get prettyName => 'Signal Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[signalBeacon];

  @override
  SpellSkill get baseSkill => signalBeacon;

  @override
  int get atkBuff => 7;

  @override
  int get magBuff => 7;
}

class _SwiftBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, SpeedBuffer {
  static const int buffAmount = 22;

  const _SwiftBeacon();

  @override
  String get prettyName => 'Swift Beacon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[warningBeacon];

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
  int get spdBuff => buffAmount;
}

class _SwiftBeacon2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, SpeedBuffAugment {
  const _SwiftBeacon2();

  @override
  String get prettyName => 'Swift Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[swiftBeacon];

  @override
  SpellSkill get baseSkill => swiftBeacon;

  @override
  int get spdBuff => 8;
}

class _TargetBeacon extends _BeaconSpell
    implements ConditionedSpellSkill, AccuracyBuffer {
  static const int buffAmount = 15;

  const _TargetBeacon();

  @override
  String get prettyName => 'Target Beacon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[signalBeacon];

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
  int get accBuff => buffAmount;
}

class _TargetBeacon2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, AccuracyBuffAugment {
  const _TargetBeacon2();

  @override
  String get prettyName => 'Target Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[targetBeacon];

  @override
  SpellSkill get baseSkill => targetBeacon;

  @override
  int get accBuff => 7;
}

class _AssaultBeacon extends _BeaconSpell
    implements
        ConditionedSpellSkill,
        HpPercentDamageSpell,
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer {
  const _AssaultBeacon();

  @override
  String get prettyName => 'Assault Beacon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[swiftBeacon, targetBeacon];

  @override
  int get mpCost => 24;

  @override
  int get delay => 3300;

  @override
  List<Element> get elements => const <Element>[Element.drk];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(3)];

  @override
  double get hpPercentDamage => 20;

  @override
  int get atkBuff => 24;

  @override
  int get defBuff => 24;

  @override
  int get magBuff => 24;

  @override
  int get mndBuff => 24;

  @override
  int get spdBuff => 24;
}

class _AssaultBeaconTurnGauge
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, CustomAugmentRange, AtbIncreaseAugment {
  const _AssaultBeaconTurnGauge();

  @override
  String get prettyName => 'Assault Beacon: Turn Gauge Increase';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[swiftBeacon2, assaultBeacon];

  @override
  SpellSkill get baseSkill => assaultBeacon;

  @override
  AugmentRange get augmentRange => AugmentRange.frontlineMinusSelf;

  @override
  int get atbIncrease => 800;
}

class _AssaultBeaconTurnConversion
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentSkill,
        AttackBuffAugment,
        DefenseBuffAugment,
        MagicBuffAugment,
        MindBuffAugment,
        SpeedBuffAugment,
        TurnCountBasedAugment,
        TurnCountResetAugment {
  const _AssaultBeaconTurnConversion();

  @override
  String get prettyName => 'Assault Beacon: Turn Conversion';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[assaultBeacon, targetBeacon2];

  @override
  SpellSkill get baseSkill => assaultBeacon;

  @override
  int get atkBuff => 4;

  @override
  int get defBuff => 4;

  @override
  int get magBuff => 4;

  @override
  int get mndBuff => 4;

  @override
  int get spdBuff => 4;

  @override
  int? get turnCountCap => 15; // Could be less, check interaction resolution
}

class _AssaultBeacon2
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentSkill,
        AttackBuffAugment,
        DefenseBuffAugment,
        MagicBuffAugment,
        MindBuffAugment,
        SpeedBuffAugment {
  const _AssaultBeacon2();

  @override
  String get prettyName => 'Assault Beacon: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[assaultBeaconTurnGauge];

  @override
  SpellSkill get baseSkill => assaultBeacon;

  @override
  int get atkBuff => 8;

  @override
  int get defBuff => 8;

  @override
  int get magBuff => 8;

  @override
  int get mndBuff => 8;

  @override
  int get spdBuff => 8;
}

class _AssaultBeaconHpLoss
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, HpPercentDamageAugment {
  const _AssaultBeaconHpLoss();

  @override
  String get prettyName => 'Assault Beacon: HP Loss ↓';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[assaultBeaconTurnConversion];

  @override
  SpellSkill get baseSkill => assaultBeacon;

  @override
  double get hpPercentDamage => -10;
}

class _SkillfulTreatment
    with UniqueSkill
    implements
        DirectSpell,
        MagicSpell,
        ConditionedSpellSkill,
        CooldownSpell,
        NaturallyAugmentedSkill {
  const _SkillfulTreatment();

  @override
  String get prettyName => 'Skillful Treatment';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[PassiveSkill.firstAidEmergencySmoke];

  @override
  List<NaturalAugment> get naturalAugments => const <NaturalAugment>[
    skillfulTreatmentEmergencyWarning,
    skillfulTreatmentEmergencySignal,
    skillfulTreatmentEmergencySwift,
    skillfulTreatmentEmergencyTarget,
  ];

  @override
  int get mpCost => 15;

  @override
  int get delay => 4000;

  @override
  int get cooldown => 3;

  @override
  List<Element> get elements => const <Element>[Element.phy];

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(3)];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  int get accModifier => 10000;

  @override
  double get multiplier => 100;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => -50;

  @override
  double get magFactor => -50;
}

class _SkillfulTreatmentEmergencyWarning
    implements NaturalAugment, DefenseBuffAugment, MindBuffAugment {
  const _SkillfulTreatmentEmergencyWarning();

  @override
  SpellSkill get baseSkill => skillfulTreatment;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(warningBeacon),
  ];

  @override
  int get defBuff => _WarningBeacon.buffAmount;

  @override
  int get mndBuff => _WarningBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Warning)';
}

class _SkillfulTreatmentEmergencySignal
    implements NaturalAugment, AttackBuffAugment, MagicBuffAugment {
  const _SkillfulTreatmentEmergencySignal();

  @override
  SpellSkill get baseSkill => skillfulTreatment;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(signalBeacon),
  ];

  @override
  int get atkBuff => _SignalBeacon.buffAmount;

  @override
  int get magBuff => _SignalBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Signal)';
}

class _SkillfulTreatmentEmergencySwift
    implements NaturalAugment, SpeedBuffAugment {
  const _SkillfulTreatmentEmergencySwift();

  @override
  SpellSkill get baseSkill => skillfulTreatment;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(swiftBeacon),
  ];

  @override
  int get spdBuff => _SwiftBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Swift)';
}

class _SkillfulTreatmentEmergencyTarget
    implements NaturalAugment, AccuracyBuffAugment {
  const _SkillfulTreatmentEmergencyTarget();

  @override
  SpellSkill get baseSkill => skillfulTreatment;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    LearnedSkillRequirement(PassiveSkill.firstAidEmergencySmoke),
    LearnedSkillRequirement(targetBeacon),
  ];

  @override
  int get accBuff => _TargetBeacon.buffAmount;

  @override
  String get description =>
      '${PassiveSkill.firstAidEmergencySmoke.prettyName} (Target)';
}

class _CelestialStasis
    with UniqueSkill
    implements
        MagicSpell,
        ConditionedSpellSkill,
        NaturallyAugmentedSkill,
        ParalysisInflictor,
        SilenceInflictor,
        ShockInflictor {
  const _CelestialStasis();

  @override
  String get prettyName => 'Celestial Stasis';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[abilityReadStars, abilityReadMoon];

  @override
  int get mpCost => 20;

  @override
  int get delay => 3300;

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(3)];

  @override
  List<NaturalAugment> get naturalAugments =>
      const <NaturalAugment>[celestialStasisPartyAtbCost];

  @override
  List<Element> get elements => const <Element>[Element.mys];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allEnemies;

  @override
  int get accModifier => 50;

  @override
  double get multiplier => 100;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 50;

  @override
  double get magFactor => 66;

  @override
  int get parDuration => 12000;

  @override
  double get parChance => 90;

  @override
  int get silDuration => 12000;

  @override
  double get silChance => 90;

  @override
  double get shkChance => 90;
}

class _CelestialStasisPartyAtbCost
    implements NaturalAugment, CustomAugmentRange, PercentAtbDecreaseAugment {
  const _CelestialStasisPartyAtbCost();

  @override
  UniqueSkill get baseSkill => celestialStasis;

  @override
  String get description => 'Party ATB Reduction';

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[RandomNumberRequirement.always()];

  @override
  double get atbDecreaseFactor => -0.2;

  @override
  AugmentRange get augmentRange => AugmentRange.frontline;
}

class _CelestialStasisTurnGauge
    with UniqueSkill, SkillAugmentSkill
    implements SpellNaturalAugmentChainSkill, PercentAtbDecreaseAugment {
  const _CelestialStasisTurnGauge();

  @override
  String get prettyName => 'Celestial Stasis: Turn Gauge Loss ↓';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[eagerSupportDevotedHeart, celestialStasis];

  @override
  SpellSkill get baseSkill => celestialStasis;

  @override
  NaturalAugment get baseAugment => celestialStasisPartyAtbCost;

  @override
  double get atbDecreaseFactor => 0.1;
}

class _CelestialStasisTurnConverion
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentSkill,
        ParalysisAugment,
        ParalysisMultiplierAugment,
        SilenceAugment,
        SilenceMultiplierAugment,
        ShockAugment,
        ShockMultiplierAugment,
        TurnCountBasedAugment,
        TurnCountResetAugment {
  const _CelestialStasisTurnConverion();

  @override
  String get prettyName => 'Celestial Stasis: Turn Conversion';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[celestialStasis, skillfulTreatment];

  @override
  SpellSkill get baseSkill => celestialStasis;

  @override
  int? get turnCountCap => 10;

  @override
  double get parDurationMult => 0.05;

  @override
  double get silDurationMult => 0.05;

  @override
  double get parChance => 2;

  @override
  double get silChance => 2;

  @override
  double get shkChance => 2;

  @override
  double get parChanceMult => 1;

  @override
  double get silChanceMult => 1;

  @override
  double get shkChanceMult => 1;

  @override
  int get parDuration => 0;

  @override
  int get silDuration => 0;
}

class _ReadingStars with UniqueSkill implements AtbInitiativeIncreaser {
  const _ReadingStars();

  @override
  String get prettyName => "Reading the Stars' Positions";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  int get atbIncrease => 800;

  @override
  InitiativeRange get initiativeRange => InitiativeRange.frontline;
}

class _KnowledgeStrangeStrings
    with UniqueSkill
    implements RaceSlayerSkill, ConditionedEffect {
  const _KnowledgeStrangeStrings();

  @override
  String get prettyName => 'Knowledge of Strange Strings';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  List<EnemyRace> get races => const <EnemyRace>[EnemyRace.other];

  @override
  double get slayBonus => 12;
}

class _KnowledgeStrangeStrings2
    with UniqueSkill, SkillAugmentSkill
    implements RaceSlayAugment {
  const _KnowledgeStrangeStrings2();

  @override
  String get prettyName => 'Knowledge of Strange Strings: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[knowledgeStrangeStrings];

  @override
  RaceSlayerSkill get baseSkill => knowledgeStrangeStrings;

  @override
  List<EnemyRace> get races => baseSkill.races;

  @override
  double get slayBonus => 8;
}

class _KnowledgeStrangeStringsShield
    with UniqueSkill
    implements RaceSlayReactioner, DamageReceivedBuffer {
  const _KnowledgeStrangeStringsShield();

  @override
  String get prettyName => 'Knowledge of Strange Strings: Shield Conversion';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[knowledgeStrangeStrings2];

  @override
  RaceSlayerSkill get baseSkill => knowledgeStrangeStrings;

  @override
  double get dmgReceivedBuff => 10;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _MaryShield
    with UniqueSkill
    implements ConditionedEffect, AllIncreaser, PercentDamageReducer {
  const _MaryShield();

  @override
  String get prettyName => "Mary's Shield";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

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

class _MaryKnight
    with UniqueSkill, SkillAugmentSkill
    implements
        ConditionedEffect,
        AllIncreaseAugment,
        PercentDamageReduceAugment {
  const _MaryKnight();

  @override
  String get prettyName => "Mary's Knight";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[maryShield];

  @override
  UniqueSkill get baseSkill => maryShield;

  @override
  List<EffectRequirement> get effectRequirements => const <EffectRequirement>[
    FrontlineSelfRequirement(),
    FrontlineCharacterRequirement(Character.maribel),
  ];

  @override
  int get atkIncrease => 5;

  @override
  int get defIncrease => 5;

  @override
  int get magIncrease => 5;

  @override
  int get mndIncrease => 5;

  @override
  int get spdIncrease => 5;

  @override
  int get accIncrease => 5;

  @override
  int get evaIncrease => 5;

  @override
  double get dmgReducedPercent => 8;
}

class _AbilityReadStars
    with UniqueSkill
    implements
        NaturallyAugmentedSkill,
        PoisonResIncreaser,
        ParalysisResIncreaser,
        HeavyResIncreaser,
        ShockResIncreaser {
  static const int resIncrease = 10;

  const _AbilityReadStars();

  @override
  String get prettyName => 'Ability to Read the Stars';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[readingStars];

  @override
  List<NaturalAugment> get naturalAugments =>
      const <NaturalAugment>[abilityReadStarsFront];

  @override
  int get psnIncrease => resIncrease;

  @override
  int get parIncrease => resIncrease;

  @override
  int get hvyIncrease => resIncrease;

  @override
  int get shkIncrease => resIncrease;
}

class _AbilityReadStarsFront
    implements
        NaturalAugment,
        PoisonResIncreaseAugment,
        ParalysisResIncreaseAugment,
        HeavyResIncreaseAugment,
        ShockResIncreaseAugment {
  const _AbilityReadStarsFront();

  @override
  UniqueSkill get baseSkill => abilityReadStars;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  int get psnIncrease => _AbilityReadStars.resIncrease;

  @override
  int get parIncrease => _AbilityReadStars.resIncrease;

  @override
  int get hvyIncrease => _AbilityReadStars.resIncrease;

  @override
  int get shkIncrease => _AbilityReadStars.resIncrease;

  @override
  String get description => 'Backrow halving';
}

class _AbilityReadMoon
    with UniqueSkill
    implements
        NaturallyAugmentedSkill,
        TerrorResIncreaser,
        SilenceResIncreaser,
        DeathResIncreaser,
        DebuffResIncreaser {
  static const int resIncrease = 10;

  const _AbilityReadMoon();

  @override
  String get prettyName => 'Ability to Read the Moon';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[readingStars];

  @override
  List<NaturalAugment> get naturalAugments =>
      const <NaturalAugment>[abilityReadMoonFront];

  @override
  int get trrIncrease => resIncrease;

  @override
  int get silIncrease => resIncrease;

  @override
  int get dthIncrease => resIncrease;

  @override
  int get dbfIncrease => resIncrease;
}

class _AbilityReadMoonFront
    implements
        NaturalAugment,
        TerrorResIncreaseAugment,
        SilenceResIncreaseAugment,
        DeathResIncreaseAugment,
        DebuffResIncreaseAugment {
  const _AbilityReadMoonFront();

  @override
  UniqueSkill get baseSkill => abilityReadMoon;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  int get trrIncrease => _AbilityReadMoon.resIncrease;

  @override
  int get silIncrease => _AbilityReadMoon.resIncrease;

  @override
  int get dthIncrease => _AbilityReadMoon.resIncrease;

  @override
  int get dbfIncrease => _AbilityReadMoon.resIncrease;

  @override
  String get description => 'Backrow halving';
}

class _FirCldDamage with UniqueSkill implements ElementMultiplierEnhancer {
  static const List<Element> elementList = <Element>[Element.fir, Element.cld];

  const _FirCldDamage();

  @override
  String get prettyName => 'FIR/CLD Damage ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<Element> get elements => elementList;

  @override
  double get multiplierIncrease => 1.1;
}

class _FirCldDamage2
    with UniqueSkill, SkillAugmentSkill
    implements ElementMultiplierAugment {
  const _FirCldDamage2();

  @override
  String get prettyName => 'FIR/CLD Damage ↑+';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[firCldDamage];

  @override
  UniqueSkill get baseSkill => firCldDamage;

  @override
  List<Element> get elements => _FirCldDamage.elementList;

  @override
  double get multiplierIncrease => 0.1;
}

class _WndNtrDamage with UniqueSkill implements ElementMultiplierEnhancer {
  static const List<Element> elementList = <Element>[Element.wnd, Element.ntr];

  const _WndNtrDamage();

  @override
  String get prettyName => 'WND/NTR Damage ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<Element> get elements => elementList;

  @override
  double get multiplierIncrease => 1.1;
}

class _WndNtrDamage2
    with UniqueSkill, SkillAugmentSkill
    implements ElementMultiplierAugment {
  const _WndNtrDamage2();

  @override
  String get prettyName => 'WND/NTR Damage ↑+';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[wndNtrDamage];

  @override
  UniqueSkill get baseSkill => wndNtrDamage;

  @override
  List<Element> get elements => _WndNtrDamage.elementList;

  @override
  double get multiplierIncrease => 0.1;
}

class _MysSpiDamage with UniqueSkill implements ElementMultiplierEnhancer {
  static const List<Element> elementList = <Element>[Element.mys, Element.spi];

  const _MysSpiDamage();

  @override
  String get prettyName => 'MYS/SPI Damage ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<Element> get elements => elementList;

  @override
  double get multiplierIncrease => 1.1;
}

class _MysSpiDamage2
    with UniqueSkill, SkillAugmentSkill
    implements ElementMultiplierAugment {
  const _MysSpiDamage2();

  @override
  String get prettyName => 'MYS/SPI Damage ↑+';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[mysSpiDamage];

  @override
  UniqueSkill get baseSkill => mysSpiDamage;

  @override
  List<Element> get elements => _MysSpiDamage.elementList;

  @override
  double get multiplierIncrease => 0.1;
}

class _DrkPhyDamage with UniqueSkill implements ElementMultiplierEnhancer {
  static const List<Element> elementList = <Element>[Element.drk, Element.phy];

  const _DrkPhyDamage();

  @override
  String get prettyName => 'DRK/PHY Damage ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<Element> get elements => elementList;

  @override
  double get multiplierIncrease => 1.1;
}

class _DrkPhyDamage2
    with UniqueSkill, SkillAugmentSkill
    implements ElementMultiplierAugment {
  const _DrkPhyDamage2();

  @override
  String get prettyName => 'DRK/PHY Damage ↑+';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[drkPhyDamage];

  @override
  UniqueSkill get baseSkill => drkPhyDamage;

  @override
  List<Element> get elements => _DrkPhyDamage.elementList;

  @override
  double get multiplierIncrease => 0.1;
}

class _DirectDamage with UniqueSkill implements DirectPowEnhancer {
  const _DirectDamage();

  @override
  String get prettyName => 'Direct Attack Damage ↑';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  double get powIncrease => 1.08;
}

class _DirectDamage2
    with UniqueSkill, SkillAugmentSkill
    implements DirectPowEnhanceAugment {
  const _DirectDamage2();

  @override
  String get prettyName => 'Direct Attack Damage ↑+';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[firCldDamage2, ailmentBoost, buffDebuffBoost];

  @override
  UniqueSkill get baseSkill => directDamage;

  @override
  double get powIncrease => 0.08;
}

class _MagicDamage with UniqueSkill implements MagicPowEnhancer {
  const _MagicDamage();

  @override
  String get prettyName => 'Magic Attack Damage ↑';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  double get powIncrease => 1.08;
}

class _MagicDamage2
    with UniqueSkill, SkillAugmentSkill
    implements MagicPowEnhanceAugment {
  const _MagicDamage2();

  @override
  String get prettyName => 'Magic Attack Damage ↑+';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[ailmentBoost, buffDebuffBoost, drkPhyDamage2];

  @override
  UniqueSkill get baseSkill => magicDamage;

  @override
  double get powIncrease => 0.08;
}

class _AilmentBoost with UniqueSkill implements AilmentMultiplierEnhancer {
  const _AilmentBoost();

  @override
  String get prettyName => 'Ailment Attack Boost';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[firCldDamage2, directDamage, wndNtrDamage2];

  @override
  double get chanceIncrease => 1.08;

  @override
  double get durationIncrease => 1.12;
}

class _BuffDebuffBoost
    with UniqueSkill
    implements BuffMultiplierEnhancer, DebuffMultiplierEnhancer {
  const _BuffDebuffBoost();

  @override
  String get prettyName => 'Buff & Debuff Boost';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[mysSpiDamage2, magicDamage, drkPhyDamage2];

  @override
  double get debuffChanceIncrease => 1.08;

  @override
  double get debuffDurationIncrease => 1.12;

  @override
  double get buffDurationIncrease => 1.12;
}
