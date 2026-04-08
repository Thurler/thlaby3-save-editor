import 'package:thlaby3_save_editor/save/enums/skill.dart';
import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// A struct to hold data regarding a character's unique skill data for their
/// skill tree
typedef UniqueSkillData = ({
  UniqueSkill skill,
  LevelGate levelGate,
  int column,
});

/// The characters in the game and the static data relating to their in-game
/// attributes
enum Character {
  reimu(
    <Mastery>[],
    <Personality>[],
    <UniqueSkillData>[],
  ),
  renko(
    <Mastery>[],
    <Personality>[],
    <UniqueSkillData>[],
  );

  /// The filename to use when reading character portraits
  String get filename => (index + 1).toString().padLeft(3, '0');

  /// The unique skills in this character's unique skill tree
  final List<UniqueSkillData> uniqueSkills;

  /// The masteries this character has in the training skill tree
  final List<Mastery> masteries;

  /// The personalities this character has in the training skill tree
  final List<Personality> personalities;

  const Character(
    this.masteries,
    this.personalities,
    this.uniqueSkills,
  );
}
