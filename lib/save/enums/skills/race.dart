import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

enum EnemyRace {
  youkai;
}

/// A mixin for skills that offer passive protection against elements
mixin RaceSlayer on UniqueSkill {
  /// The races that will take extra damage
  List<EnemyRace> get races;

  /// How much damage will be increased by
  double get slayBonus;

  static List<RaceSlayer> get values => const <RaceSlayer>[
    // Reimu race slayers
    youkaiBuster,
  ];
}

/// A mixin for skills that augment an [RaceSlayer] skill with a reaction effect
mixin RaceSlayReactioner on SkillAugmentSkill {
  @override
  RaceSlayer get baseSkill;
}
