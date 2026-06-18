import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

enum KoTriggerRange {
  self,
  allAllies;
}

enum KoEffectRange {
  self,
  frontline,
  frontlineMinusSelf,
  backline;
}

/// A mixin for skills that trigger upon a ko happening in the field
mixin KoReactioner {
  /// The range associated with KO detection
  KoTriggerRange get triggerRange;

  /// The range associated with the KO effect
  KoEffectRange get effectRange;
}

/// A mixin that merges [KoReactioner] functionality to a [UniqueSkill]
mixin KoReactionerSkill on UniqueSkill, KoReactioner {}

/// A specialization of [KoReactioner] that conditions the reaction on a set
/// of requirements being met
mixin ConditionedKoReactioner on KoReactioner {
  /// The requirements that must be met to make the reaction effect trigger
  List<EffectRequirement> get reactionRequirements;
}
