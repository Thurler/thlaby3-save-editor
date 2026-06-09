import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/target.dart';

/// A mixin to unify spell behavior and properties
mixin SpellSkill on UniqueSkill {
  /// How much MP it costs to cast the spell
  int get mpCost;

  /// The post-use delay associated with the spell
  int get delay;

  /// The elements associated with the spell
  List<Element> get elements;

  /// The target mode used by the spell
  TargetMode get targetMode;

  static List<SpellSkill> get values => const <SpellSkill>[yinYangOrb];
}

/// A mixin to unify attributes of spells that cause damage
mixin DamageSpell on SpellSkill {
  /// The accuracy modifier to be applied on evasion check
  int get accModifider;

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

/// A mixin to unify attributes of spells that use other stats as attack factors
mixin OtherFactorSpell on DamageSpell {
  /// The defense factor to use on damage calculation
  double get defFactor;

  /// The mind factor to use on damage calculation
  double get mndFactor;

  /// The speed factor to use on damage calculation
  double get spdFactor;
}
