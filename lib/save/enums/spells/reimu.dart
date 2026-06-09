import 'package:thlaby3_save_editor/save/enums/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/ailment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';
import 'package:thlaby3_save_editor/save/enums/target.dart';

const SpellSkill yinYangOrb = _YinYangOrb();
const SpellAugmentSkill yinYangOrbParAffix = _YinYangOrbParAffix();
const SpellAugmentSkill yinYangOrbPow = _YinYangOrbPow();
const SpellAugmentSkill yinYangOrbDelay = _YinYangOrbDelay();
const SpellAugmentSkill yinYangOrbParBoost = _YinYangOrbParBoost();
const SpellAugmentSkill yinYangOrbDelay2 = _YinYangOrbDelay2();
const SpellAugmentSkill yinYangOrbCooldownPow = _YinYangOrbCooldownPow();

class _YinYangOrb implements DamageSpell, DirectSpell, SilenceInflictor {
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
  List<Element> get elements => const <Element>[Element.spi];

  @override
  TargetMode get targetMode => TargetMode.singleEnemy;

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

class _YinYangOrbParAffix implements SpellAugmentSkill, ParalysisInflictor {
  const _YinYangOrbParAffix();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: PAR Affix';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrb];

  @override
  SpellSkill get baseSpell => yinYangOrb;

  @override
  double get parChance => 60;

  @override
  double get parDuration => 6000;
}

class _YinYangOrbPow implements SpellAugmentSkill, PowAugment {
  const _YinYangOrbPow();

  @override
  String get prettyName => 'Treasured Ying-Yang Orb: POW ↑';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrb];

  @override
  SpellSkill get baseSpell => yinYangOrb;

  @override
  double get pow => 16;
}

class _YinYangOrbDelay implements SpellAugmentSkill, DelayAugment {
  const _YinYangOrbDelay();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Delay ↓';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements => const <Skill>[yinYangOrbPow];

  @override
  SpellSkill get baseSpell => yinYangOrb;

  @override
  double get delay => 750;
}

class _YinYangOrbParBoost
    implements SpellAugmentChainSkill, ParalysisInflictor {
  const _YinYangOrbParBoost();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: PAR Boost';

  @override
  int get cost => 2;

  @override
  List<Skill> get requirements =>
      const <Skill>[UncategorizedUniqueSkill.armoredYinYangOrbBoost];

  @override
  SpellSkill get baseSpell => yinYangOrb;

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
  SpellSkill get baseSpell => yinYangOrb;

  @override
  SpellAugmentSkill get baseAugment => yinYangOrbDelay;

  @override
  double get delay => 1500;
}

class _YinYangOrbCooldownPow
    implements SpellAugmentSkill, PowAugment, CooldownAugment {
  const _YinYangOrbCooldownPow();

  @override
  String get prettyName => 'Treasured Yin-Yang Orb: Cooldown to POW';

  @override
  int get cost => 3;

  @override
  List<Skill> get requirements => const <Skill>[
    yinYangOrbDelay,
    UncategorizedUniqueSkill.hakureiProtection3,
  ];

  @override
  SpellSkill get baseSpell => yinYangOrb;

  @override
  double get pow => 40;

  @override
  int get cooldown => 2;
}
