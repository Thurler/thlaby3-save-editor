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

/// An interface for skills that completely cleanse terror from the target
abstract interface class TerrorCleanser {}

/// An interface for skills that completely cleanse silence from the target
abstract interface class SilenceCleanser {}
