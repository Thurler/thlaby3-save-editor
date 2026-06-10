import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that cause paralysis to be inflicted
mixin ParalysisInflictor on UniqueSkill {
  /// The ailment duration
  double get parDuration;

  /// The ailment chance
  double get parChance;
}

/// A mixin for skills that cause silence to be inflicted
mixin SilenceInflictor on UniqueSkill {
  /// The ailment duration
  double get silDuration;

  /// The ailment chance
  double get silChance;
}
