/// An interface for skills that provide an attack buff
abstract interface class AttackBuffer {
  /// The buff intensity
  int get atkBuff;
}

/// An interface for skills that provide a defense buff
abstract interface class DefenseBuffer {
  /// The buff intensity
  int get defBuff;
}

/// An interface for skills that provide a magic buff
abstract interface class MagicBuffer {
  /// The buff intensity
  int get magBuff;
}

/// An interface for skills that provide a mind buff
abstract interface class MindBuffer {
  /// The buff intensity
  int get mndBuff;
}

/// An interface for skills that provide a speed buff
abstract interface class SpeedBuffer {
  /// The buff intensity
  int get spdBuff;
}

/// An interface for skills that provide an accuracy buff
abstract interface class AccuracyBuffer {
  /// The buff intensity
  int get accBuff;
}

/// An interface for skills that provide an evasion buff
abstract interface class EvasionBuffer {
  /// The buff intensity
  int get evaBuff;
}

/// An interface for skills that provide a buff for every stat
abstract interface class AllBuffer
    implements
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer,
        AccuracyBuffer,
        EvasionBuffer {}

/// An interface for skills that provide a permanent attack buff
abstract interface class PermanentAttackBuffer {
  /// The buff intensity
  int get permAtkBuff;
}

/// An interface for skills that provide a permanent defense buff
abstract interface class PermanentDefenseBuffer {
  /// The buff intensity
  int get permDefBuff;
}

/// An interface for skills that provide a permanent magic buff
abstract interface class PermanentMagicBuffer {
  /// The buff intensity
  int get permMagBuff;
}

/// An interface for skills that provide a permanent mind buff
abstract interface class PermanentMindBuffer {
  /// The buff intensity
  int get permMndBuff;
}

/// An interface for skills that provide a permanent speed buff
abstract interface class PermanentSpeedBuffer {
  /// The buff intensity
  int get permSpdBuff;
}

/// An interface for skills that provide a permanent accuracy buff
abstract interface class PermanentAccuracyBuffer {
  /// The buff intensity
  int get permAccBuff;
}

/// An interface for skills that provide a permanent evasion buff
abstract interface class PermanentEvasionBuffer {
  /// The buff intensity
  int get permEvaBuff;
}

/// An interface for skills that provide a permanent buff for every stat
abstract interface class PermanentAllBuffer
    implements
        PermanentAttackBuffer,
        PermanentDefenseBuffer,
        PermanentMagicBuffer,
        PermanentMindBuffer,
        PermanentSpeedBuffer,
        PermanentAccuracyBuffer,
        PermanentEvasionBuffer {}

/// An interface for skills that provide a HP regen buff
abstract interface class HpRegenBuffer {
  /// The buff intensity
  double get hpRegen;

  /// How many turns the buff stays up for
  int get hpRegenDuration;
}

/// An interface for skills that provide a damage dealt buff
abstract interface class DamageDealtBuffer {
  /// The buff intensity
  double get dmgDealtBuff;

  /// For how many attacks the buff stays up for
  int get dmgDealtBuffDuration;
}

/// An interface for skills that provide a damage received buff
abstract interface class DamageReceivedBuffer {
  /// The buff intensity
  double get dmgReceivedBuff;

  /// For how many attacks the buff stays up for
  int get dmgReceivedBuffDuration;
}

/// An interface for skills that provide a bonus to the ATB bar
abstract interface class AtbIncreaser {
  /// The amount ATB is increased by
  int get atbIncrease;
}

enum InitiativeRange {
  self,
  frontline;
}

/// An interface for skills that provide a bonus to the ATB bar at the start of
/// battle
abstract interface class AtbInitiativeIncreaser implements AtbIncreaser {
  /// The range applied to the initiative effect
  InitiativeRange get initiativeRange;
}
