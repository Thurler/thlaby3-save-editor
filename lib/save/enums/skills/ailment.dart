/// An interface for skills that cause paralysis to be inflicted
abstract interface class ParalysisInflictor {
  /// The ailment duration
  int get parDuration;

  /// The ailment chance
  double get parChance;
}

/// An interface for skills that cause silence to be inflicted
abstract interface class SilenceInflictor {
  /// The ailment duration
  int get silDuration;

  /// The ailment chance
  double get silChance;
}

/// An interface for skills that cause shock to be inflicted
abstract interface class ShockInflictor {
  /// The ailment chance
  double get shkChance;
}

/// An interface for skills that completely cleanse terror from the target
abstract interface class TerrorCleanser {}

/// An interface for skills that completely cleanse silence from the target
abstract interface class SilenceCleanser {}

/// An interface for skills that offer passive enhancements when applying
/// ailments
abstract interface class AilmentMultiplierEnhancer {
  /// How much ailment duration will be multiplied by
  double get durationIncrease;

  /// How much ailment chance will be multiplied by
  double get chanceIncrease;
}
