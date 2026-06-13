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

/// An interface to unify behavior and attributes of a skill's activation
/// requirements
abstract interface class EffectRequirement {}

/// A requirement that checks if the current MP count is below a percent of the
/// character's max MP
class BelowMpPercentRequirement implements EffectRequirement {
  /// The percent of max MP used to trigger
  final int mpPercent;

  const BelowMpPercentRequirement(this.mpPercent);
}

/// A requirement that checks if the character has at least [tpCount] TP
/// available
class TpCountRequirement implements EffectRequirement {
  /// The TP count needed to trigger the effect
  final int tpCount;

  const TpCountRequirement(this.tpCount);
}

/// A requirement that checks if the current turn count is at least a specific
/// value
class TurnCountRequirement implements EffectRequirement {
  /// The number the turn counter must be at or above
  final int turnCount;

  const TurnCountRequirement(this.turnCount);
}

/// A requirement that checks if the current turn count is a multiple of a
/// specific value
class TurnMultipleRequirement implements EffectRequirement {
  /// The number the turn counter must be a multiple of
  final int multipleOf;

  const TurnMultipleRequirement(this.multipleOf);
}
