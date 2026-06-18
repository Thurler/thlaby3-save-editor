/// A mixin for skills that cause paralysis to be inflicted
mixin ParalysisInflictor {
  /// The ailment duration
  int get parDuration;

  /// The ailment chance
  double get parChance;
}

/// A mixin for skills that cause silence to be inflicted
mixin SilenceInflictor {
  /// The ailment duration
  int get silDuration;

  /// The ailment chance
  double get silChance;
}

/// A mixin for skills that completely cleanse terror from the target
mixin TerrorCleanser {}

/// A mixin for skills that completely cleanse silence from the target
mixin SilenceCleanser {}
