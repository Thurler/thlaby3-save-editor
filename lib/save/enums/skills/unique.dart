import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

/// A mixin to unify all character unique skills, be they spells, passives or
/// augments
mixin UniqueSkill on Skill {
  static List<UniqueSkill> get values =>
      (UncategorizedUniqueSkill.values as List<UniqueSkill>) +
      SpellSkill.values +
      SpellAugmentSkill.values;
}

enum UncategorizedUniqueSkill implements UniqueSkill {
  hakureiProtection("Hakurei's Divine Protection", 3),
  barrierTalisman('Barrier Talisman', 3),
  recoveryTalisman('Recovery Talisman', 3),
  armoredYinYangOrb('Armored Yin-Yang Orb', 3),
  youkaiBuster('Youkai Buster', 3),
  reimuPrivileges("Reimu's Protagonist Privileges", 3),
  barrierTalisman2(
    'Barrier Talisman: Effect ↑',
    3,
    requirements: <Skill>[barrierTalisman],
  ),
  recoveryTalisman2(
    'Recovery Talisman: Effect ↑',
    5,
    requirements: <Skill>[recoveryTalisman],
  ),
  persuasionNeedle(
    'Persuasion Needle',
    3,
    requirements: <Skill>[recoveryTalisman],
  ),
  focusedRecitation('Focused Recitation', 3),
  armoredYinYangOrb2(
    'Armored Yin-Yang Orb+',
    2,
    requirements: <Skill>[armoredYinYangOrb, yinYangOrbParAffix],
  ),
  hakureiProtection2(
    "Hakurei's Divine Protection: Effect ↑",
    2,
    requirements: <Skill>[hakureiProtection],
  ),
  greatHakureiBarrier(
    'Great Hakurei Barrier',
    3,
    requirements: <Skill>[reimuPrivileges, barrierTalisman],
  ),
  hakureiTalisman(
    'Hakurei Talisman',
    3,
    requirements: <Skill>[barrierTalisman2, recoveryTalisman2],
  ),
  flashExorcismBarrier(
    'Sign III "Flash Exorcism Barrier"',
    3,
    requirements: <Skill>[recoveryTalisman],
  ),
  hakureiProtection3(
    "Hakurei's Divine Protection: Effect ↑+",
    2,
    requirements: <Skill>[hakureiProtection2],
  ),
  youkaiBuster2(
    'Youkai Buster+',
    2,
    requirements: <Skill>[youkaiBuster],
  ),
  reimuPrivileges2(
    "Reimu's Protagonist Privileges: Effect ↑",
    3,
    requirements: <Skill>[reimuPrivileges],
  ),
  greatHakureiBarrierTurn(
    'Great Hakurei Barrier: Turn Conversion',
    5,
    requirements: <Skill>[greatHakureiBarrier],
  ),
  persuasionNeedleMult(
    'Persuasion Needle: Damage Multiplier ↑',
    3,
    requirements: <Skill>[persuasionNeedle],
  ),
  dreamSeal(
    'Spirit Sign "Dream Seal"',
    3,
    requirements: <Skill>[persuasionNeedle, focusedRecitation],
  ),
  finalPrayer(
    'Final Prayer',
    3,
    requirements: <Skill>[focusedRecitation],
  ),
  armoredYinYangOrbBoost(
    'Armored Yin-Yang Orb: Boost Conversion',
    2,
    requirements: <Skill>[armoredYinYangOrb2],
  ),
  hakureiProtectionRange(
    "Hakurei's Divine Protection: Range ↑",
    2,
    requirements: <Skill>[hakureiProtection3],
  ),
  youkaiBusterShield(
    'Youkai Buster: Shield Conversion',
    2,
    requirements: <Skill>[youkaiBuster2],
  ),
  greatHakureiBarrierSelf(
    'Great Hakurei Barrier: Self-Protection Augment',
    3,
    requirements: <Skill>[reimuPrivileges2],
  ),
  greatHakureiBarrierRegen(
    'Great Hakurei Barrier: Regen Augment',
    5,
    requirements: <Skill>[greatHakureiBarrierTurn, flashExorcismBarrier],
  ),
  flashExorcismBarrierDelay(
    'Flash Exorcism Barrier: Delay ↓',
    3,
    requirements: <Skill>[flashExorcismBarrier],
  ),
  persuasionNeedlePierce(
    'Persuasion Needle: Guard Pierce',
    3,
    requirements: <Skill>[persuasionNeedleMult],
  ),
  finalPrayer2(
    'Final Prayer: Effect ↑',
    3,
    requirements: <Skill>[finalPrayer],
  ),
  reimuPrivilegesPersistent(
    "Reimu's Protagonist Privileges: Persistent Conversion",
    4,
    requirements: <Skill>[youkaiBusterShield, reimuPrivileges2],
  ),
  reimuPrivilegesShare(
    "Reimu's Protagonist Privileges: Effect Share",
    3,
    requirements: <Skill>[reimuPrivileges2],
  ),
  flashExorcismBarrierTurn(
    'Flash Exorcism Barrier: Turn Conversion',
    5,
    requirements: <Skill>[greatHakureiBarrierRegen, flashExorcismBarrierDelay],
  ),
  persuasionNeedleHpDrain(
    'Persuasion Needle: HP Drain Augment',
    4,
    requirements: <Skill>[persuasionNeedleMult],
  ),
  dreamSealTurn(
    'Dream Seal: Turn Conversion',
    5,
    requirements: <Skill>[dreamSeal],
  ),
  dreamSealDamage(
    'Dream Seal: Damage ↑ Amplifier',
    3,
    requirements: <Skill>[dreamSeal],
  ),
  finalPrayerRange(
    'Final Prayer: Range ↑',
    3,
    requirements: <Skill>[finalPrayer],
  ),
  turnCounterPreservation(
    'Turn Counter Preservation',
    5,
    requirements: <Skill>[hakureiProtectionRange],
  ),
  flashExorcismBarrierPartyDamage(
    'Flash Exorcism Barrier: Party Damage Taken ↓ Augment',
    3,
    requirements: <Skill>[
      greatHakureiBarrierSelf,
      greatHakureiBarrierRegen,
      flashExorcismBarrierTurn,
    ],
  ),
  greatHakureiBarrierRegen2(
    'Great Hakurei Barrier: Regen ↑',
    3,
    requirements: <Skill>[flashExorcismBarrierTurn, persuasionNeedleHpDrain],
  ),
  turnCounterPreservation2(
    'Turn Counter Preservation+',
    5,
    requirements: <Skill>[turnCounterPreservation],
  ),
  flashExorcismBarrierPartyDamage2(
    'Flash Exorcism Barrier: Party Damage Taken ↓ Augment+',
    3,
    requirements: <Skill>[
      reimuPrivilegesShare,
      flashExorcismBarrierPartyDamage,
    ],
  ),
  reimuTruePrayer(
    "Reimu's True Prayer",
    6,
    requirements: <Skill>[dreamSealDamage, finalPrayerRange],
  ),
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  const UncategorizedUniqueSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <Skill>[],
  });
}
