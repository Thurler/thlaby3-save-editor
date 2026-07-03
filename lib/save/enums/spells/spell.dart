import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/renko.dart';

/// The target mode associated with a spell
enum SpellTargetMode {
  singleEnemy,
  rowEnemyDiminished,
  allEnemies,
  singleAlly,
  allAlliesDiminished,
  allAllies;
}

/// A mixin to unify spell behavior and properties
mixin SpellSkill on UniqueSkill {
  /// How much MP it costs to cast the spell
  int get mpCost;

  /// The post-use delay associated with the spell
  int get delay;

  /// The elements associated with the spell
  List<Element> get elements;

  /// The target mode used by the spell
  SpellTargetMode get targetMode;

  static const List<SpellSkill> values = <SpellSkill>[
    // Reimu spells
    yinYangOrb,
    barrierTalisman,
    recoveryTalisman,
    persuasionNeedle,
    greatHakureiBarrier,
    hakureiTalisman,
    flashExorcismBarrier,
    dreamSeal,
    // Renko spells
    eagerSupport,
    firstAid,
    warningBeacon,
    signalBeacon,
    swiftBeacon,
    targetBeacon,
    assaultBeacon,
    skillfulTreatment,
    celestialStasis,
  ];
}

/// A mixin for spells that have a cooldown associated with it
mixin CooldownSpell on SpellSkill {
  /// The post-use cooldown associated with the spell
  int get cooldown;
}

/// A mixin for spells that require a set of requirements to be met in order to
/// be cast
mixin ConditionedSpellSkill on SpellSkill {
  /// The requirements that must be met to make the spell selectable
  List<EffectRequirement> get castRequirements;
}

/// A mixin to unify attributes of spells that cause damage
mixin DamageSpell on SpellSkill {
  /// The accuracy modifier to be applied on evasion check
  int get accModifier;

  /// The damage multiplier to use on damage calculation
  double get multiplier;

  /// The defense guard factor to use on damage calculation
  double get defGuard;

  /// The mind guard factor to use on damage calculation
  double get mndGuard;
}

/// A mixin to unify attributes of spells that cause direct damage
mixin DirectSpell on DamageSpell {
  /// The attack factor to use on damage calculation
  double get atkFactor;
}

/// A mixin to unify attributes of spells that cause magical damage
mixin MagicSpell on DamageSpell {
  /// The magic factor to use on damage calculation
  double get magFactor;
}

/// A mixin to unify attributes of spells that cause fixed hp percent damage
mixin HpPercentDamageSpell on SpellSkill {
  /// What percentage of current HP is dealt as damage
  double get hpPercentDamage;
}

/// A mixin to unify attributes of spells that use other stats as attack factors
mixin OtherFactorSpell on DamageSpell {
  /// The defense factor to use on damage calculation
  double get defFactor;

  /// The mind factor to use on damage calculation
  double get mndFactor;

  /// The speed factor to use on damage calculation
  double get spdFactor;
}

/// A mixin to unify attributes of spells that drain HP based on damage dealt
mixin HpDrainSpell on DamageSpell {
  /// The percentage of damage dealt that becomes HP heal
  double get hpDrainPercent;
}

/// A mixin for skills that amplify existing damage dealt buffs
mixin DamageDealtAmplifier on DamageSpell {
  /// How much to amplify the damage dealt buff by
  double get dmgDealtAmplification;
}
