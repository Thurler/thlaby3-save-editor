import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

enum AugmentRange {
  self,
  frontline;
}

/// A mixin for skills that augment a skill's functionalities
mixin SkillAugmentSkill on UniqueSkill {
  /// The skill the augment acts on
  UniqueSkill get baseSkill;

  /// The range to apply to the augment's effects. If null, copies the range
  /// from the original skill's effect
  AugmentRange? get augmentRange;

  static List<SkillAugmentSkill> get values => const <SkillAugmentSkill>[
    // Generic skill augments
    quickCharge2,
    // Reimu skill augments
    armoredYinYangOrb2,
    armoredYinYangOrbBoost,
    youkaiBuster2,
    youkaiBusterShield,
    reimuPrivileges2,
    reimuPrivilegesPerm,
    finalPrayer2,
  ];
}

/// A mixin for skills that augment another augment, effectively replacing it
mixin SkillAugmentChainSkill on SkillAugmentSkill {
  /// The augment the augment acts on
  SkillAugmentSkill get baseAugment;
}

/// A mixin that signals that an augment's effect is somehow conditioned on the
/// character's turn count
mixin TurnCountBasedAugment on SkillAugmentSkill {
  /// Cap the effects of the turn count to the specified amount of the turn
  /// counter exceeds it. If null, no cap is applied
  int? get turnCountCap;
}

/// A mixin that signals that an augment's effect includes resetting the
/// character's turn count to zero
mixin TurnCountResetAugment on SkillAugmentSkill {}

/// A mixin for augments that change a spell's attack buff
mixin AttackBuffAugment on SkillAugmentSkill implements AttackBuffer {
  /// How much the buff intensity increases by
  @override
  double get atkBuff;
}

/// A mixin for augments that change a spell's defense buff
mixin DefenseBuffAugment on SkillAugmentSkill implements DefenseBuffer {
  /// How much the buff intensity increases by
  @override
  double get defBuff;
}

/// A mixin for augments that change a spell's magic buff
mixin MagicBuffAugment on SkillAugmentSkill implements MagicBuffer {
  /// How much the buff intensity increases by
  @override
  double get magBuff;
}

/// A mixin for augments that change a spell's mind buff
mixin MindBuffAugment on SkillAugmentSkill implements MindBuffer {
  /// How much the buff intensity increases by
  @override
  double get mndBuff;
}

/// A mixin for augments that change a spell's speed buff
mixin SpeedBuffAugment on SkillAugmentSkill implements SpeedBuffer {
  /// How much the buff intensity increases by
  @override
  double get spdBuff;
}

/// A mixin for augments that change a spell's permanent attack buff
mixin PermanentAttackBuffAugment on SkillAugmentSkill
    implements PermanentAttackBuffer {
  /// How much the buff intensity increases by
  @override
  double get permAtkBuff;
}

/// A mixin for augments that change a spell's permanent defense buff
mixin PermanentDefenseBuffAugment on SkillAugmentSkill
    implements PermanentDefenseBuffer {
  /// How much the buff intensity increases by
  @override
  double get permDefBuff;
}

/// A mixin for augments that change a spell's permanent magic buff
mixin PermanentMagicBuffAugment on SkillAugmentSkill
    implements PermanentMagicBuffer {
  /// How much the buff intensity increases by
  @override
  double get permMagBuff;
}

/// A mixin for augments that change a spell's permanent mind buff
mixin PermanentMindBuffAugment on SkillAugmentSkill
    implements PermanentMindBuffer {
  /// How much the buff intensity increases by
  @override
  double get permMndBuff;
}

/// A mixin for augments that change a spell's permanent speed buff
mixin PermanentSpeedBuffAugment on SkillAugmentSkill
    implements PermanentSpeedBuffer {
  /// How much the buff intensity increases by
  @override
  double get permSpdBuff;
}

/// A mixin for augments that change a spell's HP regen buff
mixin HpRegenBuffAugment on SkillAugmentSkill implements HpRegenBuffer {
  /// How much the buff intensity increases by
  @override
  double get hpRegen;

  /// How many turns duration increases by
  @override
  double get hpRegenDuration;
}

/// A mixin for augments that change a spell's damage dealt buff
mixin DamageDealtBuffAugment on SkillAugmentSkill implements DamageDealtBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgDealtBuff;

  /// For how many more attacks the buff stays up for
  @override
  double get dmgDealtBuffDuration;
}

/// A mixin for augments that change a spell's damage received buff
mixin DamageReceivedBuffAugment on SkillAugmentSkill
    implements DamageReceivedBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgReceivedBuff;

  /// For how many more attacks the buff stays up for
  @override
  double get dmgReceivedBuffDuration;
}

/// A mixin for augments that change a skill's paralysis infliction
mixin ParalysisAugment on SkillAugmentSkill implements ParalysisInflictor {
  /// How much the ailment duration increases by
  @override
  double get parDuration;

  /// How much the ailment chance increases by
  @override
  double get parChance;
}

/// A mixin for augments that change an element protector's protection
mixin ElementProtectionAugment on SkillAugmentSkill
    implements ElementProtector {
  @override
  ElementProtector get baseSkill;

  /// How much damage reduction will be increased by
  @override
  double get protection;
}

/// A mixin for augments that change a race slay's damage boost
mixin RaceSlayAugment on SkillAugmentSkill implements RaceSlayer {
  @override
  RaceSlayer get baseSkill;

  /// How much damage boost will be increased by
  @override
  double get slayBonus;
}

/// A mixin for augments that change a ko reaction's effect
mixin KoReactionAugment on SkillAugmentSkill implements KoReactioner {
  @override
  KoReactioner get baseSkill;
}

/// A mixin for augments that change a focus reaction's effect
mixin FocusReactionAugment on SkillAugmentSkill implements FocusReactioner {
  @override
  FocusReactioner get baseSkill;
}

/// A mixin for augments that change a percent heal skill's potency
mixin PercentHealAugment on SkillAugmentSkill implements PercentHealer {
  /// How much the heal percent will be increased by
  @override
  double get healPercent;
}

/// A mixin for augments that change a percent MP heal skill's potency
mixin PercentMpHealAugment on SkillAugmentSkill implements PercentMpHealer {
  /// How much the heal percent will be increased by
  @override
  double get mpHealPercent;
}
