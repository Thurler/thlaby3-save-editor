// ignore_for_file: avoid_print

import 'package:tfields/extensions.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
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
import 'package:thlaby3_save_editor/save/enums/skills/turn_count.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

void main() {
  Iterable<SkillReport> reimu = makeReports(Character.reimu);
  printReports(
    'Damage Report',
    reimu.where((SkillReport report) => report.dealsDamage).toList(),
    SkillReport.damageCompareTo,
    (SkillReport report) => report.toDamageReport(),
  );
  printReports(
    'Healing Report',
    reimu.where((SkillReport report) => report.providesHealing).toList(),
    SkillReport.healingCompareTo,
    (SkillReport report) => report.toHealingReport(),
  );
  printReports(
    'Buff Report',
    reimu.where((SkillReport report) => report.providesBuff).toList(),
    SkillReport.buffCompareTo,
    (SkillReport report) => report.toBuffReport(),
  );
  printReports(
    'Permanent Buff Report',
    reimu.where((SkillReport report) => report.providesPermanentBuff).toList(),
    SkillReport.permanentBuffCompareTo,
    (SkillReport report) => report.toPermanentBuffReport(),
  );
  printReports(
    'Ailment Report',
    reimu.where((SkillReport report) => report.inflictsAilment).toList(),
    SkillReport.ailmentCompareTo,
    (SkillReport report) => report.toAilmentReport(),
  );
  printReports(
    'Damage Increase Report',
    reimu.where((SkillReport report) => report.increasesDamage).toList(),
    SkillReport.damageIncreaseCompareTo,
    (SkillReport report) => report.toDamageIncreaseReport(),
  );
  printReports(
    'Damage Reduction Report',
    reimu.where((SkillReport report) => report.reducesDamage).toList(),
    SkillReport.damageReductionCompareTo,
    (SkillReport report) => report.toDamageReductionReport(),
  );
}

Iterable<SkillReport> makeReports(Character character) {
  Iterable<UniqueSkill> skills = character.flattenedUniqueSkills;
  Iterable<UniqueSkill> baseSkills =
      skills.where((UniqueSkill skill) => skill is! SkillAugment);
  Iterable<SkillAugment> augments = skills.whereType<SkillAugment>();
  Map<UniqueSkill, List<SkillReport>> reportsBySkill =
      <UniqueSkill, List<SkillReport>>{};
  Map<String, double> damageIncreases = <String, double>{};
  for (UniqueSkill skill in baseSkills) {
    reportsBySkill[skill] = <SkillReport>[SkillReport.fromSkill(skill)];
    if (skill is DamageDealtBuffer) {
      damageIncreases[skill.prettyName] =
          (skill as DamageDealtBuffer).dmgDealtBuff;
    }
  }
  for (SkillAugment skill in augments) {
    List<SkillReport>? currentReports = reportsBySkill[skill.baseSkill];
    List<SkillReport> augmentedReports;
    if (skill is TurnCountBasedAugment) {
      Set<int> turns = <int>{1};
      if (skill.turnCountCap != null) {
        int cap = skill.turnCountCap!;
        turns.addAll(<int>[cap ~/ 4, cap ~/ 2, cap * 3 ~/ 4, cap]);
      } else {
        turns.addAll(<int>[5, 10, 15, 20]);
      }
      augmentedReports = <SkillReport>[];
      for (int turnCount in turns) {
        augmentedReports.addAll(
          currentReports?.map(
            (SkillReport report) => report.augmentForTurns(skill, turnCount),
          ).nonNulls.toList() ?? <SkillReport>[],
        );
      }
    } else {
      augmentedReports = currentReports?.map(
        (SkillReport report) => report.augment(skill),
      ).nonNulls.toList() ?? <SkillReport>[];
    }
    currentReports?.addAll(augmentedReports);
    if (skill is DamageDealtBuffer) {
      damageIncreases[skill.description] =
          (skill as DamageDealtBuffer).dmgDealtBuff;
    }
  }
  for (List<SkillReport> reportList in reportsBySkill.values) {
    List<SkillReport> augmentedReports = <SkillReport>[];
    for (MapEntry<String, double> entry in damageIncreases.entries) {
      augmentedReports.addAll(
        reportList.map(
          (SkillReport report) =>
              report.augmentForDamageDealt(entry.value, entry.key),
        ).nonNulls,
      );
    }
    reportList.addAll(augmentedReports);
  }
  return reportsBySkill.values.expand((List<SkillReport> reports) => reports);
}

void printReports(
  String reportHeader,
  List<SkillReport> reports,
  int Function(SkillReport, SkillReport) sortFunction,
  String Function(SkillReport) reportToString,
) {
  print('=== $reportHeader ===');
  reports.sort(sortFunction);
  SkillReport? previous;
  for (SkillReport report in reports) {
    if (previous == null || sortFunction(report, previous) != 0) {
      print(reportToString(report));
      previous = report;
    }
  }
  print('');
}

class PercentDuration implements Comparable<PercentDuration> {
  double percent;
  int duration;

  PercentDuration({required this.duration, required this.percent});

  PercentDuration clone() =>
      PercentDuration(duration: duration, percent: percent);

  PercentDuration.zero() : duration = 0, percent = 0;

  @override
  String toString() =>
      percent > 0 ? '${percent.toStringAsFixed(1)}% ($duration)' : '--';

  @override
  int compareTo(PercentDuration other) {
    int percentCompare = percent.compareTo(other.percent);
    if (percentCompare != 0) {
      return percentCompare;
    }
    return duration.compareTo(other.duration);
  }
}

class AilmentData implements Comparable<AilmentData> {
  int duration;
  double chance;

  AilmentData({required this.duration, required this.chance});

  AilmentData clone() => AilmentData(duration: duration, chance: chance);

  AilmentData.zero() : duration = 0, chance = 0;

  @override
  String toString() =>
      chance > 0 ? '$duration (${chance.toStringAsFixed(1)}%)' : '--';

  @override
  int compareTo(AilmentData other) {
    int durationCompare = duration.compareTo(other.duration);
    if (durationCompare != 0) {
      return durationCompare;
    }
    return chance.compareTo(other.chance);
  }
}

enum ReportEffectRange {
  self,
  singleEnemy,
  rowEnemyDiminished,
  allEnemies,
  singleAlly,
  allAlliesDiminished,
  allAlliesMinusSelf,
  allAllies,
  backline,
  party;

  factory ReportEffectRange.fromKoEffectRange(KoEffectRange range) =>
      switch (range) {
    KoEffectRange.self => ReportEffectRange.self,
    KoEffectRange.frontline => ReportEffectRange.allAllies,
    KoEffectRange.frontlineMinusSelf => ReportEffectRange.allAlliesMinusSelf,
    KoEffectRange.backline => ReportEffectRange.backline,
  };

  factory ReportEffectRange.fromSpellTargetMode(SpellTargetMode mode) =>
      switch (mode) {
    SpellTargetMode.singleEnemy => ReportEffectRange.singleEnemy,
    SpellTargetMode.rowEnemyDiminished => ReportEffectRange.rowEnemyDiminished,
    SpellTargetMode.allEnemies => ReportEffectRange.allEnemies,
    SpellTargetMode.singleAlly => ReportEffectRange.singleAlly,
    SpellTargetMode.allAlliesDiminished =>
      ReportEffectRange.allAlliesDiminished,
    SpellTargetMode.allAllies => ReportEffectRange.allAllies,
  };

  factory ReportEffectRange.fromAugmentRange(AugmentRange range) =>
      switch (range) {
    AugmentRange.self => ReportEffectRange.self,
    AugmentRange.frontline => ReportEffectRange.allAllies,
    AugmentRange.frontlineMinusSelf => ReportEffectRange.allAlliesMinusSelf,
  };
}

class SkillReport {
  // Common data attributes
  UniqueSkill baseSkill;
  int mpCost;
  int delay;
  List<Element> elements;
  ReportEffectRange effectRange;
  int cooldown;
  int accModifier;
  int? turnCount;
  List<SkillAugment> baseAugments;
  List<SkillAugment> augments;
  List<String> requirements;

  // Damage attributes
  double multiplierAmplify;
  double multiplier;
  double defGuard;
  double mndGuard;
  double atkFactor;
  double magFactor;
  double defFactor;
  double mndFactor;
  double spdFactor;
  double hpPercentDamage;

  // Heal attributes
  double percentDrain;
  PercentDuration hpRegen;
  double percentHeal;

  // Buff attributes
  int atkBuff;
  int defBuff;
  int magBuff;
  int mndBuff;
  int spdBuff;
  int accBuff;
  int evaBuff;

  // Permanent Buff attributes
  int permAtkBuff;
  int permDefBuff;
  int permMagBuff;
  int permMndBuff;
  int permSpdBuff;
  int permAccBuff;
  int permEvaBuff;

  // Ailment attributes
  AilmentData psn;
  AilmentData par;
  AilmentData hvy;
  AilmentData sil;
  AilmentData trr;
  double shk;
  double dth;

  // Damage increase
  ReportEffectRange? customRangeDmgIncrease;
  PercentDuration damageIncreasedBuff;

  // Damage reduction
  ReportEffectRange? customRangeDmgReduction;
  PercentDuration damageReceivedBuff;

  SkillReport({
    required this.baseSkill,
    required this.mpCost,
    required this.delay,
    required this.elements,
    required this.effectRange,
    required this.cooldown,
    required this.accModifier,
    required this.baseAugments,
    required this.augments,
    required this.requirements,
    required this.multiplier,
    required this.defGuard,
    required this.mndGuard,
    required this.atkFactor,
    required this.magFactor,
    required this.defFactor,
    required this.mndFactor,
    required this.spdFactor,
    required this.hpPercentDamage,
    required this.percentDrain,
    required this.hpRegen,
    required this.percentHeal,
    required this.atkBuff,
    required this.defBuff,
    required this.magBuff,
    required this.mndBuff,
    required this.spdBuff,
    required this.accBuff,
    required this.evaBuff,
    required this.permAtkBuff,
    required this.permDefBuff,
    required this.permMagBuff,
    required this.permMndBuff,
    required this.permSpdBuff,
    required this.permAccBuff,
    required this.permEvaBuff,
    required this.psn,
    required this.par,
    required this.hvy,
    required this.sil,
    required this.trr,
    required this.shk,
    required this.dth,
    required this.damageIncreasedBuff,
    required this.damageReceivedBuff,
    required this.multiplierAmplify,
    this.customRangeDmgIncrease,
    this.customRangeDmgReduction,
    this.turnCount,
  });

  SkillReport.fromSkill(UniqueSkill skill) :
    baseSkill = skill,
    multiplierAmplify = skill is DamageDealtAmplifyAugment
      ? (skill as DamageDealtAmplifyAugment).dmgDealtAmplification
      : 1,
    mpCost = skill is SpellSkill ? skill.mpCost : 0,
    delay = skill is SpellSkill ? skill.delay : -1,
    elements = skill is SpellSkill ? skill.elements : const <Element>[],
    effectRange = switch (skill) {
      SpellSkill() => ReportEffectRange.fromSpellTargetMode(skill.targetMode),
      KoReactioner() => ReportEffectRange.fromKoEffectRange(
          (skill as KoReactioner).effectRange,
        ),
      _ => ReportEffectRange.self,
    },
    cooldown = skill is CooldownSpell ? skill.cooldown : 0,
    accModifier = skill is DamageSpell ? skill.accModifier : 0,
    baseAugments = <SkillAugment>[],
    augments = <SkillAugment>[],
    requirements = <String>[
      if (skill is ConditionedEffect)
        ...(skill as ConditionedEffect).effectRequirements.map(
          (EffectRequirement req) => req.toString(),
        ),
      if (skill is ElementProtectionReactioner)
        '${skill.baseSkill.prettyName} procced',
      if (skill is RaceSlayReactioner) '${skill.baseSkill.prettyName} procced',
      if (skill is FocusReactioner) 'Focus used',
      if (skill is ConditionedFocusReactioner)
        ...(skill as ConditionedFocusReactioner).reactionRequirements.map(
          (EffectRequirement req) => req.toString(),
        ),
      if (skill is KoReactionerSkill) skill.koReactionTriggerString,
      if (skill is ConditionedKoReactioner)
        ...(skill as ConditionedKoReactioner).reactionRequirements.map(
          (EffectRequirement req) => req.toString(),
        ),
      if (skill is ConditionedSpellSkill)
        ...skill.castRequirements.map(
          (EffectRequirement req) => req.toString(),
        ),
    ],
    turnCount = null,
    multiplier = skill is DamageSpell ? skill.multiplier : 0,
    defGuard = skill is DamageSpell ? skill.defGuard : 0,
    mndGuard = skill is DamageSpell ? skill.mndGuard : 0,
    atkFactor = skill is DirectSpell ? skill.atkFactor : 0,
    magFactor = skill is MagicSpell ? skill.magFactor : 0,
    defFactor = skill is OtherFactorSpell ? skill.defFactor : 0,
    mndFactor = skill is OtherFactorSpell ? skill.mndFactor : 0,
    spdFactor = skill is OtherFactorSpell ? skill.spdFactor : 0,
    hpPercentDamage = skill is HpPercentDamageSpell ? skill.hpPercentDamage : 0,
    percentDrain = skill is HpDrainSpell ? skill.hpDrainPercent : 0,
    hpRegen = skill is HpRegenBuffer
      ? PercentDuration(
          percent: (skill as HpRegenBuffer).hpRegen,
          duration: (skill as HpRegenBuffer).hpRegenDuration,
        )
      : PercentDuration.zero(),
    percentHeal =
        skill is PercentHealer ? (skill as PercentHealer).healPercent : 0,
    atkBuff = skill is AttackBuffer ? (skill as AttackBuffer).atkBuff : 0,
    defBuff = skill is DefenseBuffer ? (skill as DefenseBuffer).defBuff : 0,
    magBuff = skill is MagicBuffer ? (skill as MagicBuffer).magBuff : 0,
    mndBuff = skill is MindBuffer ? (skill as MindBuffer).mndBuff : 0,
    spdBuff = skill is SpeedBuffer ? (skill as SpeedBuffer).spdBuff : 0,
    accBuff = skill is AccuracyBuffer ? (skill as AccuracyBuffer).accBuff : 0,
    evaBuff = skill is EvasionBuffer ? (skill as EvasionBuffer).evaBuff : 0,
    permAtkBuff = skill is PermanentAttackBuffer
      ? (skill as PermanentAttackBuffer).permAtkBuff
      : 0,
    permDefBuff = skill is PermanentDefenseBuffer
      ? (skill as PermanentDefenseBuffer).permDefBuff
      : 0,
    permMagBuff = skill is PermanentMagicBuffer
      ? (skill as PermanentMagicBuffer).permMagBuff
      : 0,
    permMndBuff = skill is PermanentMindBuffer
      ? (skill as PermanentMindBuffer).permMndBuff
      : 0,
    permSpdBuff = skill is PermanentSpeedBuffer
      ? (skill as PermanentSpeedBuffer).permSpdBuff
      : 0,
    permAccBuff = skill is PermanentAccuracyBuffer
      ? (skill as PermanentAccuracyBuffer).permAccBuff
      : 0,
    permEvaBuff = skill is PermanentEvasionBuffer
      ? (skill as PermanentEvasionBuffer).permEvaBuff
      : 0,
    psn = AilmentData.zero(),
    par = skill is ParalysisInflictor
      ? AilmentData(
          duration: (skill as ParalysisInflictor).parDuration,
          chance: (skill as ParalysisInflictor).parChance,
        )
      : AilmentData.zero(),
    hvy = AilmentData.zero(),
    sil = skill is SilenceInflictor
      ? AilmentData(
          duration: (skill as SilenceInflictor).silDuration,
          chance: (skill as SilenceInflictor).silChance,
        )
      : AilmentData.zero(),
    trr = AilmentData.zero(),
    shk = 0,
    dth = 0,
    damageIncreasedBuff = skill is DamageDealtBuffer
      ? PercentDuration(
          percent: (skill as DamageDealtBuffer).dmgDealtBuff,
          duration: (skill as DamageDealtBuffer).dmgDealtBuffDuration,
        )
      : PercentDuration.zero(),
    damageReceivedBuff = skill is DamageReceivedBuffer
      ? PercentDuration(
          percent: (skill as DamageReceivedBuffer).dmgReceivedBuff,
          duration: (skill as DamageReceivedBuffer).dmgReceivedBuffDuration,
        )
      : PercentDuration.zero();

  SkillReport clone() => SkillReport(
    baseSkill: baseSkill,
    multiplierAmplify: multiplierAmplify,
    mpCost: mpCost,
    delay: delay,
    elements: elements,
    effectRange: effectRange,
    customRangeDmgIncrease: customRangeDmgIncrease,
    customRangeDmgReduction: customRangeDmgReduction,
    cooldown: cooldown,
    accModifier: accModifier,
    multiplier: multiplier,
    defGuard: defGuard,
    mndGuard: mndGuard,
    atkFactor: atkFactor,
    magFactor: magFactor,
    defFactor: defFactor,
    mndFactor: mndFactor,
    spdFactor: spdFactor,
    hpPercentDamage: hpPercentDamage,
    percentDrain: percentDrain,
    hpRegen: hpRegen.clone(),
    percentHeal: percentHeal,
    atkBuff: atkBuff,
    defBuff: defBuff,
    magBuff: magBuff,
    mndBuff: mndBuff,
    spdBuff: spdBuff,
    accBuff: accBuff,
    evaBuff: evaBuff,
    permAtkBuff: permAtkBuff,
    permDefBuff: permDefBuff,
    permMagBuff: permMagBuff,
    permMndBuff: permMndBuff,
    permSpdBuff: permSpdBuff,
    permAccBuff: permAccBuff,
    permEvaBuff: permEvaBuff,
    psn: psn.clone(),
    par: par.clone(),
    hvy: hvy.clone(),
    sil: sil.clone(),
    trr: trr.clone(),
    shk: shk,
    dth: dth,
    damageIncreasedBuff: damageIncreasedBuff.clone(),
    damageReceivedBuff: damageReceivedBuff.clone(),
    baseAugments: baseAugments.toList(),
    augments: augments.toList(),
    requirements: requirements.toList(),
    turnCount: turnCount,
  );

  SkillReport? _validateAugment(SkillAugment augment) {
    SkillReport newReport = clone();
    if (
      augment is SkillAugmentChainSkill &&
      augments.contains(augment.baseAugment)
    ) {
      return null;
    }
    if (augment is SkillAugmentSkill) {
      newReport.baseAugments.add(augment);
      List<SkillAugmentSkill> requiredAugments =
          augment.requiredAugments.toList();
      if (augment is SkillAugmentChainSkill) {
        newReport.baseAugments.add(augment.baseAugment);
        requiredAugments.remove(augment.baseAugment);
      }
      if (
        requiredAugments.isNotEmpty &&
        requiredAugments.any(
          (SkillAugment required) => !newReport.baseAugments.contains(required),
        )
      ) {
        return null;
      }
    }
    return newReport;
  }

  bool applyAugment(SkillAugment augment) {
    bool didAugment = false;
    if (augment is DelayAugment) {
      didAugment = true;
      delay += augment.delay;
    }
    if (augment is CooldownAugment) {
      didAugment = true;
      cooldown += augment.cooldown;
    }
    if (augment is DamageDealtAmplifyAugment) {
      didAugment = true;
      multiplierAmplify = augment.dmgDealtAmplification;
    }
    if (augment is MultiplierAugment) {
      didAugment = true;
      multiplier += augment.multiplier;
    }
    if (augment is GuardAugment) {
      didAugment = true;
      defGuard += augment.defGuard;
      mndGuard += augment.mndGuard;
    }
    if (augment is PowAugment) {
      didAugment = true;
      if (atkFactor > 0) {
        atkFactor += augment.pow;
      }
      if (magFactor > 0) {
        magFactor += augment.pow;
      }
      if (defFactor > 0) {
        defFactor += augment.pow;
      }
      if (mndFactor > 0) {
        mndFactor += augment.pow;
      }
      if (spdFactor > 0) {
        spdFactor += augment.pow;
      }
    }
    if (augment is HpDrainAugment) {
      didAugment = true;
      percentDrain += augment.hpDrainPercent;
    }
    if (augment is HpRegenBuffAugment) {
      didAugment = true;
      hpRegen.percent += augment.hpRegen;
      hpRegen.duration += augment.hpRegenDuration;
    }
    if (augment is PercentHealAugment) {
      didAugment = true;
      percentHeal += augment.healPercent;
    }
    if (augment is AttackBuffAugment) {
      didAugment = true;
      atkBuff += augment.atkBuff;
    }
    if (augment is DefenseBuffAugment) {
      didAugment = true;
      defBuff += augment.defBuff;
    }
    if (augment is MagicBuffAugment) {
      didAugment = true;
      magBuff += augment.magBuff;
    }
    if (augment is MindBuffAugment) {
      didAugment = true;
      mndBuff += augment.mndBuff;
    }
    if (augment is SpeedBuffAugment) {
      didAugment = true;
      spdBuff += augment.spdBuff;
    }
    if (augment is AccuracyBuffAugment) {
      didAugment = true;
      accBuff += augment.accBuff;
    }
    if (augment is EvasionBuffAugment) {
      didAugment = true;
      evaBuff += augment.evaBuff;
    }
    if (augment is PermanentAttackBuffAugment) {
      didAugment = true;
      permAtkBuff += augment.permAtkBuff;
    }
    if (augment is PermanentDefenseBuffAugment) {
      didAugment = true;
      permDefBuff += augment.permDefBuff;
    }
    if (augment is PermanentMagicBuffAugment) {
      didAugment = true;
      permMagBuff += augment.permMagBuff;
    }
    if (augment is PermanentMindBuffAugment) {
      didAugment = true;
      permMndBuff += augment.permMndBuff;
    }
    if (augment is PermanentSpeedBuffAugment) {
      didAugment = true;
      permSpdBuff += augment.permSpdBuff;
    }
    if (augment is PermanentAccuracyBuffAugment) {
      didAugment = true;
      permAccBuff += augment.permAccBuff;
    }
    if (augment is PermanentEvasionBuffAugment) {
      didAugment = true;
      permEvaBuff += augment.permEvaBuff;
    }
    if (augment is ParalysisAugment) {
      didAugment = true;
      par.duration += augment.parDuration;
      par.chance += augment.parChance;
    }
    if (augment is DamageDealtBuffAugment) {
      didAugment = true;
      damageIncreasedBuff.percent += augment.dmgDealtBuff;
      damageIncreasedBuff.duration += augment.dmgDealtBuffDuration;
    }
    if (augment is DamageReceivedBuffAugment) {
      didAugment = true;
      damageReceivedBuff.percent += augment.dmgReceivedBuff;
      damageReceivedBuff.duration += augment.dmgReceivedBuffDuration;
    }
    return didAugment;
  }

  bool applyAugmentForTurns(SkillAugment augment, int turnCount) {
    bool didAugment = false;
    if (augment is MultiplierMultiplyPerTurnAugment) {
      didAugment = true;
      multiplier *= augment.multiplierForTurns(turnCount);
    }
    if (augment is DefenseBuffPerTurnAugment) {
      didAugment = true;
      defBuff += augment.defBuffForTurns(turnCount);
    }
    if (augment is MindBuffPerTurnAugment) {
      didAugment = true;
      mndBuff += augment.mndBuffForTurns(turnCount);
    }
    return didAugment;
  }

  SkillReport? augment(SkillAugment augment) {
    SkillReport? newReport = _validateAugment(augment);
    if (newReport == null) {
      return null;
    }
    bool didAugment = newReport.applyAugment(augment);
    if (didAugment) {
      newReport.augments.add(augment);
      if (augment is ConditionedEffect) {
        newReport.requirements.addAll(
          (augment as ConditionedEffect).effectRequirements.map(
            (EffectRequirement req) => req.toString(),
          ),
        );
      }
      if (augment is CustomAugmentRange) {
        ReportEffectRange newRange =
            ReportEffectRange.fromAugmentRange(augment.augmentRange);
        if (augment is DamageDealtBuffAugment) {
          newReport.customRangeDmgIncrease = newRange;
        }
        if (augment is DamageReceivedBuffAugment) {
          newReport.customRangeDmgReduction = newRange;
        }
      }
    }
    return didAugment ? newReport : null;
  }

  SkillReport? augmentForTurns(SkillAugment augment, int turnCount) {
    SkillReport? newReport = _validateAugment(augment);
    if (newReport == null) {
      return null;
    }
    newReport.turnCount = turnCount;
    bool didAugment = newReport.applyAugmentForTurns(augment, turnCount);
    if (didAugment) {
      newReport.augments.add(augment);
      if (augment is TurnCountResetAugment) {
        newReport.requirements.add('Resets turn counter');
      }
    }
    return didAugment ? newReport : null;
  }

  SkillReport? augmentForDamageDealt(double multiplier, String requirement) {
    if (power <= 0) {
      return null;
    }
    SkillReport newReport = clone();
    newReport.multiplier *= 1 + ((multiplier / 100) * multiplierAmplify);
    newReport.requirements.add(requirement);
    return newReport;
  }

  double get _offense =>
      atkFactor + magFactor + defFactor + mndFactor + spdFactor;

  double get _defense => defGuard + mndGuard;

  double get power => (_offense / 100) * (multiplier / 100);

  double get pierce => _defense > 0 ? _offense / _defense : double.infinity;

  bool get dealsDamage => _offense > 0;

  bool get providesHealing =>
      _offense < 0 ||
      percentDrain > 0 ||
      hpRegen.percent > 0 ||
      percentHeal > 0;

  bool get providesBuff =>
      atkBuff > 0 ||
      defBuff > 0 ||
      magBuff > 0 ||
      mndBuff > 0 ||
      spdBuff > 0 ||
      accBuff > 0 ||
      evaBuff > 0;

  bool get providesPermanentBuff =>
      permAtkBuff > 0 ||
      permDefBuff > 0 ||
      permMagBuff > 0 ||
      permMndBuff > 0 ||
      permSpdBuff > 0 ||
      permAccBuff > 0 ||
      permEvaBuff > 0;

  bool get inflictsAilment =>
      shk > 0 ||
      dth > 0 ||
      psn.chance > 0 ||
      par.chance > 0 ||
      hvy.chance > 0 ||
      sil.chance > 0 ||
      trr.chance > 0;

  bool get increasesDamage => damageIncreasedBuff.percent > 0;

  bool get reducesDamage => damageReceivedBuff.percent > 0;

  String _elementsToString() => elements.isEmpty
    ? '---'
    : elements.map((Element el) => el.name.toUpperCase()).join('/');

  String _percentToString(double percent) =>
      percent > 0 ? '${percent.toStringAsFixed(1)}%' : '--';

  String _augmentsToString() => augments.isEmpty
    ? ''
    : '\n    - ${augments.map((SkillAugment a) => a.description).join(', ')}';

  String _requirementsToString() =>
      requirements.isEmpty ? '' : '\n    - ${requirements.join(', ')}';

  String _commonReport(ReportEffectRange? rangeOverride) =>
      'Dly: $delay | Acc: $accModifier | Cd: $cooldown | '
      'MP: $mpCost | T: ${turnCount?.toString().padLeft(2, '0') ?? '--'} | '
      '${_elementsToString()} | '
      '${(rangeOverride ?? effectRange).name.upperCaseFirstChar()} | '
      '${baseSkill.prettyName}';
  //'${baseSkill.prettyName}'
  //'${_augmentsToString()}'
  //'${_requirementsToString()}';

  String toDamageReport() => 'Pow: ${power.toStringAsFixed(2)} | '
      'Prc: ${pierce.toStringAsFixed(2)} | '
      '${_commonReport(null)}';

  String toHealingReport() =>
      'Pow: ${power < 0 ? (-power).toStringAsFixed(2) : '--'} | '
      'Fix: ${_percentToString(percentHeal)} | '
      'Rgn: $hpRegen | '
      'Drn: ${_percentToString(percentDrain)} | '
      '${_commonReport(null)}';

  String toBuffReport() => 'ATK: ${atkBuff > 0 ? atkBuff : '--'} | '
      'DEF: ${defBuff > 0 ? defBuff : '--'} | '
      'MAG: ${magBuff > 0 ? magBuff : '--'} | '
      'MND: ${mndBuff > 0 ? mndBuff : '--'} | '
      'SPD: ${spdBuff > 0 ? spdBuff : '--'} | '
      'ACC: ${accBuff > 0 ? accBuff : '--'} | '
      'EVA: ${evaBuff > 0 ? evaBuff : '--'} | '
      '${_commonReport(null)}';

  String toPermanentBuffReport() =>
      'ATK: ${permAtkBuff > 0 ? permAtkBuff : '--'} | '
      'DEF: ${permDefBuff > 0 ? permDefBuff : '--'} | '
      'MAG: ${permMagBuff > 0 ? permMagBuff : '--'} | '
      'MND: ${permMndBuff > 0 ? permMndBuff : '--'} | '
      'SPD: ${permSpdBuff > 0 ? permSpdBuff : '--'} | '
      'ACC: ${permAccBuff > 0 ? permAccBuff : '--'} | '
      'EVA: ${permEvaBuff > 0 ? permEvaBuff : '--'} | '
      '${_commonReport(null)}';

  String toAilmentReport() => 'PSN: $psn | PAR: $par | HVY: $hvy | SIL: $sil | '
      'TRR: $trr | SHK: ${shk > 0 ? shk : '--'} | '
      'DTH: ${dth > 0 ? dth : '--'} | '
      '${_commonReport(null)}';

  String toDamageIncreaseReport() => 'Dmg Increase: $damageIncreasedBuff | '
      '${_commonReport(customRangeDmgIncrease)}';

  String toDamageReductionReport() => 'Dmg Reduction: $damageReceivedBuff | '
      '${_commonReport(customRangeDmgReduction)}';

  static int _commonCompareTo(SkillReport foo, SkillReport bar) {
    int nameCompare =
        foo.baseSkill.prettyName.compareTo(bar.baseSkill.prettyName);
    if (nameCompare != 0) {
      return nameCompare;
    }
    int delayCompare = foo.delay.compareTo(bar.delay);
    if (delayCompare != 0) {
      return -delayCompare;
    }
    int accCompare = foo.accModifier.compareTo(bar.accModifier);
    if (accCompare != 0) {
      return -accCompare;
    }
    int cooldownCompare = foo.cooldown.compareTo(bar.cooldown);
    if (cooldownCompare != 0) {
      return cooldownCompare;
    }
    int mpCompare = foo.mpCost.compareTo(bar.mpCost);
    if (mpCompare != 0) {
      return mpCompare;
    }
    int turnCompare = (foo.turnCount ?? 0).compareTo(bar.turnCount ?? 0);
    return -turnCompare;
  }

  static int damageCompareTo(SkillReport foo, SkillReport bar) {
    int powerCompare = foo.power.compareTo(bar.power);
    if (powerCompare != 0) {
      return -powerCompare;
    }
    int pierceCompare = foo.pierce.compareTo(bar.pierce);
    if (pierceCompare != 0) {
      return -pierceCompare;
    }
    return _commonCompareTo(foo, bar);
  }

  static int healingCompareTo(SkillReport foo, SkillReport bar) {
    int powerCompare = (-foo.power).compareTo(-bar.power);
    if (powerCompare != 0) {
      return -powerCompare;
    }
    int healCompare = foo.percentHeal.compareTo(bar.percentHeal);
    if (healCompare != 0) {
      return -healCompare;
    }
    int regenCompare = foo.hpRegen.compareTo(bar.hpRegen);
    if (regenCompare != 0) {
      return -regenCompare;
    }
    int drainCompare = foo.percentDrain.compareTo(bar.percentDrain);
    if (drainCompare != 0) {
      return -drainCompare;
    }
    return _commonCompareTo(foo, bar);
  }

  static int buffCompareTo(SkillReport foo, SkillReport bar) {
    int atkCompare = foo.atkBuff.compareTo(bar.atkBuff);
    if (atkCompare != 0) {
      return -atkCompare;
    }
    int defCompare = foo.defBuff.compareTo(bar.defBuff);
    if (defCompare != 0) {
      return -defCompare;
    }
    int magCompare = foo.magBuff.compareTo(bar.magBuff);
    if (magCompare != 0) {
      return -magCompare;
    }
    int mndCompare = foo.mndBuff.compareTo(bar.mndBuff);
    if (mndCompare != 0) {
      return -mndCompare;
    }
    int spdCompare = foo.spdBuff.compareTo(bar.spdBuff);
    if (spdCompare != 0) {
      return -spdCompare;
    }
    int accCompare = foo.accBuff.compareTo(bar.accBuff);
    if (accCompare != 0) {
      return -accCompare;
    }
    int evaCompare = foo.evaBuff.compareTo(bar.evaBuff);
    if (evaCompare != 0) {
      return -evaCompare;
    }
    return _commonCompareTo(foo, bar);
  }

  static int permanentBuffCompareTo(SkillReport foo, SkillReport bar) {
    int atkCompare = foo.permAtkBuff.compareTo(bar.permAtkBuff);
    if (atkCompare != 0) {
      return -atkCompare;
    }
    int defCompare = foo.permDefBuff.compareTo(bar.permDefBuff);
    if (defCompare != 0) {
      return -defCompare;
    }
    int magCompare = foo.permMagBuff.compareTo(bar.permMagBuff);
    if (magCompare != 0) {
      return -magCompare;
    }
    int mndCompare = foo.permMndBuff.compareTo(bar.permMndBuff);
    if (mndCompare != 0) {
      return -mndCompare;
    }
    int spdCompare = foo.permSpdBuff.compareTo(bar.permSpdBuff);
    if (spdCompare != 0) {
      return -spdCompare;
    }
    int accCompare = foo.permAccBuff.compareTo(bar.permAccBuff);
    if (accCompare != 0) {
      return -accCompare;
    }
    int evaCompare = foo.permEvaBuff.compareTo(bar.permEvaBuff);
    if (evaCompare != 0) {
      return -evaCompare;
    }
    return _commonCompareTo(foo, bar);
  }

  static int ailmentCompareTo(SkillReport foo, SkillReport bar) {
    int psnCompare = foo.psn.compareTo(bar.psn);
    if (psnCompare != 0) {
      return -psnCompare;
    }
    int parCompare = foo.par.compareTo(bar.par);
    if (parCompare != 0) {
      return -parCompare;
    }
    int hvyCompare = foo.hvy.compareTo(bar.hvy);
    if (hvyCompare != 0) {
      return -hvyCompare;
    }
    int silCompare = foo.sil.compareTo(bar.sil);
    if (silCompare != 0) {
      return -silCompare;
    }
    int trrCompare = foo.trr.compareTo(bar.trr);
    if (trrCompare != 0) {
      return -trrCompare;
    }
    int shkCompare = foo.shk.compareTo(bar.shk);
    if (shkCompare != 0) {
      return -shkCompare;
    }
    int dthCompare = foo.dth.compareTo(bar.dth);
    if (dthCompare != 0) {
      return -dthCompare;
    }
    return _commonCompareTo(foo, bar);
  }

  static int damageIncreaseCompareTo(SkillReport foo, SkillReport bar) {
    return -foo.damageIncreasedBuff.compareTo(bar.damageIncreasedBuff);
  }

  static int damageReductionCompareTo(SkillReport foo, SkillReport bar) {
    return -foo.damageReceivedBuff.compareTo(bar.damageReceivedBuff);
  }
}
