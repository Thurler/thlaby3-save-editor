import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

/// An interface that signals that an augment's effect is somehow conditioned on
/// the character's turn count
abstract interface class TurnCountBasedAugment implements SkillAugment {
  /// Cap the effects of the turn count to the specified amount of the turn
  /// counter exceeds it. If null, no cap is applied
  int? get turnCountCap;
}

/// A mixin that signals that an augment's effect includes resetting the
/// character's turn count to zero
mixin TurnCountResetAugment on SkillAugment {}

/// A mixin that combines [TurnCountBasedAugment] with
/// [MultiplierMultiplyAugment] to amplify the effect based on turn count
mixin MultiplierMultiplyPerTurnAugment
    implements TurnCountBasedAugment, MultiplierMultiplyAugment {
  /// The final multiplier after [turns] have passed
  double multiplierForTurns(int turns) => 1 + (multiplier * turns);
}

/// A mixin that combines [TurnCountBasedAugment] with [DefenseBuffAugment] to
/// amplify the defense buff
mixin DefenseBuffPerTurnAugment
    implements TurnCountBasedAugment, DefenseBuffAugment {
  /// The final buff after [turns] have passed
  int defBuffForTurns(int turns) => defBuff * turns;
}

/// A mixin that combines [TurnCountBasedAugment] with [MindBuffAugment] to
/// amplify the defense buff
mixin MindBuffPerTurnAugment implements TurnCountBasedAugment, MindBuffAugment {
  /// The final buff after [turns] have passed
  int mndBuffForTurns(int turns) => mndBuff * turns;
}
