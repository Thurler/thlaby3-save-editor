import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// An interface to unify behavior and attributes of a skill's activation
/// requirements
abstract interface class EffectRequirement {}

/// A requirement that checks a random number to decide if the effect triggers
class RandomNumberRequirement implements EffectRequirement {
  /// The percent chance used to determine if the effect will trigger
  final double chance;

  const RandomNumberRequirement(this.chance);
}

/// A requirement that checks if an unrelated skill is learned to determine if
/// the effect triggers. This is different from a skill augmenting another
/// directly, usually for when an augment applies to several skills
class LearnedSkillRequirement implements EffectRequirement {
  /// The skill that must be learned for the effect to trigger
  final UniqueSkill skill;

  const LearnedSkillRequirement(this.skill);
}

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

/// A requirement that checks if the specified character is in the frontline
class FrontlineCharacterRequirement implements EffectRequirement {
  /// The character that must be in the frontline
  final Character character;

  const FrontlineCharacterRequirement(this.character);
}
