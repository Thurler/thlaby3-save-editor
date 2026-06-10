import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that provide an attack buff
mixin AttackBuffer on UniqueSkill {
  /// The buff intensity
  double get atkBuff;
}

/// A mixin for skills that provide a defense buff
mixin DefenseBuffer on UniqueSkill {
  /// The buff intensity
  double get defBuff;
}

/// A mixin for skills that provide a magic buff
mixin MagicBuffer on UniqueSkill {
  /// The buff intensity
  double get magBuff;
}

/// A mixin for skills that provide a mind buff
mixin MindBuffer on UniqueSkill {
  /// The buff intensity
  double get mndBuff;
}

/// A mixin for skills that provide a speed buff
mixin SpeedBuffer on UniqueSkill {
  /// The buff intensity
  double get spdBuff;
}

/// A mixin for skills that provide a permanent attack buff
mixin PermanentAttackBuffer on UniqueSkill {
  /// The buff intensity
  double get permAtkBuff;
}

/// A mixin for skills that provide a permanent defense buff
mixin PermanentDefenseBuffer on UniqueSkill {
  /// The buff intensity
  double get permDefBuff;
}

/// A mixin for skills that provide a permanent magic buff
mixin PermanentMagicBuffer on UniqueSkill {
  /// The buff intensity
  double get permMagBuff;
}

/// A mixin for skills that provide a permanent mind buff
mixin PermanentMindBuffer on UniqueSkill {
  /// The buff intensity
  double get permMndBuff;
}

/// A mixin for skills that provide a permanent speed buff
mixin PermanentSpeedBuffer on UniqueSkill {
  /// The buff intensity
  double get permSpdBuff;
}

/// A mixin for skills that provide a HP regen buff
mixin HpRegenBuffer on UniqueSkill {
  /// The buff intensity
  double get hpRegen;

  /// How many turns the buff stays up for
  double get hpRegenDuration;
}

/// A mixin for skills that provide a damage dealt buff
mixin DamageDealtBuffer on UniqueSkill {
  /// The buff intensity
  double get dmgDealtBuff;

  /// For how many attacks the buff stays up for
  double get dmgDealtBuffDuration;
}

/// A mixin for skills that provide a damage received buff
mixin DamageReceivedBuffer on UniqueSkill {
  /// The buff intensity
  double get dmgReceivedBuff;

  /// For how many attacks the buff stays up for
  double get dmgReceivedBuffDuration;
}
