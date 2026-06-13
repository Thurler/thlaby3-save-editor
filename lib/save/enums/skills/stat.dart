import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that consume TP upon being activated
mixin TpConsumer on UniqueSkill {
  /// How much TP is consumed
  int get tpConsumed;
}
