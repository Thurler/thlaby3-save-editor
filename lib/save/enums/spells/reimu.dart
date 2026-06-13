import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/buff.dart';
import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/heal.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/skills/stat.dart';
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
const SpellAugmentSkill dreamSealDamageAplifier = _DreamSealDamageAmplifier();

const ElementProtector armoredYinYangOrb = _ArmoredYinYangOrb();
const SkillAugmentSkill armoredYinYangOrb2 = _ArmoredYinYangOrb2();
const SkillAugmentSkill armoredYinYangOrbBoost = _ArmoredYinYangOrbBoost();

const RaceSlayer youkaiBuster = _YoukaiBuster();
const SkillAugmentSkill youkaiBuster2 = _YoukaiBuster2();
const SkillAugmentSkill youkaiBusterShield = _YoukaiBusterShield();

const KoReactioner reimuPrivileges = _ReimuProtagonistPrivileges();
const SkillAugmentSkill reimuPrivileges2 = _ReimuProtagonistPrivileges2();
const SkillAugmentSkill reimuPrivilegesPerm =
    _ReimuProtagonistPrivilegesPermanent();
const KoReactioner reimuPrivilegesShare = _ReimuProtagonistPrivilegesShare();

const KoReactioner finalPrayer = _FinalPrayer();
const SkillAugmentSkill finalPrayer2 = _FinalPrayer2();
const KoReactioner finalPrayerRange = _FinalPrayerRange();
const KoReactioner trueFinalPrayer = _TrueFinalPrayer();

class _YinYangOrb implements DirectSpell, SilenceInflictor {
  const _YinYangOrb();

  @override
  String get prettyName => 'Treasure Sign "Treasured Ying-Yang Orb"';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 12;

  @override
  int get delay => 6000;

  @override
  int get cooldown => 0;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleEnemy;

  @override
  EffectRequirement? get castRequirement => null;

  @override
  int get accModifider => 10;

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
  double get silDuration => 8000;
}

class _YinYangOrbParAffix implements SpellAugmentSkill, ParalysisAugment {
  const _YinYangOrbParAffix();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: PAR Affix';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrb];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get parChance => 60;

  @override
  double get parDuration => 6000;
}

class _YinYangOrbPow implements PowAugment {
  const _YinYangOrbPow();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: POW ↑';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrb];

  @override
  DamageSpell get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get pow => 16;
}

class _YinYangOrbDelay implements DelayAugment {
  const _YinYangOrbDelay();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Delay ↓';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrbPow];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get delay => 750;
}

class _YinYangOrbParBoost implements SpellAugmentChainSkill, ParalysisAugment {
  const _YinYangOrbParBoost();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: PAR Boost';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[armoredYinYangOrbBoost];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  SpellAugmentSkill get baseAugment => yinYangOrbParAffix;

  @override
  double get parChance => 70;

  @override
  double get parDuration => 10000;
}

class _YinYangOrbDelay2 implements SpellAugmentChainSkill, DelayAugment {
  const _YinYangOrbDelay2();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Delay ↓+';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrbDelay];

  @override
  SpellSkill get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  SpellAugmentSkill get baseAugment => yinYangOrbDelay;

  @override
  double get delay => 1500;
}

class _YinYangOrbCooldownPow implements PowAugment, CooldownAugment {
  const _YinYangOrbCooldownPow();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Cooldown to POW';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[yinYangOrbDelay, PassiveSkill.hakureiProtection3];

  @override
  DamageSpell get baseSkill => yinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get pow => 40;

  @override
  int get cooldown => 2;
}

class _BarrierTalisman implements SpellSkill, DefenseBuffer, MindBuffer {
  const _BarrierTalisman();

  @override
  String get prettyName => 'Barrier Talisman';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 8;

  @override
  int get delay => 6600;

  @override
  int get cooldown => 0;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  EffectRequirement? get castRequirement => null;

  @override
  double get defBuff => 24;

  @override
  double get mndBuff => 24;
}

class _BarrierTalisman2
    implements SpellAugmentSkill, DefenseBuffAugment, MindBuffAugment {
  const _BarrierTalisman2();

  @override
  String get prettyName => 'Barrier Talisman: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[barrierTalisman];

  @override
  SpellSkill get baseSkill => barrierTalisman;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get defBuff => 12;

  @override
  double get mndBuff => 12;
}

class _RecoveryTalisman implements SpellSkill, HpRegenBuffer {
  const _RecoveryTalisman();

  @override
  String get prettyName => 'Recovery Talisman';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  int get mpCost => 10;

  @override
  int get delay => 6000;

  @override
  int get cooldown => 0;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.singleAlly;

  @override
  EffectRequirement? get castRequirement => null;

  @override
  double get hpRegen => 10;

  @override
  double get hpRegenDuration => 5;
}

class _RecoveryTalisman2 implements SpellAugmentSkill, HpRegenBuffAugment {
  const _RecoveryTalisman2();

  @override
  String get prettyName => 'Recovery Talisman: Effect ↑';

  @override
  int get cost => 5;

  @override
  List<Skill> get requirements => const <Skill>[recoveryTalisman];

  @override
  SpellSkill get baseSkill => recoveryTalisman;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get hpRegen => 2;

  @override
  double get hpRegenDuration => 1;
}

class _PersuasionNeedle implements DirectSpell {
  const _PersuasionNeedle();

  @override
  String get prettyName => 'Persuasion Needle';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[recoveryTalisman];

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
  EffectRequirement? get castRequirement => null;

  @override
  int get accModifider => -16;

  @override
  double get multiplier => 166;

  @override
  double get defGuard => 50;

  @override
  double get mndGuard => 0;

  @override
  double get atkFactor => 136;
}

class _PersuasionNeedleMultiplier implements MultiplierAugment {
  const _PersuasionNeedleMultiplier();

  @override
  String get prettyName => 'Persuasion Needle: Damage Multiplier ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[persuasionNeedle];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get multiplier => 30;
}

class _PersuasionNeedleGuard implements GuardAugment {
  const _PersuasionNeedleGuard();

  @override
  String get prettyName => 'Persuasion Needle: Guard Pierce';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[persuasionNeedleMultiplier];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get defGuard => -35;

  @override
  double get mndGuard => 0;
}

class _PersuasionNeedleHpDrain implements HpDrainAugment {
  const _PersuasionNeedleHpDrain();

  @override
  String get prettyName => 'Persuasion Needle: HP Drain Augment';

  @override
  int get cost => 4;

  @override
  List<Skill> get requirements => const <Skill>[persuasionNeedleMultiplier];

  @override
  DamageSpell get baseSkill => persuasionNeedle;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get hpDrainPercent => 8;
}

class _GreatHakureiBarrier implements SpellSkill, DefenseBuffer, MindBuffer {
  const _GreatHakureiBarrier();

  @override
  String get prettyName => 'Great Hakurei Barrier';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[reimuPrivileges, barrierTalisman];

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
  EffectRequirement? get castRequirement => const TurnMultipleRequirement(2);

  @override
  double get defBuff => 50;

  @override
  double get mndBuff => 50;
}

class _GreatHakureiBarrierTurnConversion
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
  List<Skill> get requirements => const <Skill>[greatHakureiBarrier];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  int? get turnCountCap => null;

  @override
  double get defBuff => 4;

  @override
  double get mndBuff => 4;
}

class _GreatHakureiBarrierSelfProtect
    implements SpellAugmentSkill, DamageReceivedBuffAugment {
  const _GreatHakureiBarrierSelfProtect();

  @override
  String get prettyName => 'Great Hakurei Barrier: Self-Protection Augment';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[reimuPrivileges2];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  AugmentRange? get augmentRange => AugmentRange.self;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get dmgReceivedBuff => 25;

  @override
  double get dmgReceivedBuffDuration => 1;
}

class _GreatHakureiBarrierRegen
    implements SpellAugmentSkill, HpRegenBuffAugment {
  const _GreatHakureiBarrierRegen();

  @override
  String get prettyName => 'Great Hakurei Barrier: Regen Augment';

  @override
  int get cost => 5;

  @override
  List<Skill> get requirements =>
      const <Skill>[greatHakureiBarrierTurn, flashExorcismBarrier];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => const TurnCountRequirement(4);

  @override
  double get hpRegen => 5;

  @override
  double get hpRegenDuration => 4;
}

class _GreatHakureiBarrierRegen2
    implements SpellAugmentChainSkill, HpRegenBuffAugment {
  const _GreatHakureiBarrierRegen2();

  @override
  String get prettyName => 'Great Hakurei Barrier: Regen ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[flashExorcismBarrierTurn, persuasionNeedleHpDrain];

  @override
  SpellSkill get baseSkill => greatHakureiBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => const TurnCountRequirement(4);

  @override
  SpellAugmentSkill get baseAugment => greatHakureiBarrierRegen;

  @override
  double get hpRegen => 6;

  @override
  double get hpRegenDuration => 5;
}

class _HakureiTalisman
    implements SpellSkill, DefenseBuffer, MindBuffer, HpRegenBuffer {
  const _HakureiTalisman();

  @override
  String get prettyName => 'Hakurei Talisman';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[barrierTalisman2, recoveryTalisman2];

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
  EffectRequirement? get castRequirement => null;

  @override
  double get defBuff => 24;

  @override
  double get mndBuff => 24;

  @override
  double get hpRegen => 10;

  @override
  double get hpRegenDuration => 4;
}

class _FlashExorcismBarrier implements DirectSpell, MagicSpell {
  const _FlashExorcismBarrier();

  @override
  String get prettyName => 'Sign III "Flash Exorcism Barrier"';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[recoveryTalisman];

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
  EffectRequirement? get castRequirement => const TurnMultipleRequirement(2);

  @override
  int get accModifider => 10000;

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

class _FlashExorcismBarrierDelay implements DelayAugment {
  const _FlashExorcismBarrierDelay();

  @override
  String get prettyName => 'Flash Exorcism Barrier: Delay ↓';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[flashExorcismBarrier];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get delay => 1200;
}

class _FlashExorcismBarrierTurnConversion
    implements MultiplierAugment, TurnCountBasedAugment, TurnCountResetAugment {
  const _FlashExorcismBarrierTurnConversion();

  @override
  String get prettyName => 'Flash Exorcism Barrier: Turn Conversion';

  @override
  int get cost => 5;

  @override
  List<Skill> get requirements =>
      const <Skill>[greatHakureiBarrierRegen, flashExorcismBarrierDelay];

  @override
  DamageSpell get baseSkill => flashExorcismBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  int? get turnCountCap => null;

  @override
  double get multiplier => 10;
}

class _FlashExorcismBarrierDamageTaken
    implements SpellAugmentSkill, DamageReceivedBuffAugment {
  const _FlashExorcismBarrierDamageTaken();

  @override
  String get prettyName =>
      'Flash Exorcism Barrier: Party Damage Taken ↓ Augment';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[
    greatHakureiBarrierSelfProtect,
    greatHakureiBarrierRegen,
    flashExorcismBarrierTurn,
  ];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => const TurnCountRequirement(4);

  @override
  double get dmgReceivedBuff => 12;

  @override
  double get dmgReceivedBuffDuration => 1;
}

class _FlashExorcismBarrierDamageTaken2
    implements
        SpellAugmentChainSkill,
        DamageReceivedBuffAugment,
        DamageDealtBuffAugment {
  const _FlashExorcismBarrierDamageTaken2();

  @override
  String get prettyName =>
      'Flash Exorcism Barrier: Party Damage Taken ↓ Augment+';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[reimuPrivilegesShare, flashExorcismBarrierDamageTaken];

  @override
  SpellSkill get baseSkill => flashExorcismBarrier;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => const TurnCountRequirement(4);

  @override
  SpellAugmentSkill get baseAugment => flashExorcismBarrierDamageTaken;

  @override
  double get dmgReceivedBuff => 15;

  @override
  double get dmgReceivedBuffDuration => 1;

  @override
  double get dmgDealtBuff => 15;

  @override
  double get dmgDealtBuffDuration => 1;
}

class _DreamSeal implements MagicSpell {
  const _DreamSeal();

  @override
  String get prettyName => 'Spirit Sign "Dream Seal"';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements =>
      const <Skill>[persuasionNeedle, focusedRecitation];

  @override
  int get mpCost => 24;

  @override
  int get delay => 3000;

  @override
  int get cooldown => 0;

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  SpellTargetMode get targetMode => SpellTargetMode.allEnemies;

  @override
  EffectRequirement? get castRequirement => null;

  @override
  int get accModifider => 8;

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
    implements
        MultiplierMultiplyAugment,
        TurnCountBasedAugment,
        TurnCountResetAugment {
  const _DreamSealTurnConversion();

  @override
  String get prettyName => 'Dream Seal: Turn Conversion';

  @override
  int get cost => 5;

  @override
  List<Skill> get requirements => const <Skill>[dreamSeal];

  @override
  DamageSpell get baseSkill => dreamSeal;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  int? get turnCountCap => 20;

  @override
  double get multiplier => 1.08;
}

class _DreamSealDamageAmplifier implements MultiplierMultiplyAugment {
  const _DreamSealDamageAmplifier();

  @override
  String get prettyName => 'Dream Seal: Damage ↑ Amplifier';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[dreamSeal];

  @override
  DamageSpell get baseSkill => dreamSeal;

  @override
  AugmentRange? get augmentRange => null;

  @override
  EffectRequirement? get augmentRequirement => null;

  @override
  double get multiplier => 1.5;
}

class _ArmoredYinYangOrb implements ElementProtector {
  const _ArmoredYinYangOrb();

  @override
  String get prettyName => 'Armored Yin-Yang Orb';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<Element> get elements => const <Element>[Element.spi];

  @override
  double get protection => 12;
}

class _ArmoredYinYangOrb2 implements ElementProtectionAugment {
  const _ArmoredYinYangOrb2();

  @override
  String get prettyName => 'Armored Yin-Yang Orb+';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements =>
      const <Skill>[armoredYinYangOrb, yinYangOrbParAffix];

  @override
  ElementProtector get baseSkill => armoredYinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  List<Element> get elements => baseSkill.elements;

  @override
  double get protection => 6;
}

class _ArmoredYinYangOrbBoost
    implements ElementProtectionReactioner, DamageDealtBuffAugment {
  const _ArmoredYinYangOrbBoost();

  @override
  String get prettyName => 'Armored Yin-Yang Orb: Boost Conversion';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[armoredYinYangOrb2];

  @override
  ElementProtector get baseSkill => armoredYinYangOrb;

  @override
  AugmentRange? get augmentRange => null;

  @override
  double get dmgDealtBuff => 16;

  @override
  double get dmgDealtBuffDuration => 1;
}

class _YoukaiBuster implements RaceSlayer {
  const _YoukaiBuster();

  @override
  String get prettyName => 'Youkai Buster';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  List<EnemyRace> get races => const <EnemyRace>[EnemyRace.youkai];

  @override
  double get slayBonus => 12;
}

class _YoukaiBuster2 implements RaceSlayAugment {
  const _YoukaiBuster2();

  @override
  String get prettyName => 'Youkai Buster+';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[youkaiBuster];

  @override
  RaceSlayer get baseSkill => youkaiBuster;

  @override
  AugmentRange? get augmentRange => null;

  @override
  List<EnemyRace> get races => baseSkill.races;

  @override
  double get slayBonus => 8;
}

class _YoukaiBusterShield
    implements RaceSlayReactioner, DamageReceivedBuffAugment {
  const _YoukaiBusterShield();

  @override
  String get prettyName => 'Youkai Buster: Shield Conversion';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[youkaiBuster2];

  @override
  RaceSlayer get baseSkill => youkaiBuster;

  @override
  AugmentRange? get augmentRange => null;

  @override
  double get dmgReceivedBuff => 10;

  @override
  double get dmgReceivedBuffDuration => 1;
}

class _ReimuProtagonistPrivileges
    implements
        KoReactioner,
        AttackBuffer,
        DefenseBuffer,
        MagicBuffer,
        MindBuffer,
        SpeedBuffer {
  const _ReimuProtagonistPrivileges();

  @override
  String get prettyName => "Reimu's Protagonist Privileges";

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[];

  @override
  KoEffectRange get effectRange => KoEffectRange.self;

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.allAllies;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get atkBuff => 12;

  @override
  double get defBuff => 12;

  @override
  double get magBuff => 12;

  @override
  double get mndBuff => 12;

  @override
  double get spdBuff => 12;
}

class _ReimuProtagonistPrivileges2
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
  List<Skill> get requirements => const <Skill>[reimuPrivileges];

  @override
  KoReactioner get baseSkill => reimuPrivileges;

  @override
  AugmentRange? get augmentRange => null;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get atkBuff => 8;

  @override
  double get defBuff => 8;

  @override
  double get magBuff => 8;

  @override
  double get mndBuff => 8;

  @override
  double get spdBuff => 8;
}

class _ReimuProtagonistPrivilegesPermanent
    implements
        KoReactionAugment,
        SkillAugmentChainSkill,
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
  List<Skill> get requirements =>
      const <Skill>[youkaiBusterShield, reimuPrivileges2];

  @override
  KoReactioner get baseSkill => reimuPrivileges;

  @override
  SkillAugmentSkill get baseAugment => reimuPrivileges2;

  @override
  AugmentRange? get augmentRange => null;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get atkBuff => 4;

  @override
  double get defBuff => 4;

  @override
  double get magBuff => 4;

  @override
  double get mndBuff => 4;

  @override
  double get spdBuff => 4;

  @override
  double get permAtkBuff => 4;

  @override
  double get permDefBuff => 4;

  @override
  double get permMagBuff => 4;

  @override
  double get permMndBuff => 4;

  @override
  double get permSpdBuff => 4;
}

class _ReimuProtagonistPrivilegesShare
    implements
        KoReactioner,
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
  List<Skill> get requirements => const <Skill>[reimuPrivileges2];

  @override
  KoEffectRange get effectRange => KoEffectRange.frontlineMinusSelf;

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.allAllies;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get atkBuff => 12;

  @override
  double get defBuff => 12;

  @override
  double get magBuff => 12;

  @override
  double get mndBuff => 12;

  @override
  double get spdBuff => 12;
}

class _FinalPrayer implements KoReactioner, PercentHealer {
  const _FinalPrayer();

  @override
  String get prettyName => 'Final Prayer';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[focusedRecitation];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.frontlineMinusSelf;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get healPercent => 50;
}

class _FinalPrayer2 implements KoReactionAugment, PercentHealAugment {
  const _FinalPrayer2();

  @override
  String get prettyName => 'Final Prayer: Effect ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[finalPrayer];

  @override
  KoReactioner get baseSkill => finalPrayer;

  @override
  AugmentRange? get augmentRange => null;

  @override
  KoTriggerRange get triggerRange => baseSkill.triggerRange;

  @override
  KoEffectRange get effectRange => baseSkill.effectRange;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get healPercent => 50;
}

class _FinalPrayerRange implements KoReactioner, PercentHealer {
  const _FinalPrayerRange();

  @override
  String get prettyName => 'Final Prayer: Range ↑';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[finalPrayer];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.backline;

  @override
  EffectRequirement? get reactionRequirement => null;

  @override
  double get healPercent => 33;
}

class _TrueFinalPrayer implements KoReactioner, PercentHealer, TpConsumer {
  const _TrueFinalPrayer();

  @override
  String get prettyName => "Reimu's True Prayer";

  @override
  int get cost => 6;

  @override
  List<Skill> get requirements =>
      const <Skill>[dreamSealDamageAplifier, finalPrayerRange];

  @override
  KoTriggerRange get triggerRange => KoTriggerRange.self;

  @override
  KoEffectRange get effectRange => KoEffectRange.self;

  @override
  EffectRequirement? get reactionRequirement => const TpCountRequirement(10);

  @override
  double get healPercent => 100;

  @override
  int get tpConsumed => 10;
}
