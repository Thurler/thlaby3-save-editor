import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

/// A mixin for skills that trigger upon a character focusing
mixin FocusReactioner on UniqueSkill {
  static List<FocusReactioner> get values => const <FocusReactioner>[
    // Reimu focus reactions
    focusedRecitation,
  ];
}
