import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that offer passive protection against elements
mixin ElementProtector {
  /// The elements that will have damage reduced
  List<Element> get elements;

  /// How much damage will be reduced
  double get protection;
}

/// A mixin that merges [ElementProtector] functionality to a [UniqueSkill]
mixin ElementProtectorSkill on UniqueSkill, ElementProtector {}

/// A mixin for skills that augment an [ElementProtector] skill with a reaction
/// effect
mixin ElementProtectionReactioner on SkillAugmentSkill {
  @override
  ElementProtectorSkill get baseSkill;
}
