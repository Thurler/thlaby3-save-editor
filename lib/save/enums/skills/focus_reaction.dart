import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that trigger upon a character focusing
mixin FocusReactioner on UniqueSkill {
  static List<FocusReactioner> get values => const <FocusReactioner>[
    // Generic focus reactions
    focusedRecitation,
  ];
}

const FocusReactioner focusedRecitation = _FocusedRecitation();

class _FocusedRecitation implements FocusReactioner, DamageDealtBuffer {
  const _FocusedRecitation();

  @override
  String get prettyName => 'Focused Recitation';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  double get dmgDealtBuff => 50;

  @override
  double get dmgDealtBuffDuration => 1;
}
