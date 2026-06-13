import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that provide a percent-based heal
mixin PercentHealer on UniqueSkill {
  /// The heal percent
  double get healPercent;
}

/// A mixin for skills that provide a percent-based MP heal
mixin PercentMpHealer on UniqueSkill {
  /// The MP heal percent
  double get mpHealPercent;
}
