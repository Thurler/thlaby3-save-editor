/// A mixin for skills that provide an attack buff
mixin AttackBuffer {
  /// The buff intensity
  int get atkBuff;
}

/// A mixin for skills that provide a defense buff
mixin DefenseBuffer {
  /// The buff intensity
  int get defBuff;
}

/// A mixin for skills that provide a magic buff
mixin MagicBuffer {
  /// The buff intensity
  int get magBuff;
}

/// A mixin for skills that provide a mind buff
mixin MindBuffer {
  /// The buff intensity
  int get mndBuff;
}

/// A mixin for skills that provide a speed buff
mixin SpeedBuffer {
  /// The buff intensity
  int get spdBuff;
}

/// A mixin for skills that provide an accuracy buff
mixin AccuracyBuffer {
  /// The buff intensity
  int get accBuff;
}

/// A mixin for skills that provide an evasion buff
mixin EvasionBuffer {
  /// The buff intensity
  int get evaBuff;
}

/// A mixin for skills that provide a buff for every stat
mixin AllBuffer
    implements
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer,
        AccuracyBuffer,
        EvasionBuffer {}

/// A mixin for skills that provide a permanent attack buff
mixin PermanentAttackBuffer {
  /// The buff intensity
  int get permAtkBuff;
}

/// A mixin for skills that provide a permanent defense buff
mixin PermanentDefenseBuffer {
  /// The buff intensity
  int get permDefBuff;
}

/// A mixin for skills that provide a permanent magic buff
mixin PermanentMagicBuffer {
  /// The buff intensity
  int get permMagBuff;
}

/// A mixin for skills that provide a permanent mind buff
mixin PermanentMindBuffer {
  /// The buff intensity
  int get permMndBuff;
}

/// A mixin for skills that provide a permanent speed buff
mixin PermanentSpeedBuffer {
  /// The buff intensity
  int get permSpdBuff;
}

/// A mixin for skills that provide a permanent accuracy buff
mixin PermanentAccuracyBuffer {
  /// The buff intensity
  int get permAccBuff;
}

/// A mixin for skills that provide a permanent evasion buff
mixin PermanentEvasionBuffer {
  /// The buff intensity
  int get permEvaBuff;
}

/// A mixin for skills that provide a permanent buff for every stat
mixin PermanentAllBuffer
    implements
        PermanentAttackBuffer,
        PermanentDefenseBuffer,
        PermanentMagicBuffer,
        PermanentMindBuffer,
        PermanentSpeedBuffer,
        PermanentAccuracyBuffer,
        PermanentEvasionBuffer {}

/// A mixin for skills that provide a HP regen buff
mixin HpRegenBuffer {
  /// The buff intensity
  double get hpRegen;

  /// How many turns the buff stays up for
  int get hpRegenDuration;
}

/// A mixin for skills that provide a damage dealt buff
mixin DamageDealtBuffer {
  /// The buff intensity
  double get dmgDealtBuff;

  /// For how many attacks the buff stays up for
  int get dmgDealtBuffDuration;
}

/// A mixin for skills that provide a damage received buff
mixin DamageReceivedBuffer {
  /// The buff intensity
  double get dmgReceivedBuff;

  /// For how many attacks the buff stays up for
  int get dmgReceivedBuffDuration;
}

/// A mixin for skills that provide a bonus to the ATB bar
mixin AtbIncreaser {
  /// The amount ATB is increased by
  int get atbIncrease;
}

enum InitiativeRange {
  self,
  frontline;
}

/// A mixin for skills that provide a bonus to the ATB bar at the start of
/// battle
mixin AtbInitiativeIncreaser implements AtbIncreaser {
  /// The range applied to the initiative effect
  InitiativeRange get initiativeRange;
}
