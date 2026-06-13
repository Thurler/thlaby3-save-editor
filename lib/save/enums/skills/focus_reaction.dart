import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';

/// A mixin for skills that trigger upon a character focusing
mixin FocusReactioner on UniqueSkill {
  /// The requirements that must be met to make the reaction effect trigger. If
  /// null, then no requirement is needed
  List<EffectRequirement>? get reactionRequirements;

  static List<FocusReactioner> get values => const <FocusReactioner>[
    // Generic focus reactions
    focusedRecitation,
    quickCharge,
  ];
}

const FocusReactioner focusedRecitation = _FocusedRecitation();
const FocusReactioner quickCharge = _QuickCharge();
const FocusReactionAugment quickCharge2 = _QuickCharge2();

class _FocusedRecitation implements FocusReactioner, DamageDealtBuffer {
  const _FocusedRecitation();

  @override
  String get prettyName => 'Focused Recitation';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EffectRequirement>? get reactionRequirements => null;

  @override
  double get dmgDealtBuff => 50;

  @override
  double get dmgDealtBuffDuration => 1;
}

class _QuickCharge implements FocusReactioner, TpConsumer, PercentMpHealer {
  const _QuickCharge();

  @override
  String get prettyName => 'Quick Charge';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EffectRequirement>? get reactionRequirements =>
      const <EffectRequirement>[
    BelowMpPercentRequirement(33),
    TpCountRequirement(2),
  ];

  @override
  int get tpConsumed => 2;

  @override
  double get mpHealPercent => 33;
}

class _QuickCharge2
    implements FocusReactionAugment, TpConsumer, PercentMpHealAugment {
  const _QuickCharge2();

  @override
  String get prettyName => 'Quick Charge';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[quickCharge];

  @override
  AugmentRange? get augmentRange => null;

  @override
  FocusReactioner get baseSkill => quickCharge;

  @override
  List<EffectRequirement>? get reactionRequirements =>
      const <EffectRequirement>[
    BelowMpPercentRequirement(33),
    TpCountRequirement(3),
  ];

  @override
  int get tpConsumed => 3;

  @override
  double get mpHealPercent => 17;
}
