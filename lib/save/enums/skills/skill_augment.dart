import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/debuff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/renko.dart';

enum AugmentRange {
  self,
  frontline,
  frontlineMinusSelf;
}

/// A common interface for entities that augment a skill's effect, be they other
/// skills or natural augments
abstract interface class SkillAugment {
  /// The skill the augment acts on
  UniqueSkill get baseSkill;

  /// The description of the augment
  String get description;
}

/// A mixin for augments that are inherent to a given skill, meaning they are
/// not a separate, learnable entity, and are only activated based on specific
/// requirements
mixin NaturalAugment implements SkillAugment, ConditionedEffect {}

/// A mixin that provides a skill with a set of natural augment effects that can
/// be triggered without learning any other skills
mixin NaturallyAugmentedSkill on UniqueSkill {
  /// The skill's natural augments that are not tied to a separate learnable
  /// skill. These are always available, and usually have specific requirements
  /// be met to trigger, separate from the skill's main effect
  List<NaturalAugment> get naturalAugments;
}

/// A mixin for augments that require a custom range for their effects
mixin CustomAugmentRange on SkillAugment {
  /// The range to apply to the augment's effects. This overrides the original
  /// skill's range, to make it so for example a single target skill can have a
  /// party-wide augment effect
  AugmentRange get augmentRange;
}

/// A mixin for skills that augment a skill's functionalities
mixin SkillAugmentSkill on UniqueSkill implements SkillAugment {
  static const List<SkillAugmentSkill> values = <SkillAugmentSkill>[
    // Generic skill augments
    quickCharge2,
    // Reimu skill augments
    armoredYinYangOrb2,
    youkaiBuster2,
    reimuPrivileges2,
    reimuPrivilegesPerm,
    finalPrayer2,
    // Renko skill augments
    adeptBeaconSpecialist,
    knowledgeStrangeStrings2,
    maryKnight,
    firCldDamage2,
    wndNtrDamage2,
    mysSpiDamage2,
    drkPhyDamage2,
    directDamage2,
    magicDamage2,
  ];

  /// The augments that must be already applied when this augment is applied,
  /// usually from skill requirements
  Iterable<SkillAugmentSkill> get requiredAugments =>
      allRequirements.whereType<SkillAugmentSkill>().where(
    (SkillAugmentSkill augment) => augment.baseSkill == baseSkill,
  );

  @override
  String get description => prettyName;
}

/// A mixin for skills that augment another natural augment, effectively
/// replacing it
mixin NaturalAugmentChainSkill on SkillAugmentSkill {
  /// The augment the augment acts on
  NaturalAugment get baseAugment;
}

/// A mixin for skills that augment another augment skill, effectively replacing
/// it
mixin SkillAugmentChainSkill on SkillAugmentSkill {
  /// The augment the augment acts on
  SkillAugmentSkill get baseAugment;
}

/// A mixin for augments that change a spell's attack buff
mixin AttackBuffAugment on SkillAugment implements AttackBuffer {
  /// How much the buff intensity increases by
  @override
  int get atkBuff;
}

/// A mixin for augments that change a spell's defense buff
mixin DefenseBuffAugment on SkillAugment implements DefenseBuffer {
  /// How much the buff intensity increases by
  @override
  int get defBuff;
}

/// A mixin for augments that change a spell's magic buff
mixin MagicBuffAugment on SkillAugment implements MagicBuffer {
  /// How much the buff intensity increases by
  @override
  int get magBuff;
}

/// A mixin for augments that change a spell's mind buff
mixin MindBuffAugment on SkillAugment implements MindBuffer {
  /// How much the buff intensity increases by
  @override
  int get mndBuff;
}

/// A mixin for augments that change a spell's speed buff
mixin SpeedBuffAugment on SkillAugment implements SpeedBuffer {
  /// How much the buff intensity increases by
  @override
  int get spdBuff;
}

/// A mixin for augments that change a spell's accuracy buff
mixin AccuracyBuffAugment on SkillAugment implements AccuracyBuffer {
  /// How much the buff intensity increases by
  @override
  int get accBuff;
}

/// A mixin for augments that change a spell's accuracy buff
mixin EvasionBuffAugment on SkillAugment implements EvasionBuffer {
  /// How much the buff intensity increases by
  @override
  int get evaBuff;
}

/// A mixin for augments that change a spell's permanent attack buff
mixin PermanentAttackBuffAugment on SkillAugment
    implements PermanentAttackBuffer {
  /// How much the buff intensity increases by
  @override
  int get permAtkBuff;
}

/// A mixin for augments that change a spell's permanent defense buff
mixin PermanentDefenseBuffAugment on SkillAugment
    implements PermanentDefenseBuffer {
  /// How much the buff intensity increases by
  @override
  int get permDefBuff;
}

/// A mixin for augments that change a spell's permanent magic buff
mixin PermanentMagicBuffAugment on SkillAugment
    implements PermanentMagicBuffer {
  /// How much the buff intensity increases by
  @override
  int get permMagBuff;
}

/// A mixin for augments that change a spell's permanent mind buff
mixin PermanentMindBuffAugment on SkillAugment implements PermanentMindBuffer {
  /// How much the buff intensity increases by
  @override
  int get permMndBuff;
}

/// A mixin for augments that change a spell's permanent speed buff
mixin PermanentSpeedBuffAugment on SkillAugment
    implements PermanentSpeedBuffer {
  /// How much the buff intensity increases by
  @override
  int get permSpdBuff;
}

/// A mixin for augments that change a spell's permanent accuracy buff
mixin PermanentAccuracyBuffAugment on SkillAugment
    implements PermanentAccuracyBuffer {
  /// How much the buff intensity increases by
  @override
  int get permAccBuff;
}

/// A mixin for augments that change a spell's permanent accuracy buff
mixin PermanentEvasionBuffAugment on SkillAugment
    implements PermanentEvasionBuffer {
  /// How much the buff intensity increases by
  @override
  int get permEvaBuff;
}

/// A mixin for augments that change a spell's HP regen buff
mixin HpRegenBuffAugment on SkillAugment implements HpRegenBuffer {
  /// How much the buff intensity increases by
  @override
  double get hpRegen;

  /// How many turns duration increases by
  @override
  int get hpRegenDuration;
}

/// A mixin for augments that change a spell's damage dealt buff
mixin DamageDealtBuffAugment on SkillAugment implements DamageDealtBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgDealtBuff;

  /// For how many more attacks the buff stays up for
  @override
  int get dmgDealtBuffDuration;
}

/// A mixin for augments that change a spell's damage received buff
mixin DamageReceivedBuffAugment on SkillAugment
    implements DamageReceivedBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgReceivedBuff;

  /// For how many more attacks the buff stays up for
  @override
  int get dmgReceivedBuffDuration;
}

/// A mixin for augments that change a spell's atb increase buff
mixin AtbIncreaseAugment on SkillAugment implements AtbIncreaser {
  /// The amount ATB is further increased by
  @override
  int get atbIncrease;
}

/// A mixin for augments that change a spell's atb percent decrease effect
mixin PercentAtbDecreaseAugment on SkillAugment implements PercentAtbDecreaser {
  /// The amount ATB multilicand is increased by (base multiplicand is 1)
  @override
  double get atbDecreaseFactor;
}

/// A mixin for augments that change a skill's paralysis infliction
mixin ParalysisAugment on SkillAugment implements ParalysisInflictor {
  /// How much the ailment duration increases by
  @override
  int get parDuration;

  /// How much the ailment chance increases by
  @override
  double get parChance;
}

/// A mixin for augments that change a skill's silence infliction
mixin SilenceAugment on SkillAugment implements SilenceInflictor {
  /// How much the ailment duration increases by
  @override
  int get silDuration;

  /// How much the ailment chance increases by
  @override
  double get silChance;
}

/// A mixin for augments that change a skill's shock infliction
mixin ShockAugment on SkillAugment implements ShockInflictor {
  /// How much the ailment chance increases by
  @override
  double get shkChance;
}

/// A mixin for augments that change a skill's paralysis infliction
/// multiplicatively
mixin ParalysisMultiplierAugment on SkillAugment {
  /// How much the ailment duration is multiplied by
  double get parDurationMult;

  /// How much the ailment chance is multiplied by
  double get parChanceMult;
}

/// A mixin for augments that change a skill's silence infliction
/// multiplicatively
mixin SilenceMultiplierAugment on SkillAugment {
  /// How much the ailment duration is multiplied by
  double get silDurationMult;

  /// How much the ailment chance is multiplied by
  double get silChanceMult;
}

/// A mixin for augments that change a skill's shock infliction
/// multiplicatively
mixin ShockMultiplierAugment on SkillAugment {
  /// How much the ailment chance is multiplied by
  double get shkChanceMult;
}

/// A mixin for augments that change a element multiplier enhancer's
/// multiplicand
mixin ElementMultiplierAugment on SkillAugment
    implements ElementMultiplierEnhancer {
  /// How much damage multiplier multiplicand is increased by
  @override
  double get multiplierIncrease;
}

/// A mixin for augments that change an element protector's protection
mixin ElementProtectionAugment on SkillAugment implements ElementProtector {
  @override
  ElementProtectorSkill get baseSkill;

  /// How much damage reduction will be increased by
  @override
  double get protection;
}

/// A mixin for augments that change a race slay's damage boost
mixin RaceSlayAugment on SkillAugment implements RaceSlayer {
  @override
  RaceSlayerSkill get baseSkill;

  /// How much damage boost will be increased by
  @override
  double get slayBonus;
}

/// A mixin for augments that change a ko reaction's effect
mixin KoReactionAugment on SkillAugment implements KoReactioner {
  @override
  KoReactionerSkill get baseSkill;
}

/// A mixin for augments that change a focus reaction's effect
mixin FocusReactionAugment on SkillAugment implements FocusReactioner {
  @override
  FocusReactionerSkill get baseSkill;
}

/// A mixin for augments that change a percent heal skill's potency
mixin PercentHealAugment on SkillAugment implements PercentHealer {
  /// How much the heal percent will be increased by
  @override
  double get healPercent;
}

/// A mixin for augments that change a percent MP heal skill's potency
mixin PercentMpHealAugment on SkillAugment implements PercentMpHealer {
  /// How much the heal percent will be increased by
  @override
  double get mpHealPercent;
}

/// A mixin for augents that change a global poison resistance stat increase
mixin PoisonResIncreaseAugment on SkillAugment implements PoisonResIncreaser {
  /// How much the stat increase increases by
  @override
  int get psnIncrease;
}

/// A mixin for augents that change a global paralysis resistance stat increase
mixin ParalysisResIncreaseAugment on SkillAugment
    implements ParalysisResIncreaser {
  /// How much the stat increase increases by
  @override
  int get parIncrease;
}

/// A mixin for augents that change a global heavy resistance stat increase
mixin HeavyResIncreaseAugment on SkillAugment implements HeavyResIncreaser {
  /// How much the stat increase increases by
  @override
  int get hvyIncrease;
}

/// A mixin for augents that change a global shock resistance stat increase
mixin ShockResIncreaseAugment on SkillAugment implements ShockResIncreaser {
  /// How much the stat increase increases by
  @override
  int get shkIncrease;
}

/// A mixin for augents that change a global terror resistance stat increase
mixin TerrorResIncreaseAugment on SkillAugment implements TerrorResIncreaser {
  /// How much the stat increase increases by
  @override
  int get trrIncrease;
}

/// A mixin for augents that change a global silence resistance stat increase
mixin SilenceResIncreaseAugment on SkillAugment implements SilenceResIncreaser {
  /// How much the stat increase increases by
  @override
  int get silIncrease;
}

/// A mixin for augents that change a global death resistance stat increase
mixin DeathResIncreaseAugment on SkillAugment implements DeathResIncreaser {
  /// How much the stat increase increases by
  @override
  int get dthIncrease;
}

/// A mixin for augents that change a global debuff resistance stat increase
mixin DebuffResIncreaseAugment on SkillAugment implements DebuffResIncreaser {
  /// How much the stat increase increases by
  @override
  int get dbfIncrease;
}

/// A mixin for skills that provide a global percent-based damage reduction
mixin PercentDamageReduceAugment on SkillAugment
    implements PercentDamageReducer {
  /// How much more percent of damage to block
  @override
  double get dmgReducedPercent;
}

/// A mixin for skills that provide a global attack stat increase
mixin AttackIncreaseAugment on SkillAugment implements AttackIncreaser {
  /// How much the stat increase is increased by
  @override
  int get atkIncrease;
}

/// A mixin for skills that provide a global defense stat increase
mixin DefenseIncreaseAugment on SkillAugment implements DefenseIncreaser {
  /// How much the stat increase is increased by
  @override
  int get defIncrease;
}

/// A mixin for skills that provide a global magic stat increase
mixin MagicIncreaseAugment on SkillAugment implements MagicIncreaser {
  /// How much the stat increase is increased by
  @override
  int get magIncrease;
}

/// A mixin for skills that provide a global mind stat increase
mixin MindIncreaseAugment on SkillAugment implements MindIncreaser {
  /// How much the stat increase is increased by
  @override
  int get mndIncrease;
}

/// A mixin for skills that provide a global speed stat increase
mixin SpeedIncreaseAugment on SkillAugment implements SpeedIncreaser {
  /// How much the stat increase is increased by
  @override
  int get spdIncrease;
}

/// A mixin for skills that provide a global accuracy stat increase
mixin AccuracyIncreaseAugment on SkillAugment implements AccuracyIncreaser {
  /// How much the stat increase is increased by
  @override
  int get accIncrease;
}

/// A mixin for skills that provide a global evasion stat increase
mixin EvasionIncreaseAugment on SkillAugment implements EvasionIncreaser {
  /// How much the stat increase is increased by
  @override
  int get evaIncrease;
}

/// A mixin for skills that provide a buff for every stat
mixin AllIncreaseAugment on SkillAugment
    implements
        AttackIncreaseAugment,
        DefenseIncreaseAugment,
        MagicIncreaseAugment,
        MindIncreaseAugment,
        SpeedIncreaseAugment,
        AccuracyIncreaseAugment,
        EvasionIncreaseAugment {}
