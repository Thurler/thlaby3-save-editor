/// A mixin for skills that provide a percent-based heal
mixin PercentHealer {
  /// The heal percent
  double get healPercent;
}

/// A mixin for skills that provide a percent-based MP heal
mixin PercentMpHealer {
  /// The MP heal percent
  double get mpHealPercent;
}

/// A mixin for skills that provide a flat MP heal
mixin FlatMpHealer {
  /// The MP heal amount
  int get mpHealAmount;
}
