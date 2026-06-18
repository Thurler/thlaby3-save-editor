import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

enum AugmentRange {
  self,
  frontline;
}

/// A common interface for entities that augment a skill's effect, be they other
/// skills or natural augments
abstract interface class SkillAugment {
  /// The skill the augment acts on
  UniqueSkill get baseSkill;
}

/// A mixin for augments that are inherent to a given skill, meaning they are
/// not a separate, learnable entity, and are only activated based on specific
/// requirements
mixin NaturalAugment implements SkillAugment, ConditionedEffect {}

/// A mixin that provides a skill with a set of natural augment effects that can
/// be triggered without learning any other skills
mixin NaturallyAugmentedSkill on UniqueSkill {
  /// The skill's natural augments that are not tied to a separate learnable
  /// skill. These are always available, and usually have specific requirements
  /// be met to trigger, separate from the skill's main effect
  List<NaturalAugment> get naturalAugments;
}

/// A mixin for augments that require a custom range for their effects
mixin CustomAugmentRange on SkillAugment {
  /// The range to apply to the augment's effects. This overrides the original
  /// skill's range, to make it so for example a single target skill can have a
  /// party-wide augment effect
  AugmentRange get augmentRange;
}

/// A mixin for skills that augment a skill's functionalities
mixin SkillAugmentSkill on UniqueSkill implements SkillAugment {
  static const List<SkillAugmentSkill> values = <SkillAugmentSkill>[
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

/// A mixin for skills that augment another natural augment, effectively
/// replacing it
mixin NaturalAugmentChainSkill on SkillAugmentSkill {
  /// The augment the augment acts on
  NaturalAugment get baseAugment;
}

/// A mixin for skills that augment another augment skill, effectively replacing
/// it
mixin SkillAugmentChainSkill on SkillAugmentSkill {
  /// The augment the augment acts on
  SkillAugmentSkill get baseAugment;
}

/// A mixin that signals that an augment's effect is somehow conditioned on the
/// character's turn count
mixin TurnCountBasedAugment on SkillAugment {
  /// Cap the effects of the turn count to the specified amount of the turn
  /// counter exceeds it. If null, no cap is applied
  int? get turnCountCap;
}

/// A mixin that signals that an augment's effect includes resetting the
/// character's turn count to zero
mixin TurnCountResetAugment on SkillAugment {}

/// A mixin for augments that change a spell's attack buff
mixin AttackBuffAugment on SkillAugment implements AttackBuffer {
  /// How much the buff intensity increases by
  @override
  int get atkBuff;
}

/// A mixin for augments that change a spell's defense buff
mixin DefenseBuffAugment on SkillAugment implements DefenseBuffer {
  /// How much the buff intensity increases by
  @override
  int get defBuff;
}

/// A mixin for augments that change a spell's magic buff
mixin MagicBuffAugment on SkillAugment implements MagicBuffer {
  /// How much the buff intensity increases by
  @override
  int get magBuff;
}

/// A mixin for augments that change a spell's mind buff
mixin MindBuffAugment on SkillAugment implements MindBuffer {
  /// How much the buff intensity increases by
  @override
  int get mndBuff;
}

/// A mixin for augments that change a spell's speed buff
mixin SpeedBuffAugment on SkillAugment implements SpeedBuffer {
  /// How much the buff intensity increases by
  @override
  int get spdBuff;
}

/// A mixin for augments that change a spell's accuracy buff
mixin AccuracyBuffAugment on SkillAugment implements AccuracyBuffer {
  /// How much the buff intensity increases by
  @override
  int get accBuff;
}

/// A mixin for augments that change a spell's permanent attack buff
mixin PermanentAttackBuffAugment on SkillAugment
    implements PermanentAttackBuffer {
  /// How much the buff intensity increases by
  @override
  int get permAtkBuff;
}

/// A mixin for augments that change a spell's permanent defense buff
mixin PermanentDefenseBuffAugment on SkillAugment
    implements PermanentDefenseBuffer {
  /// How much the buff intensity increases by
  @override
  int get permDefBuff;
}

/// A mixin for augments that change a spell's permanent magic buff
mixin PermanentMagicBuffAugment on SkillAugment
    implements PermanentMagicBuffer {
  /// How much the buff intensity increases by
  @override
  int get permMagBuff;
}

/// A mixin for augments that change a spell's permanent mind buff
mixin PermanentMindBuffAugment on SkillAugment implements PermanentMindBuffer {
  /// How much the buff intensity increases by
  @override
  int get permMndBuff;
}

/// A mixin for augments that change a spell's permanent speed buff
mixin PermanentSpeedBuffAugment on SkillAugment
    implements PermanentSpeedBuffer {
  /// How much the buff intensity increases by
  @override
  int get permSpdBuff;
}

/// A mixin for augments that change a spell's permanent accuracy buff
mixin PermanentAccuracyBuffAugment on SkillAugment
    implements PermanentAccuracyBuffer {
  /// How much the buff intensity increases by
  @override
  int get permAccBuff;
}

/// A mixin for augments that change a spell's HP regen buff
mixin HpRegenBuffAugment on SkillAugment implements HpRegenBuffer {
  /// How much the buff intensity increases by
  @override
  double get hpRegen;

  /// How many turns duration increases by
  @override
  int get hpRegenDuration;
}

/// A mixin for augments that change a spell's damage dealt buff
mixin DamageDealtBuffAugment on SkillAugment implements DamageDealtBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgDealtBuff;

  /// For how many more attacks the buff stays up for
  @override
  int get dmgDealtBuffDuration;
}

/// A mixin for augments that change a spell's damage received buff
mixin DamageReceivedBuffAugment on SkillAugment
    implements DamageReceivedBuffer {
  /// How much the buff intensity increases by
  @override
  double get dmgReceivedBuff;

  /// For how many more attacks the buff stays up for
  @override
  int get dmgReceivedBuffDuration;
}

/// A mixin for augments that change a skill's paralysis infliction
mixin ParalysisAugment on SkillAugment, ParalysisInflictor {
  /// How much the ailment duration increases by
  @override
  int get parDuration;

  /// How much the ailment chance increases by
  @override
  double get parChance;
}

/// A mixin for augments that change an element protector's protection
mixin ElementProtectionAugment on SkillAugment implements ElementProtector {
  @override
  ElementProtectorSkill get baseSkill;

  /// How much damage reduction will be increased by
  @override
  double get protection;
}

/// A mixin for augments that change a race slay's damage boost
mixin RaceSlayAugment on SkillAugment implements RaceSlayer {
  @override
  RaceSlayerSkill get baseSkill;

  /// How much damage boost will be increased by
  @override
  double get slayBonus;
}

/// A mixin for augments that change a ko reaction's effect
mixin KoReactionAugment on SkillAugment implements KoReactioner {
  @override
  KoReactionerSkill get baseSkill;
}

/// A mixin for augments that change a focus reaction's effect
mixin FocusReactionAugment on SkillAugment implements FocusReactioner {
  @override
  FocusReactionerSkill get baseSkill;
}

/// A mixin for augments that change a percent heal skill's potency
mixin PercentHealAugment on SkillAugment implements PercentHealer {
  /// How much the heal percent will be increased by
  @override
  double get healPercent;
}

/// A mixin for augments that change a percent MP heal skill's potency
mixin PercentMpHealAugment on SkillAugment implements PercentMpHealer {
  /// How much the heal percent will be increased by
  @override
  double get mpHealPercent;
}
