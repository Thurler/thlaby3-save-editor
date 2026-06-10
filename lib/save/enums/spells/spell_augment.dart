import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';

/// A mixin for skills that augment a spell's functionalities
mixin SpellAugmentSkill on SkillAugmentSkill {
  /// The spell the augment acts on
  @override
  SpellSkill get baseSkill;

  /// The requirement that must be met to make the augment effect happen. If
  /// null, then no requirement needs to be met
  EffectRequirement? get augmentRequirement;

  static List<SpellAugmentSkill> get values => const <SpellAugmentSkill>[
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
  ];
}

/// A mixin for skills that augment another augment, effectively replacing it
mixin SpellAugmentChainSkill on SkillAugmentChainSkill, SpellAugmentSkill {
  /// The augment the augment acts on
  @override
  SpellAugmentSkill get baseAugment;
}

/// A mixin for augments that change a spell's delay
mixin DelayAugment on SpellAugmentSkill {
  /// How much post-use delay increases by
  double get delay;
}

/// A mixin for augments that change a spell's cooldown
mixin CooldownAugment on SpellAugmentSkill {
  /// How much post-use cooldown increases by
  int get cooldown;
}

/// A mixin for augments that change a spell's pow
mixin PowAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much pow increases by
  double get pow;
}

/// A mixin for augments that change a spell's multiplier
mixin MultiplierAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much multiplier increases by
  double get multiplier;
}

/// A mixin for augments that change a spell's multiplier multiplicatively
mixin MultiplierMultiplyAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much multiplier is multiplied by
  double get multiplier;
}

/// A mixin for augments that change a spell's guard factors
mixin GuardAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much the defense guard factor increases by
  double get defGuard;

  /// How much the mind guard factor increases by
  double get mndGuard;
}

/// A mixin for augments that change a spell's hp drain percent
mixin HpDrainAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much more percentage of damage dealt that becomes HP heal
  double get hpDrainPercent;
}

/// A mixin for augments that change a spell's damage dealt buffs amplification
mixin DamageDealtAmplifyAugment on SpellAugmentSkill {
  @override
  DamageSpell get baseSkill;

  /// How much to increase the damage dealt buff amplification by
  double get dmgDealtAmplification;
}
