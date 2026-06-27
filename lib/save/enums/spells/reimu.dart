import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/requirement.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
import 'package:thlaby3_save_editor/save/enums/skills/turn_count.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

const DamageSpell yinYangOrb = _YinYangOrb();
const SpellAugmentSkill yinYangOrbParAffix = _YinYangOrbParAffix();
const SpellAugmentSkill yinYangOrbPow = _YinYangOrbPow();
const SpellAugmentSkill yinYangOrbDelay = _YinYangOrbDelay();
const SpellAugmentSkill yinYangOrbParBoost = _YinYangOrbParBoost();
const SpellAugmentSkill yinYangOrbDelay2 = _YinYangOrbDelay2();
const SpellAugmentSkill yinYangOrbCooldownPow = _YinYangOrbCooldownPow();

const SpellSkill barrierTalisman = _BarrierTalisman();
const SpellAugmentSkill barrierTalisman2 = _BarrierTalisman2();

const SpellSkill recoveryTalisman = _RecoveryTalisman();
const SpellAugmentSkill recoveryTalisman2 = _RecoveryTalisman2();

const DamageSpell persuasionNeedle = _PersuasionNeedle();
const SpellAugmentSkill persuasionNeedleMultiplier =
    _PersuasionNeedleMultiplier();
const SpellAugmentSkill persuasionNeedleGuard = _PersuasionNeedleGuard();
const SpellAugmentSkill persuasionNeedleHpDrain = _PersuasionNeedleHpDrain();

const SpellSkill greatHakureiBarrier = _GreatHakureiBarrier();
const SpellAugmentSkill greatHakureiBarrierTurn =
    _GreatHakureiBarrierTurnConversion();
const SpellAugmentSkill greatHakureiBarrierSelfProtect =
    _GreatHakureiBarrierSelfProtect();
const SpellAugmentSkill greatHakureiBarrierRegen = _GreatHakureiBarrierRegen();
const SpellAugmentSkill greatHakureiBarrierRegen2 =
    _GreatHakureiBarrierRegen2();

const SpellSkill hakureiTalisman = _HakureiTalisman();

const DamageSpell flashExorcismBarrier = _FlashExorcismBarrier();
const SpellAugmentSkill flashExorcismBarrierDelay =
    _FlashExorcismBarrierDelay();
const SpellAugmentSkill flashExorcismBarrierTurn =
    _FlashExorcismBarrierTurnConversion();
const SpellAugmentSkill flashExorcismBarrierDamageTaken =
    _FlashExorcismBarrierDamageTaken();
const SpellAugmentSkill flashExorcismBarrierDamageTaken2 =
    _FlashExorcismBarrierDamageTaken2();

const DamageSpell dreamSeal = _DreamSeal();
const SpellAugmentSkill dreamSealTurn = _DreamSealTurnConversion();
const SpellAugmentSkill dreamSealDamageAmplifier = _DreamSealDamageAmplifier();

const ElementProtectorSkill armoredYinYangOrb = _ArmoredYinYangOrb();
const SkillAugmentSkill armoredYinYangOrb2 = _ArmoredYinYangOrb2();
const SkillAugmentSkill armoredYinYangOrbBoost = _ArmoredYinYangOrbBoost();

const RaceSlayerSkill youkaiBuster = _YoukaiBuster();
const SkillAugmentSkill youkaiBuster2 = _YoukaiBuster2();
const SkillAugmentSkill youkaiBusterShield = _YoukaiBusterShield();

const KoReactionerSkill reimuPrivileges = _ReimuProtagonistPrivileges();
const SkillAugmentSkill reimuPrivileges2 = _ReimuProtagonistPrivileges2();
const SkillAugmentSkill reimuPrivilegesPerm =
    _ReimuProtagonistPrivilegesPermanent();
const KoReactionerSkill reimuPrivilegesShare =
    _ReimuProtagonistPrivilegesShare();

const KoReactionerSkill finalPrayer = _FinalPrayer();
const SkillAugmentSkill finalPrayer2 = _FinalPrayer2();
const KoReactionerSkill finalPrayerRange = _FinalPrayerRange();
const KoReactionerSkill trueFinalPrayer = _TrueFinalPrayer();

class _YinYangOrb with UniqueSkill implements DirectSpell, SilenceInflictor {
  const _YinYangOrb();

  @override
  String get prettyName => 'Treasure Sign "Treasured Ying-Yang Orb"';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  int get mpCost => 12;

  @override
  int get delay => 6000;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleEnemy;

  @override
  int get accModifier => 10;

  @override
  double get multiplier => 125;

  @override
  double get defGuard => 50;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => 125;

  @override
  double get silChance => 48;

  @override
  int get silDuration => 8000;
}

class _YinYangOrbParAffix
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, ParalysisAugment {
  const _YinYangOrbParAffix();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: PAR Affix';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[yinYangOrb];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  double get parChance => 60;

  @override
  int get parDuration => 6000;
}

class _YinYangOrbPow
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, PowAugment {
  const _YinYangOrbPow();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: POW ↑';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[yinYangOrb];

  @override
  DamageSpell get baseSkill => yinYangOrb;

  @override
  double get pow => 16;
}

class _YinYangOrbDelay
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DelayAugment {
  const _YinYangOrbDelay();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Delay ↓';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[yinYangOrbPow];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  int get delay => 750;
}

class _YinYangOrbParBoost
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentChainSkill, ParalysisAugment {
  const _YinYangOrbParBoost();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: PAR Boost';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[armoredYinYangOrbBoost];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  SpellAugmentSkill get baseAugment => yinYangOrbParAffix;

  @override
  double get parChance => 70;

  @override
  int get parDuration => 10000;
}

class _YinYangOrbDelay2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentChainSkill, DelayAugment {
  const _YinYangOrbDelay2();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Delay ↓+';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[yinYangOrbDelay];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  SpellAugmentSkill get baseAugment => yinYangOrbDelay;

  @override
  int get delay => 1500;
}

class _YinYangOrbCooldownPow
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, PowAugment, CooldownAugment {
  const _YinYangOrbCooldownPow();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Cooldown to POW';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[yinYangOrbDelay, PassiveSkill.hakureiProtection3];

  @override
  DamageSpell get baseSkill => yinYangOrb;

  @override
  double get pow => 40;

  @override
  int get cooldown => 2;
}

class _BarrierTalisman
    with UniqueSkill
    implements SpellSkill, DefenseBuffer, MindBuffer {
  const _BarrierTalisman();

  @override
  String get prettyName => 'Barrier Talisman';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  int get mpCost => 8;

  @override
  int get delay => 6600;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  int get defBuff => 24;

  @override
  int get mndBuff => 24;
}

class _BarrierTalisman2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DefenseBuffAugment, MindBuffAugment {
  const _BarrierTalisman2();

  @override
  String get prettyName => 'Barrier Talisman: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[barrierTalisman];

  @override
  SpellSkill get baseSkill => barrierTalisman;

  @override
  int get defBuff => 12;

  @override
  int get mndBuff => 12;
}

class _RecoveryTalisman with UniqueSkill implements SpellSkill, HpRegenBuffer {
  const _RecoveryTalisman();

  @override
  String get prettyName => 'Recovery Talisman';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  int get mpCost => 10;

  @override
  int get delay => 6000;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  double get hpRegen => 10;

  @override
  int get hpRegenDuration => 5;
}

class _RecoveryTalisman2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, HpRegenBuffAugment {
  const _RecoveryTalisman2();

  @override
  String get prettyName => 'Recovery Talisman: Effect ↑';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[recoveryTalisman];

  @override
  SpellSkill get baseSkill => recoveryTalisman;

  @override
  double get hpRegen => 2;

  @override
  int get hpRegenDuration => 1;
}

class _PersuasionNeedle with UniqueSkill implements DirectSpell, CooldownSpell {
  const _PersuasionNeedle();

  @override
  String get prettyName => 'Persuasion Needle';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[recoveryTalisman];

  @override
  int get mpCost => 20;

  @override
  int get delay => 6000;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.wnd];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.rowEnemyDiminished;

  @override
  int get accModifier => -16;

  @override
  double get multiplier => 166;

  @override
  double get defGuard => 50;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => 136;
}

class _PersuasionNeedleMultiplier
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, MultiplierAugment {
  const _PersuasionNeedleMultiplier();

  @override
  String get prettyName => 'Persuasion Needle: Damage Multiplier ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[persuasionNeedle];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  double get multiplier => 30;
}

class _PersuasionNeedleGuard
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, GuardAugment {
  const _PersuasionNeedleGuard();

  @override
  String get prettyName => 'Persuasion Needle: Guard Pierce';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[persuasionNeedleMultiplier];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  double get defGuard => -35;

  @override
  double get mndGuard => 0;
}

class _PersuasionNeedleHpDrain
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, HpDrainAugment {
  const _PersuasionNeedleHpDrain();

  @override
  String get prettyName => 'Persuasion Needle: HP Drain Augment';

  @override
  int get cost => 4;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[persuasionNeedleMultiplier];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  double get hpDrainPercent => 8;
}

class _GreatHakureiBarrier
    with UniqueSkill
    implements ConditionedSpellSkill, DefenseBuffer, MindBuffer, CooldownSpell {
  const _GreatHakureiBarrier();

  @override
  String get prettyName => 'Great Hakurei Barrier';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[reimuPrivileges, barrierTalisman];

  @override
  int get mpCost => 28;

  @override
  int get delay => 4000;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allAllies;

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get defBuff => 50;

  @override
  int get mndBuff => 50;
}

class _GreatHakureiBarrierTurnConversion
    with
        UniqueSkill,
        SkillAugmentSkill,
        DefenseBuffPerTurnAugment,
        MindBuffPerTurnAugment
    implements
        SpellAugmentSkill,
        TurnCountBasedAugment,
        TurnCountResetAugment,
        DefenseBuffAugment,
        MindBuffAugment {
  const _GreatHakureiBarrierTurnConversion();

  @override
  String get prettyName => 'Great Hakurei Barrier: Turn Conversion';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[greatHakureiBarrier];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  int? get turnCountCap => null;

  @override
  int get defBuff => 4;

  @override
  int get mndBuff => 4;
}

class _GreatHakureiBarrierSelfProtect
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentSkill,
        CustomAugmentRange,
        DamageReceivedBuffAugment {
  const _GreatHakureiBarrierSelfProtect();

  @override
  String get prettyName => 'Great Hakurei Barrier: Self-Protection Augment';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[reimuPrivileges2];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  AugmentRange get augmentRange => AugmentRange.self;

  @override
  double get dmgReceivedBuff => 25;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _GreatHakureiBarrierRegen
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, ConditionedEffect, HpRegenBuffAugment {
  const _GreatHakureiBarrierRegen();

  @override
  String get prettyName => 'Great Hakurei Barrier: Regen Augment';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[greatHakureiBarrierTurn, flashExorcismBarrier];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[TurnCountRequirement(4)];

  @override
  double get hpRegen => 5;

  @override
  int get hpRegenDuration => 4;
}

class _GreatHakureiBarrierRegen2
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentChainSkill, ConditionedEffect, HpRegenBuffAugment {
  const _GreatHakureiBarrierRegen2();

  @override
  String get prettyName => 'Great Hakurei Barrier: Regen ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[flashExorcismBarrierTurn, persuasionNeedleHpDrain];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  SpellAugmentSkill get baseAugment => greatHakureiBarrierRegen;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[TurnCountRequirement(4)];

  @override
  double get hpRegen => 6;

  @override
  int get hpRegenDuration => 5;
}

class _HakureiTalisman
    with UniqueSkill
    implements
        SpellSkill,
        DefenseBuffer,
        MindBuffer,
        HpRegenBuffer,
        CooldownSpell {
  const _HakureiTalisman();

  @override
  String get prettyName => 'Hakurei Talisman';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[barrierTalisman2, recoveryTalisman2];

  @override
  int get mpCost => 14;

  @override
  int get delay => 4500;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  int get defBuff => 24;

  @override
  int get mndBuff => 24;

  @override
  double get hpRegen => 10;

  @override
  int get hpRegenDuration => 4;
}

class _FlashExorcismBarrier
    with UniqueSkill
    implements ConditionedSpellSkill, DirectSpell, MagicSpell, CooldownSpell {
  const _FlashExorcismBarrier();

  @override
  String get prettyName => 'Sign III "Flash Exorcism Barrier"';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[recoveryTalisman];

  @override
  int get mpCost => 32;

  @override
  int get delay => 2000;

  @override
  int get cooldown => 2;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allAlliesDiminished;

  @override
  List<EffectRequirement> get castRequirements =>
      const <EffectRequirement>[TurnMultipleRequirement(2)];

  @override
  int get accModifier => 10000;

  @override
  double get multiplier => 100;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => -30;

  @override
  double get magFactor => -30;
}

class _FlashExorcismBarrierDelay
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DelayAugment {
  const _FlashExorcismBarrierDelay();

  @override
  String get prettyName => 'Flash Exorcism Barrier: Delay ↓';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[flashExorcismBarrier];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  int get delay => 1200;
}

class _FlashExorcismBarrierTurnConversion
    with UniqueSkill, SkillAugmentSkill, MultiplierMultiplyPerTurnAugment
    implements
        SpellAugmentSkill,
        MultiplierMultiplyAugment,
        TurnCountBasedAugment,
        TurnCountResetAugment {
  const _FlashExorcismBarrierTurnConversion();

  @override
  String get prettyName => 'Flash Exorcism Barrier: Turn Conversion';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[greatHakureiBarrierRegen, flashExorcismBarrierDelay];

  @override
  DamageSpell get baseSkill => flashExorcismBarrier;

  @override
  int? get turnCountCap => null;

  @override
  double get multiplier => 0.1;
}

class _FlashExorcismBarrierDamageTaken
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, ConditionedEffect, DamageReceivedBuffAugment {
  const _FlashExorcismBarrierDamageTaken();

  @override
  String get prettyName =>
      'Flash Exorcism Barrier: Party Damage Taken ↓ Augment';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[
    greatHakureiBarrierSelfProtect,
    greatHakureiBarrierRegen,
    flashExorcismBarrierTurn,
  ];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[TurnCountRequirement(4)];

  @override
  double get dmgReceivedBuff => 12;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _FlashExorcismBarrierDamageTaken2
    with UniqueSkill, SkillAugmentSkill
    implements
        SpellAugmentChainSkill,
        ConditionedEffect,
        DamageReceivedBuffAugment,
        DamageDealtBuffAugment {
  const _FlashExorcismBarrierDamageTaken2();

  @override
  String get prettyName =>
      'Flash Exorcism Barrier: Party Damage Taken ↓ Augment+';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[
    reimuPrivilegesShare,
    flashExorcismBarrierDamageTaken,
  ];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[TurnCountRequirement(4)];

  @override
  SpellAugmentSkill get baseAugment => flashExorcismBarrierDamageTaken;

  @override
  double get dmgReceivedBuff => 15;

  @override
  int get dmgReceivedBuffDuration => 1;

  @override
  double get dmgDealtBuff => 15;

  @override
  int get dmgDealtBuffDuration => 1;
}

class _DreamSeal with UniqueSkill implements MagicSpell {
  const _DreamSeal();

  @override
  String get prettyName => 'Spirit Sign "Dream Seal"';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[persuasionNeedle, focusedRecitation];

  @override
  int get mpCost => 24;

  @override
  int get delay => 3000;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allEnemies;

  @override
  int get accModifier => 8;

  @override
  double get multiplier => 166;

  @override
  double get defGuard => 0;

  @override
  double get mndGuard => 50;

  @override
  double get magFactor => 144;
}

class _DreamSealTurnConversion
    with UniqueSkill, SkillAugmentSkill, MultiplierMultiplyPerTurnAugment
    implements
        SpellAugmentSkill,
        MultiplierMultiplyAugment,
        TurnCountBasedAugment,
        TurnCountResetAugment {
  const _DreamSealTurnConversion();

  @override
  String get prettyName => 'Dream Seal: Turn Conversion';

  @override
  int get cost => 5;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[dreamSeal];

  @override
  DamageSpell get baseSkill => dreamSeal;

  @override
  int? get turnCountCap => 20;

  @override
  double get multiplier => 0.08;
}

class _DreamSealDamageAmplifier
    with UniqueSkill, SkillAugmentSkill
    implements SpellAugmentSkill, DamageDealtAmplifyAugment {
  const _DreamSealDamageAmplifier();

  @override
  String get prettyName => 'Dream Seal: Damage ↑ Amplifier';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[dreamSeal];

  @override
  DamageSpell get baseSkill => dreamSeal;

  @override
  double get dmgDealtAmplification => 1.5;
}

class _ArmoredYinYangOrb
    with UniqueSkill
    implements ElementProtectorSkill, ConditionedEffect {
  const _ArmoredYinYangOrb();

  @override
  String get prettyName => 'Armored Yin-Yang Orb';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  double get protection => 12;
}

class _ArmoredYinYangOrb2
    with UniqueSkill, SkillAugmentSkill
    implements ElementProtectionAugment {
  const _ArmoredYinYangOrb2();

  @override
  String get prettyName => 'Armored Yin-Yang Orb+';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[armoredYinYangOrb, yinYangOrbParAffix];

  @override
  ElementProtectorSkill get baseSkill => armoredYinYangOrb;

  @override
  List<Element> get elements => baseSkill.elements;

  @override
  double get protection => 6;
}

class _ArmoredYinYangOrbBoost
    with UniqueSkill, SkillAugmentSkill
    implements ElementProtectionReactioner, DamageDealtBuffAugment {
  const _ArmoredYinYangOrbBoost();

  @override
  String get prettyName => 'Armored Yin-Yang Orb: Boost Conversion';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[armoredYinYangOrb2];

  @override
  ElementProtectorSkill get baseSkill => armoredYinYangOrb;

  @override
  double get dmgDealtBuff => 16;

  @override
  int get dmgDealtBuffDuration => 1;
}

class _YoukaiBuster
    with UniqueSkill
    implements RaceSlayerSkill, ConditionedEffect {
  const _YoukaiBuster();

  @override
  String get prettyName => 'Youkai Buster';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  List<EffectRequirement> get effectRequirements =>
      const <EffectRequirement>[FrontlineSelfRequirement()];

  @override
  List<EnemyRace> get races => const <EnemyRace>[EnemyRace.youkai];

  @override
  double get slayBonus => 12;
}

class _YoukaiBuster2
    with UniqueSkill, SkillAugmentSkill
    implements RaceSlayAugment {
  const _YoukaiBuster2();

  @override
  String get prettyName => 'Youkai Buster+';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[youkaiBuster];

  @override
  RaceSlayerSkill get baseSkill => youkaiBuster;

  @override
  List<EnemyRace> get races => baseSkill.races;

  @override
  double get slayBonus => 8;
}

class _YoukaiBusterShield
    with UniqueSkill, SkillAugmentSkill
    implements RaceSlayReactioner, DamageReceivedBuffAugment {
  const _YoukaiBusterShield();

  @override
  String get prettyName => 'Youkai Buster: Shield Conversion';

  @override
  int get cost => 2;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[youkaiBuster2];

  @override
  RaceSlayerSkill get baseSkill => youkaiBuster;

  @override
  double get dmgReceivedBuff => 10;

  @override
  int get dmgReceivedBuffDuration => 1;
}

class _ReimuProtagonistPrivileges
    with UniqueSkill, KoReactionerSkill
    implements
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer {
  static const int buffAmount = 12;

  const _ReimuProtagonistPrivileges();

  @override
  String get prettyName => "Reimu's Protagonist Privileges";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[];

  @override
  KoEffectRange get effectRange => KoEffectRange.self;

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.allAllies;

  @override
  int get atkBuff => buffAmount;

  @override
  int get defBuff => buffAmount;

  @override
  int get magBuff => buffAmount;

  @override
  int get mndBuff => buffAmount;

  @override
  int get spdBuff => buffAmount;
}

class _ReimuProtagonistPrivileges2
    with UniqueSkill, SkillAugmentSkill
    implements
        KoReactionAugment,
        AttackBuffAugment,
        DefenseBuffAugment,
        MagicBuffAugment,
        MindBuffAugment,
        SpeedBuffAugment {
  const _ReimuProtagonistPrivileges2();

  @override
  String get prettyName => "Reimu's Protagonist Privileges: Effect ↑";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[reimuPrivileges];

  @override
  KoReactionerSkill get baseSkill => reimuPrivileges;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  int get atkBuff => 8;

  @override
  int get defBuff => 8;

  @override
  int get magBuff => 8;

  @override
  int get mndBuff => 8;

  @override
  int get spdBuff => 8;
}

class _ReimuProtagonistPrivilegesPermanent
    with UniqueSkill, SkillAugmentSkill
    implements
        SkillAugmentChainSkill,
        KoReactionAugment,
        AttackBuffAugment,
        DefenseBuffAugment,
        MagicBuffAugment,
        MindBuffAugment,
        SpeedBuffAugment,
        PermanentAttackBuffAugment,
        PermanentDefenseBuffAugment,
        PermanentMagicBuffAugment,
        PermanentMindBuffAugment,
        PermanentSpeedBuffAugment {
  const _ReimuProtagonistPrivilegesPermanent();

  @override
  String get prettyName =>
      "Reimu's Protagonist Privileges: Persistent Conversion";

  @override
  int get cost => 4;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[youkaiBusterShield, reimuPrivileges2];

  @override
  KoReactionerSkill get baseSkill => reimuPrivileges;

  @override
  SkillAugmentSkill get baseAugment => reimuPrivileges2;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  int get atkBuff => 4;

  @override
  int get defBuff => 4;

  @override
  int get magBuff => 4;

  @override
  int get mndBuff => 4;

  @override
  int get spdBuff => 4;

  @override
  int get permAtkBuff => 4;

  @override
  int get permDefBuff => 4;

  @override
  int get permMagBuff => 4;

  @override
  int get permMndBuff => 4;

  @override
  int get permSpdBuff => 4;
}

class _ReimuProtagonistPrivilegesShare
    with UniqueSkill, KoReactionerSkill
    implements
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer {
  const _ReimuProtagonistPrivilegesShare();

  @override
  String get prettyName => "Reimu's Protagonist Privileges: Effect Share";

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[reimuPrivileges2];

  @override
  KoEffectRange get effectRange => KoEffectRange.frontlineMinusSelf;

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.allAllies;

  @override
  int get atkBuff => _ReimuProtagonistPrivileges.buffAmount;

  @override
  int get defBuff => _ReimuProtagonistPrivileges.buffAmount;

  @override
  int get magBuff => _ReimuProtagonistPrivileges.buffAmount;

  @override
  int get mndBuff => _ReimuProtagonistPrivileges.buffAmount;

  @override
  int get spdBuff => _ReimuProtagonistPrivileges.buffAmount;
}

class _FinalPrayer
    with UniqueSkill, KoReactionerSkill
    implements PercentHealer {
  const _FinalPrayer();

  @override
  String get prettyName => 'Final Prayer';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[focusedRecitation];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.frontlineMinusSelf;

  @override
  double get healPercent => 50;
}

class _FinalPrayer2
    with UniqueSkill, SkillAugmentSkill
    implements KoReactionAugment, PercentHealAugment {
  const _FinalPrayer2();

  @override
  String get prettyName => 'Final Prayer: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[finalPrayer];

  @override
  KoReactionerSkill get baseSkill => finalPrayer;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  double get healPercent => 50;
}

class _FinalPrayerRange
    with UniqueSkill, KoReactionerSkill
    implements PercentHealer {
  const _FinalPrayerRange();

  @override
  String get prettyName => 'Final Prayer: Range ↑';

  @override
  int get cost => 3;

  @override
  List<UniqueSkill> get requirements => const <UniqueSkill>[finalPrayer];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.backline;

  @override
  double get healPercent => 33;
}

class _TrueFinalPrayer
    with UniqueSkill, KoReactionerSkill
    implements ConditionedKoReactioner, PercentHealer, TpConsumer {
  const _TrueFinalPrayer();

  @override
  String get prettyName => "Reimu's True Prayer";

  @override
  int get cost => 6;

  @override
  List<UniqueSkill> get requirements =>
      const <UniqueSkill>[dreamSealDamageAmplifier, finalPrayerRange];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.self;

  @override
  List<EffectRequirement> get reactionRequirements =>
      const <EffectRequirement>[TpCountRequirement(10)];

  @override
  double get healPercent => 100;

  @override
  int get tpConsumed => 10;
}
