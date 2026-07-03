/// An interface for skills that completely cleanse attack debuffs from the
/// target
abstract interface class AttackDebuffCleanser {}

/// An interface for skills that completely cleanse defense debuffs from the
/// target
abstract interface class DefenseDebuffCleanser {}

/// An interface for skills that completely cleanse magic debuffs from the
/// target
abstract interface class MagicDebuffCleanser {}

/// An interface for skills that completely cleanse mind debuffs from the
/// target
abstract interface class MindDebuffCleanser {}

/// An interface for skills that completely cleanse speed debuffs from the
/// target
abstract interface class SpeedDebuffCleanser {}

/// An interface for skills that completely cleanse accuracy debuffs from the
/// target
abstract interface class AccuracyDebuffCleanser {}

/// An interface for skills that completely cleanse evasion debuffs from the
/// target
abstract interface class EvasionDebuffCleanser {}

/// An interface for skills that completely cleanse all stat debuffs from the
/// target
abstract interface class AllDebuffCleanser
    implements
        AttackDebuffCleanser,
        DefenseDebuffCleanser,
        MagicDebuffCleanser,
        MindDebuffCleanser,
        SpeedDebuffCleanser,
        AccuracyDebuffCleanser,
        EvasionDebuffCleanser {}

/// An interface for skills that provide a percent reduction to the ATB bar
abstract interface class PercentAtbDecreaser {
  /// The amount ATB is multiplied by (defaults to 1)
  double get atbDecreaseFactor;
}

/// An interface for skills that offer passive enhancements when applying
/// debuffs
abstract interface class DebuffMultiplierEnhancer {
  /// How much debuff duration will be multiplied by
  double get debuffDurationIncrease;

  /// How much debuff chance will be multiplied by
  double get debuffChanceIncrease;
}
