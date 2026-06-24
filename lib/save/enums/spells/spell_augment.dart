import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/renko.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';

/// A mixin for augments that apply to a spell, as opposed to a generic skill
mixin SpellAugment on SkillAugment {
  /// The spell the augment acts on
  @override
  SpellSkill get baseSkill;
}

/// A mixin for skills that augment a spell's functionalities
mixin SpellAugmentSkill on SkillAugmentSkill {
  static const List<SpellAugmentSkill> values = <SpellAugmentSkill>[
    // Reimu spell augments
    yinYangOrbParAffix,
    yinYangOrbPow,
    yinYangOrbDelay,
    yinYangOrbParBoost,
    yinYangOrbDelay2,
    yinYangOrbCooldownPow,
    barrierTalisman2,
    recoveryTalisman2,
    greatHakureiBarrierTurn,
    greatHakureiBarrierSelfProtect,
    greatHakureiBarrierRegen,
    greatHakureiBarrierRegen2,
    persuasionNeedleMultiplier,
    persuasionNeedleGuard,
    persuasionNeedleHpDrain,
    flashExorcismBarrierDelay,
    flashExorcismBarrierTurn,
    flashExorcismBarrierDamageTaken,
    flashExorcismBarrierDamageTaken2,
    dreamSealTurn,
    dreamSealDamageAplifier,
    // Renko spell augments
    eagerSupportMentalCare,
    eagerSupportSelfCare,
    eagerSupportDevotedHeart,
    firstAidTraining,
    warningBeacon2,
    signalBeacon2,
    swiftBeacon2,
    targetBeacon2,
  ];
}

/// A mixin for skills that augment another natural augment, effectively
/// replacing it
mixin SpellNaturalAugmentChainSkill on SpellAugmentSkill {
  /// The augment the augment acts on
  NaturalAugment get baseAugment;
}

/// A mixin for skills that augment another augment skill, effectively replacing
/// it
mixin SpellAugmentChainSkill on SkillAugmentChainSkill, SpellAugmentSkill {
  /// The augment the augment acts on
  @override
  SpellAugmentSkill get baseAugment;
}

/// A mixin for augments that change a spell's delay
mixin DelayAugment on SpellAugment {
  /// How much post-use delay increases by
  double get delay;
}

/// A mixin for augments that change a spell's cooldown
mixin CooldownAugment on SpellAugment {
  /// How much post-use cooldown increases by
  int get cooldown;
}

/// A mixin for augments that change a spell's pow
mixin PowAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much pow increases by
  double get pow;
}

/// A mixin for skills that offer passive enhancements when using direct spells
mixin DirectPowEnhancer {
  /// How much pow will be multiplied by
  double get powIncrease;
}

/// A mixin for skills that offer passive enhancements when using magic spells
mixin MagicPowEnhancer {
  /// How much pow will be multiplied by
  double get powIncrease;
}

/// A mixin for augments that change a spell's multiplier
mixin MultiplierAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much multiplier increases by
  double get multiplier;
}

/// A mixin for augments that change a spell's multiplier multiplicatively
mixin MultiplierMultiplyAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much multiplier is multiplied by
  double get multiplier;
}

/// A mixin for augments that change a spell's guard factors
mixin GuardAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much the defense guard factor increases by
  double get defGuard;

  /// How much the mind guard factor increases by
  double get mndGuard;
}

/// A mixin for augments that change a spell's hp drain percent
mixin HpDrainAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much more percentage of damage dealt that becomes HP heal
  double get hpDrainPercent;
}

/// A mixin for augments that change a spell's damage dealt buffs amplification
mixin DamageDealtAmplifyAugment on SpellAugment {
  @override
  DamageSpell get baseSkill;

  /// How much to increase the damage dealt buff amplification by
  double get dmgDealtAmplification;
}
