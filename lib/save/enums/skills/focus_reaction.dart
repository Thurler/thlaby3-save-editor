import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// An interface for skills that trigger upon a character focusing
abstract interface class FocusReactioner {}

/// A specialization of [FocusReactioner] that conditions the reaction on a set
/// of requirements being met
abstract interface class ConditionedFocusReactioner implements FocusReactioner {
  /// The requirements that must be met to make the reaction effect trigger
  List<EffectRequirement> get reactionRequirements;
}

/// A mixin that merges [FocusReactioner] functionality to a [UniqueSkill]
mixin FocusReactionerSkill on UniqueSkill implements FocusReactioner {}

const FocusReactionerSkill focusedRecitation = _FocusedRecitation();
const FocusReactionerSkill quickCharge = _QuickCharge();
const SkillAugmentSkill quickCharge2 = _QuickCharge2();

class _FocusedRecitation implements FocusReactionerSkill, DamageDealtBuffer {
  const _FocusedRecitation();

  @override
  String get prettyName => 'Focused Recitation';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  double get dmgDealtBuff => 50;

  @override
  int get dmgDealtBuffDuration => 1;
}

class _QuickCharge
    implements
        FocusReactionerSkill,
        ConditionedFocusReactioner,
        TpConsumer,
        PercentMpHealer {
  const _QuickCharge();

  @override
  String get prettyName => 'Quick Charge';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EffectRequirement> get reactionRequirements => const <EffectRequirement>[
    BelowMpPercentRequirement(33),
    TpCountRequirement(2),
  ];

  @override
  int get tpConsumed => 2;

  @override
  double get mpHealPercent => 33;
}

class _QuickCharge2
    implements
        SkillAugmentSkill,
        FocusReactionAugment,
        ConditionedFocusReactioner,
        TpConsumer,
        PercentMpHealAugment {
  const _QuickCharge2();

  @override
  String get prettyName => 'Quick Charge+';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[quickCharge];

  @override
  FocusReactionerSkill get baseSkill => quickCharge;

  @override
  List<EffectRequirement> get reactionRequirements => const <EffectRequirement>[
    BelowMpPercentRequirement(33),
    TpCountRequirement(3),
  ];

  @override
  int get tpConsumed => 3;

  @override
  double get mpHealPercent => 17;
}
