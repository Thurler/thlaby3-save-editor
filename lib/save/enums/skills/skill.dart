import 'package:thlaby3_save_editor/save/skill_tree.dart';

/// The class representing the common attributes between skill types
abstract interface class Skill {
  /// The skill's name as displayed in-game
  String get prettyName;

  /// The amount of skill points required to learn the skill
  int get cost;

  /// The skill's hard-coded requirements in the skill tree
  ///
  /// The complete requirements may depend on the character holding the skill,
  /// this only lists the requirements that are present for all characters
  ///
  /// In order to access a skill's requirements for a specific skill tree's
  /// instance, refer to the [SkillNode.requirements] getter
  List<Skill> get requirements;
}
