/// A mixin for skills that consume TP upon being activated
mixin TpConsumer {
  /// How much TP is consumed
  int get tpConsumed;
}

/// A mixin for skills that provide a global percent-based damage reduction
mixin PercentDamageReducer {
  /// How much percent of damage to block
  double get dmgReducedPercent;
}

/// A mixin for skills that provide a global attack stat increase
mixin AttackIncreaser {
  /// How much the stat is increased by, in percentage
  int get atkIncrease;
}

/// A mixin for skills that provide a global defense stat increase
mixin DefenseIncreaser {
  /// How much the stat is increased by, in percentage
  int get defIncrease;
}

/// A mixin for skills that provide a global magic stat increase
mixin MagicIncreaser {
  /// How much the stat is increased by, in percentage
  int get magIncrease;
}

/// A mixin for skills that provide a global mind stat increase
mixin MindIncreaser {
  /// How much the stat is increased by, in percentage
  int get mndIncrease;
}

/// A mixin for skills that provide a global speed stat increase
mixin SpeedIncreaser {
  /// How much the stat is increased by, in percentage
  int get spdIncrease;
}

/// A mixin for skills that provide a global accuracy stat increase
mixin AccuracyIncreaser {
  /// How much the stat is increased by, in percentage
  int get accIncrease;
}

/// A mixin for skills that provide a global evasion stat increase
mixin EvasionIncreaser {
  /// How much the stat is increased by, in percentage
  int get evaIncrease;
}

/// A mixin for skills that provide a buff for every stat
mixin AllIncreaser
    implements
        AttackIncreaser,
        DefenseIncreaser,
        MagicIncreaser,
        MindIncreaser,
        SpeedIncreaser,
        AccuracyIncreaser,
        EvasionIncreaser {}

/// A mixin for skills that provide a global poison resistance stat increase
mixin PoisonResIncreaser {
  /// How much the stat is increased by, in percentage
  int get psnIncrease;
}

/// A mixin for skills that provide a global paralysis resistance stat increase
mixin ParalysisResIncreaser {
  /// How much the stat is increased by, in percentage
  int get parIncrease;
}

/// A mixin for skills that provide a global heavy resistance stat increase
mixin HeavyResIncreaser {
  /// How much the stat is increased by, in percentage
  int get hvyIncrease;
}

/// A mixin for skills that provide a global shock resistance stat increase
mixin ShockResIncreaser {
  /// How much the stat is increased by, in percentage
  int get shkIncrease;
}

/// A mixin for skills that provide a global terror resistance stat increase
mixin TerrorResIncreaser {
  /// How much the stat is increased by, in percentage
  int get trrIncrease;
}

/// A mixin for skills that provide a global silence resistance stat increase
mixin SilenceResIncreaser {
  /// How much the stat is increased by, in percentage
  int get silIncrease;
}

/// A mixin for skills that provide a global death resistance stat increase
mixin DeathResIncreaser {
  /// How much the stat is increased by, in percentage
  int get dthIncrease;
}

/// A mixin for skills that provide a global debuff resistance stat increase
mixin DebuffResIncreaser {
  /// How much the stat is increased by, in percentage
  int get dbfIncrease;
}
