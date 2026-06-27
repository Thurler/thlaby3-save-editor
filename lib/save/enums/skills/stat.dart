/// An interface for skills that consume TP upon being activated
abstract interface class TpConsumer {
  /// How much TP is consumed
  int get tpConsumed;
}

/// An interface for skills that provide a global percent-based damage reduction
abstract interface class PercentDamageReducer {
  /// How much percent of damage to block
  double get dmgReducedPercent;
}

/// An interface for skills that provide a global attack stat increase
abstract interface class AttackIncreaser {
  /// How much the stat is increased by, in percentage
  int get atkIncrease;
}

/// An interface for skills that provide a global defense stat increase
abstract interface class DefenseIncreaser {
  /// How much the stat is increased by, in percentage
  int get defIncrease;
}

/// An interface for skills that provide a global magic stat increase
abstract interface class MagicIncreaser {
  /// How much the stat is increased by, in percentage
  int get magIncrease;
}

/// An interface for skills that provide a global mind stat increase
abstract interface class MindIncreaser {
  /// How much the stat is increased by, in percentage
  int get mndIncrease;
}

/// An interface for skills that provide a global speed stat increase
abstract interface class SpeedIncreaser {
  /// How much the stat is increased by, in percentage
  int get spdIncrease;
}

/// An interface for skills that provide a global accuracy stat increase
abstract interface class AccuracyIncreaser {
  /// How much the stat is increased by, in percentage
  int get accIncrease;
}

/// An interface for skills that provide a global evasion stat increase
abstract interface class EvasionIncreaser {
  /// How much the stat is increased by, in percentage
  int get evaIncrease;
}

/// An interface for skills that provide a buff for every stat
abstract interface class AllIncreaser
    implements
        AttackIncreaser,
        DefenseIncreaser,
        MagicIncreaser,
        MindIncreaser,
        SpeedIncreaser,
        AccuracyIncreaser,
        EvasionIncreaser {}

/// An interface for skills that provide a global poison resistance stat
/// increase
abstract interface class PoisonResIncreaser {
  /// How much the stat is increased by, in percentage
  int get psnIncrease;
}

/// An interface for skills that provide a global paralysis resistance stat
/// increase
abstract interface class ParalysisResIncreaser {
  /// How much the stat is increased by, in percentage
  int get parIncrease;
}

/// An interface for skills that provide a global heavy resistance stat increase
abstract interface class HeavyResIncreaser {
  /// How much the stat is increased by, in percentage
  int get hvyIncrease;
}

/// An interface for skills that provide a global shock resistance stat increase
abstract interface class ShockResIncreaser {
  /// How much the stat is increased by, in percentage
  int get shkIncrease;
}

/// An interface for skills that provide a global terror resistance stat
/// increase
abstract interface class TerrorResIncreaser {
  /// How much the stat is increased by, in percentage
  int get trrIncrease;
}

/// An interface for skills that provide a global silence resistance stat
/// increase
abstract interface class SilenceResIncreaser {
  /// How much the stat is increased by, in percentage
  int get silIncrease;
}

/// An interface for skills that provide a global death resistance stat increase
abstract interface class DeathResIncreaser {
  /// How much the stat is increased by, in percentage
  int get dthIncrease;
}

/// An interface for skills that provide a global debuff resistance stat
/// increase
abstract interface class DebuffResIncreaser {
  /// How much the stat is increased by, in percentage
  int get dbfIncrease;
}
