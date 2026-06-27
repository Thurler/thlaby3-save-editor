import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// An interface for skills that offer passive enhancements when using elements
abstract interface class ElementMultiplierEnhancer {
  /// The elements that will have damage increased
  List<Element> get elements;

  /// How much damage multiplier will be multiplied by
  double get multiplierIncrease;
}

/// An interface for skills that offer passive protection against elements
abstract interface class ElementProtector {
  /// The elements that will have damage reduced
  List<Element> get elements;

  /// How much damage will be reduced
  double get protection;
}

/// A mixin that merges [ElementProtector] functionality to a [UniqueSkill]
mixin ElementProtectorSkill on UniqueSkill implements ElementProtector {}

/// A mixin for skills that augment an [ElementProtector] skill with a reaction
/// effect
mixin ElementProtectionReactioner on SkillAugmentSkill {
  @override
  ElementProtectorSkill get baseSkill;
}
