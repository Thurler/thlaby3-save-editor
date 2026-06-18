import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

enum EnemyRace {
  youkai,
  other;
}

/// A mixin for skills that offer passive protection against elements
mixin RaceSlayer {
  /// The races that will take extra damage
  List<EnemyRace> get races;

  /// How much damage will be increased by
  double get slayBonus;
}

/// A mixin that merges [RaceSlayer] functionality to a [UniqueSkill]
mixin RaceSlayerSkill on UniqueSkill implements RaceSlayer {}

/// A mixin for skills that augment an [RaceSlayer] skill with a reaction effect
mixin RaceSlayReactioner on SkillAugmentSkill {
  @override
  RaceSlayerSkill get baseSkill;
}
