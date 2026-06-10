import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

/// A mixin to unify all character unique skills, be they spells, passives or
/// augments
mixin UniqueSkill on Skill {
  static List<UniqueSkill> get values =>
      (UncategorizedUniqueSkill.values as List<UniqueSkill>) +
      PassiveSkill.values +
      SkillAugmentSkill.values +
      SpellSkill.values +
      SpellAugmentSkill.values +
      ElementProtector.values +
      RaceSlayer.values +
      KoReactioner.values +
      FocusReactioner.values;
}

/// Enumeration of passive skills that don't have effects that are relevant to
/// the other classes
enum PassiveSkill implements UniqueSkill {
  // Reimu passives
  hakureiProtection("Hakurei's Divine Protection", 3),
  hakureiProtection2(
    "Hakurei's Divine Protection: Effect ↑",
    2,
    requirements: <Skill>[hakureiProtection],
  ),
  hakureiProtection3(
    "Hakurei's Divine Protection: Effect ↑+",
    2,
    requirements: <Skill>[hakureiProtection2],
  ),
  hakureiProtectionRange(
    "Hakurei's Divine Protection: Range ↑",
    2,
    requirements: <Skill>[hakureiProtection3],
  ),
  turnCounterPreservation(
    'Turn Counter Preservation',
    5,
    requirements: <Skill>[hakureiProtectionRange],
  ),
  turnCounterPreservation2(
    'Turn Counter Preservation+',
    5,
    requirements: <Skill>[turnCounterPreservation],
  ),
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  const PassiveSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <Skill>[],
  });
}

enum UncategorizedUniqueSkill implements UniqueSkill {
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  const UncategorizedUniqueSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <Skill>[],
  });
}
