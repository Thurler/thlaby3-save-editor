/// An interface for skills that provide a percent-based heal
abstract interface class PercentHealer {
  /// The heal percent
  double get healPercent;
}

/// An interface for skills that provide a percent-based MP heal
abstract interface class PercentMpHealer {
  /// The MP heal percent
  double get mpHealPercent;
}

/// An interface for skills that provide a flat MP heal
abstract interface class FlatMpHealer {
  /// The MP heal amount
  int get mpHealAmount;
}
