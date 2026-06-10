import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

/// A mixin for skills that offer passive protection against elements
mixin ElementProtector on UniqueSkill {
  /// The elements that will have damage reduced
  List<Element> get elements;

  /// How much damage will be reduced
  double get protection;

  static List<ElementProtector> get values => const <ElementProtector>[
    // Reimu element protectors
    armoredYinYangOrb,
  ];
}

/// A mixin for skills that augment an [ElementProtector] skill with a reaction
/// effect
mixin ElementProtectionReactioner on SkillAugmentSkill {
  @override
  ElementProtector get baseSkill;
}
