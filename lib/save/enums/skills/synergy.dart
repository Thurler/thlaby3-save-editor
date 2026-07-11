import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

mixin SynergySkill on UniqueSkill implements AllIncreaser {
  /// The value by which all stats are increased by
  int get synergyIncrease;

  @override
  int get atkIncrease => synergyIncrease;

  @override
  int get defIncrease => synergyIncrease;

  @override
  int get magIncrease => synergyIncrease;

  @override
  int get mndIncrease => synergyIncrease;

  @override
  int get spdIncrease => synergyIncrease;

  @override
  int get accIncrease => synergyIncrease;

  @override
  int get evaIncrease => synergyIncrease;
}

mixin SynergyAugmentSkill on SkillAugmentSkill implements AllIncreaseAugment {
  /// The value by which all stats are further increased by
  int get synergyIncrease;

  @override
  int get atkIncrease => synergyIncrease;

  @override
  int get defIncrease => synergyIncrease;

  @override
  int get magIncrease => synergyIncrease;

  @override
  int get mndIncrease => synergyIncrease;

  @override
  int get spdIncrease => synergyIncrease;

  @override
  int get accIncrease => synergyIncrease;

  @override
  int get evaIncrease => synergyIncrease;
}

const SynergySkill yakumoHousehold = _YakumoHousehold();
const SynergyAugmentSkill yakumoHousehold2 = _YakumoHousehold2();

class _YakumoHousehold with UniqueSkill, SynergySkill {
  const _YakumoHousehold();

  @override
  String get prettyName => 'Yakumo Household';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  int get synergyIncrease => 8;
}

class _YakumoHousehold2
    with UniqueSkill, SkillAugmentSkill, SynergyAugmentSkill {
  const _YakumoHousehold2();

  @override
  String get prettyName => 'Yakumo Household';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[yakumoHousehold];

  @override
  UniqueSkill get baseSkill => yakumoHousehold;

  @override
  int get synergyIncrease => 4;
}
