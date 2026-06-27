import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/renko.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

// TODO(me): Determine how the following interactions resolve so they are
// properly mapped with their behavior
//
// - (Generic) Does Quick Charge proc instead of Quick Charge+ if the user only
//             has 2 TP?
// - (Generic) Do the element-based protections stack for multiple elements?
//             E.g. Does FIR and CLD protection both proc for a FIR+CLD attack
// - (Generic) Do the race-based damage amplifiers stack for multiple races?
//             E.g. Does Youkai and Other bonus both proc for a dual race enemy
// - (Renko) Does Eager Support roll the cleanses separately?
// - (Renko) Do the element damage enhancements stack with themselves?
// - (Renko) Do the direct/magic enhancements stack with each other?
// - (Renko) Is Assault Beacon Turn Conversion max capped at 48% buff, 24+48=72%
//           or 24+4+48=76%?

/// A mixin to unify all character unique skills, be they spells, passives or
/// augments
mixin UniqueSkill implements Skill {
  static const List<UniqueSkill> values = <UniqueSkill>[
    ...UncategorizedUniqueSkill.values,
    ...PassiveSkill.values,
    ...SkillAugmentSkill.values,
    ...SpellSkill.values,
    ...SpellAugmentSkill.values,
    // Generic unique skills
    focusedRecitation,
    quickCharge,
    // Reimu unique skills
    armoredYinYangOrb,
    armoredYinYangOrbBoost,
    youkaiBuster,
    youkaiBusterShield,
    reimuPrivileges,
    reimuPrivilegesShare,
    finalPrayer,
    finalPrayerRange,
    trueFinalPrayer,
    // Renko unique skills
    readingStars,
    knowledgeStrangeStrings,
    knowledgeStrangeStringsShield,
    maryShield,
    abilityReadStars,
    abilityReadMoon,
    firCldDamage,
    wndNtrDamage,
    mysSpiDamage,
    drkPhyDamage,
    directDamage,
    magicDamage,
  ];

  @override
  List<UniqueSkill> get requirements;

  List<UniqueSkill> get allRequirements {
    List<UniqueSkill> result = requirements.toList();
    for (UniqueSkill requirement in requirements) {
      result.addAll(requirement.allRequirements);
    }
    return result;
  }
}

/// Enumeration of passive skills that don't have effects that are relevant to
/// the other classes
enum PassiveSkill with UniqueSkill {
  // Reimu passives
  hakureiProtection("Hakurei's Divine Protection", 3),
  hakureiProtection2(
    "Hakurei's Divine Protection: Effect ↑",
    2,
    requirements: <UniqueSkill>[hakureiProtection],
  ),
  hakureiProtection3(
    "Hakurei's Divine Protection: Effect ↑+",
    2,
    requirements: <UniqueSkill>[hakureiProtection2],
  ),
  hakureiProtectionRange(
    "Hakurei's Divine Protection: Range ↑",
    2,
    requirements: <UniqueSkill>[hakureiProtection3],
  ),
  turnCounterPreservation(
    'Turn Counter Preservation',
    5,
    requirements: <UniqueSkill>[hakureiProtectionRange],
  ),
  turnCounterPreservation2(
    'Turn Counter Preservation+',
    5,
    requirements: <UniqueSkill>[turnCounterPreservation],
  ),
  // Renko passives
  beaconSpecialist('Beacon Specialist', 3),
  learningListExpansion1('Learning List Expansion #1', 4),
  firstAidEmergencySmoke(
    'First Aid: Emergency Smoke Treatment',
    3,
    requirements: <UniqueSkill>[firstAidTraining],
  ),
  learningListExpansion2(
    'Learning List Expansion #2',
    5,
    requirements: <UniqueSkill>[learningListExpansion1],
  ),
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<UniqueSkill> requirements;

  const PassiveSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <UniqueSkill>[],
  });
}

enum UncategorizedUniqueSkill with UniqueSkill {
  // Renko skills
  celestialStasis(
    'Celestial Stasis',
    3,
    requirements: <UniqueSkill>[abilityReadStars, abilityReadMoon],
  ),
  ailmentAttackBoost(
    'Ailment Attack Boost',
    5,
    requirements: <UniqueSkill>[firCldDamage2, directDamage, wndNtrDamage2],
  ),
  buffDebuffBoost(
    'Buff & Debuff Boost',
    5,
    requirements: <UniqueSkill>[mysSpiDamage2, magicDamage, drkPhyDamage2],
  ),
  assaultBeacon2(
    'Assault Beacon: Effect ↑',
    3,
    requirements: <UniqueSkill>[assaultBeaconTurnGauge],
  ),
  assaultBeaconHpLoss(
    'Assault Beacon: HP Loss ↓',
    3,
    requirements: <UniqueSkill>[assaultBeaconTurnConversion],
  ),
  celestialStasisTurnGauge(
    'Celestial Stasis: Turn Gauge Loss ↓',
    3,
    requirements: <UniqueSkill>[eagerSupportDevotedHeart, celestialStasis],
  ),
  celestialStasisTurnConversion(
    'Celestial Stasis: Turn Conversion',
    3,
    requirements: <UniqueSkill>[celestialStasis, skillfulTreatment],
  ),
  learningListExpansion3(
    'Learning List Expansion #3',
    6,
    requirements: <UniqueSkill>[PassiveSkill.learningListExpansion2],
  ),
  directAttackDamage2(
    'Direct Attack Damage ↑+',
    5,
    requirements: <UniqueSkill>[
      firCldDamage2,
      ailmentAttackBoost,
      buffDebuffBoost,
    ],
  ),
  learningCooldown(
    'Learning Cooldown ↓',
    5,
    requirements: <UniqueSkill>[ailmentAttackBoost, mysSpiDamage2],
  ),
  learningMpCost(
    'Learning MP Cost ↓',
    5,
    requirements: <UniqueSkill>[wndNtrDamage2, buffDebuffBoost],
  ),
  magicAttackDamage2(
    'Magic Attack Damage ↑+',
    5,
    requirements: <UniqueSkill>[
      ailmentAttackBoost,
      buffDebuffBoost,
      drkPhyDamage2,
    ],
  ),
  // Maribel skills
  hazyBarrierDefense('Hazy Barrier Defense', 3),
  hazyBarrierAttack('Hazy Barrier Attack', 3),
  relativePsychology('Relative Psychology Knowledge', 3),
  noviceBarrier(
    'Novice Handmade Barrier',
    3,
    requirements: <UniqueSkill>[hazyBarrierDefense],
  ),
  disorderlyBarrier(
    'Disorderly Duplex Barrier',
    3,
    requirements: <UniqueSkill>[hazyBarrierAttack],
  ),
  hazyBarrierAttackLucidification(
    'Hazy Barrier Attack: Barrier Lucidification',
    3,
    requirements: <UniqueSkill>[hazyBarrierAttack],
  ),
  boundaryManipulation(
    'Boundary Manipulation',
    3,
    requirements: <UniqueSkill>[relativePsychology],
  ),
  noviceBarrierRecovery(
    'Novice Handmade Barrier: Recovery Augment',
    3,
    requirements: <UniqueSkill>[noviceBarrier],
  ),
  noviceBarrier2(
    'Novice Handmade Barrier: Boost ↑',
    3,
    requirements: <UniqueSkill>[noviceBarrier],
  ),
  disorderlyBarrierThirdLayer(
    'Disorderly Duplex Barrier: Third Layer',
    3,
    requirements: <UniqueSkill>[disorderlyBarrier],
  ),
  boundaryAnchoring(
    'Boundary Anchoring',
    3,
    requirements: <UniqueSkill>[boundaryManipulation],
  ),
  abilitySeeBarriers(
    'Ability to See Barriers',
    3,
    requirements: <UniqueSkill>[relativePsychology],
  ),
  relativePsychologySecrets(
    'Relative Psychology Secrets',
    3,
    requirements: <UniqueSkill>[relativePsychology],
  ),
  abilityUnbridled('Ability Unbridled', 3),
  // Copies from focus_reaction.dart
  //quickCharge('Quick Charge', 3),
  renkosEyes("Renko's Eyes", 3),
  noviceBarrierRecovery2(
    'Novice Handmade Barrier: Recovery ↑',
    3,
    requirements: <UniqueSkill>[noviceBarrierRecovery],
  ),
  noviceBarrier3(
    'Novice Handmade Barrier: Boost ↑+',
    3,
    requirements: <UniqueSkill>[noviceBarrier2],
  ),
  hazyBarrierAttackSpi(
    'Hazy Barrier Attack: SPI Augment',
    4,
    requirements: <UniqueSkill>[
      disorderlyBarrierThirdLayer,
      hazyBarrierAttackLucidification,
    ],
  ),
  overflowingAnomalousPower(
    'Overflowing Anomalous Power',
    3,
    requirements: <UniqueSkill>[abilitySeeBarriers],
  ),
  abilityFiddleBarriers(
    'Ability to Fiddle with Barriers',
    3,
    requirements: <UniqueSkill>[abilitySeeBarriers],
  ),
  abilityUnbridledGuardPierce(
    'Ability Unbridled: Guard Pierce',
    3,
    requirements: <UniqueSkill>[abilityUnbridled],
  ),
  chaosBarrier(
    'Chaos Barrier',
    3,
    requirements: <UniqueSkill>[noviceBarrier3, disorderlyBarrierThirdLayer],
  ),
  disorderlyBarrierFourthLayer(
    'Disorderly Duplex Barrier: Fourth Layer',
    3,
    requirements: <UniqueSkill>[disorderlyBarrierThirdLayer],
  ),
  hazyBuffAbsorption(
    'Hazy Buff Absorption',
    5,
    requirements: <UniqueSkill>[
      hazyBarrierAttackSpi,
      overflowingAnomalousPower,
    ],
  ),
  abilityUnderstandBoundaries(
    'Ability to Understand Boundaries',
    3,
    requirements: <UniqueSkill>[abilityFiddleBarriers],
  ),
  relativePsychologyMastery(
    'Relative Psychology Mastery',
    5,
    requirements: <UniqueSkill>[relativePsychologySecrets],
  ),
  abilityUnbridledPowerControl(
    'Ability Unbridled: Power Control',
    3,
    requirements: <UniqueSkill>[abilityUnbridled],
  ),
  // Copies from focus_reaction.dart
  //focusedRecitation(
  //  'Focused Recitation',
  //  3,
  //  requirements: <UniqueSkill>[quickCharge],
  //),
  chaosBarrierBoundary(
    'Chaos Barrier: Boundary Between Chaos and Order',
    4,
    requirements: <UniqueSkill>[chaosBarrier],
  ),
  hazyMoonBarrier(
    'Hazy Moon Barrier',
    3,
    requirements: <UniqueSkill>[hazyBarrierAttackSpi],
  ),
  overflowingAnomalousPowerAnomaly(
    'Overflowing Anomalous Power: Menacing Anomaly',
    3,
    requirements: <UniqueSkill>[overflowingAnomalousPower],
  ),
  abilityUnbridledGuardPierce2(
    'Ability Unbridled: Guard Pierce+',
    3,
    requirements: <UniqueSkill>[abilityUnbridledGuardPierce],
  ),
  // Copies from focus_reaction.dart
  //quickCharge2('Quick Charge+', 2, requirements: <UniqueSkill>[quickCharge]),
  noviceBarrierKnowledge(
    "Novice Handmade Barrier: Dr. Latency's Knowledge",
    5,
    requirements: <UniqueSkill>[noviceBarrierRecovery2, noviceBarrier3],
  ),
  chaosBarrierDoubleBoost(
    'Chaos Barrier: Double Boost',
    4,
    requirements: <UniqueSkill>[chaosBarrier],
  ),
  disorderlyBarrierExpansion(
    'Disorderly Duplex Barrier: Expansion',
    3,
    requirements: <UniqueSkill>[disorderlyBarrierFourthLayer],
  ),
  boundaryFantasyReality(
    'Boundary Between Fantasy and Reality',
    5,
    requirements: <UniqueSkill>[
      abilityUnderstandBoundaries,
      relativePsychologyMastery,
    ],
  ),
  abilityUnbridledPowerDevelopment(
    'Ability Unbridled: Power Development',
    3,
    requirements: <UniqueSkill>[abilityUnbridledGuardPierce],
  ),
  renkosPartner("Renko's Partner", 3, requirements: <UniqueSkill>[renkosEyes]),
  maryMagician(
    'Mary the Magician',
    6,
    requirements: <UniqueSkill>[
      disorderlyBarrierExpansion,
      hazyMoonBarrier,
      hazyBuffAbsorption,
    ],
  ),
  overflowingAnomalousPowerFearsome(
    'Overflowing Anomalous Power: Fearsome Anomalous Avatar',
    3,
    requirements: <UniqueSkill>[overflowingAnomalousPowerAnomaly],
  ),
  overflowingAnomalousPowerBudding(
    'Overflowing Anomalous Power: Budding of Latent Power',
    4,
    requirements: <UniqueSkill>[overflowingAnomalousPowerAnomaly],
  ),
  abilityUnbridledPowerAwakening(
    'Ability Unbridled: Power Awakening',
    4,
    requirements: <UniqueSkill>[abilityUnbridledPowerDevelopment],
  ),
  allEncompassingGuardPierce(
    'All-Encompassing Guard Pierce',
    3,
    requirements: <UniqueSkill>[abilityUnbridledGuardPierce, quickCharge2],
  ),
  // Meiling skills
  blossomingLightOrb('Light Sign "Blossoming Light Orb"', 3),
  combo('Combo', 2),
  restorativeQigong('Restorative Qigong', 3),
  focusedGuard('Focused Guard', 3),
  bondsScarletDevilMansion('Bonds of the Scarlet Devil Mansion', 3),
  qiCrestBlossomingLightOrb(
    'Light Qi "Qi Crest Blossoming Light Orb"',
    3,
    requirements: <UniqueSkill>[blossomingLightOrb],
  ),
  combo2('C-C-Combo', 2, requirements: <UniqueSkill>[combo]),
  mountainBreakingCannon('Flower Sign "Mountain-Breaking Cannon"', 3),
  qigongEnvelopment('Qigong Envelopment', 3),
  restorativeQigongAilmentRecovery(
    'Restorative Qigong: Ailment Recovery Augment',
    2,
    requirements: <UniqueSkill>[restorativeQigong],
  ),
  colorfulRain(
    'Colorful Rain',
    3,
    requirements: <UniqueSkill>[restorativeQigong],
  ),
  initialQigongGain('Initial Qigong Gain', 3),
  gatekeepersDuty("Gatekeeper's Duty", 3),
  qiCrestBlossomingLightOrbQigongGain(
    'Qi Crest Blossoming Light Orb: Qigong Gain',
    2,
    requirements: <UniqueSkill>[qiCrestBlossomingLightOrb],
  ),
  directAttackCounter('Direct Attack Counter', 4),
  mountainBreakingCannonQigongGain(
    'Mountain-Breaking Cannon: Qigong Gain',
    3,
    requirements: <UniqueSkill>[mountainBreakingCannon],
  ),
  painToQigong(
    'Pain to Qigong',
    4,
    requirements: <UniqueSkill>[qigongEnvelopment],
  ),
  qigongToStats(
    'Qigong to Stats',
    4,
    requirements: <UniqueSkill>[qigongEnvelopment],
  ),
  parSlay('PAR Slay', 3),
  colorfulRainQigongGain(
    'Colorful Rain: Qigong Gain',
    2,
    requirements: <UniqueSkill>[colorfulRain],
  ),
  qiCrestBlossomingLightOrbParAffix(
    'Qi Crest Blossoming Light Orb: PAR Affix',
    2,
    requirements: <UniqueSkill>[qiCrestBlossomingLightOrb],
  ),
  qiCrestStarPulseShot(
    'Star Qi "Qi Crest Star Pulse Shot"',
    3,
    requirements: <UniqueSkill>[qiCrestBlossomingLightOrbQigongGain],
  ),
  mountainBreakingCannon2(
    'Mountain-Breaking Cannon: POW ↑',
    2,
    requirements: <UniqueSkill>[
      mountainBreakingCannonQigongGain,
      directAttackCounter,
    ],
  ),
  qiCrestMountainBreakingCannon(
    'Flower Qi "Qi Crest Mountain-Breaking Cannon"',
    4,
    requirements: <UniqueSkill>[mountainBreakingCannonQigongGain],
  ),
  qigongEnvelopment2(
    'Qigong Envelopment: Qigong Gain ↑',
    3,
    requirements: <UniqueSkill>[qigongEnvelopment],
  ),
  qigongFromParFoes(
    'Qigong From PAR-Afflicted Foes',
    5,
    requirements: <UniqueSkill>[restorativeQigongAilmentRecovery],
  ),
  parRemovalDown(
    'PAR Removal Chance ↓',
    2,
    requirements: <UniqueSkill>[parSlay],
  ),
  initialQigongGain2(
    'Initial Qigong Gain+',
    2,
    requirements: <UniqueSkill>[colorfulRainQigongGain, initialQigongGain],
  ),
  qiCrestBlossomingLightOrb2(
    'Qi Crest Blossoming Light Orb: POW ↑',
    3,
    requirements: <UniqueSkill>[qiCrestBlossomingLightOrbQigongGain],
  ),
  directAttackCounter2(
    'Direct Attack Counter+',
    2,
    requirements: <UniqueSkill>[directAttackCounter],
  ),
  mountainBreakingCannonDelay(
    'Mountain-Breaking Cannon: Delay ↓',
    2,
    requirements: <UniqueSkill>[mountainBreakingCannonQigongGain],
  ),
  painToQigong2(
    'Pain to Qigong+',
    3,
    requirements: <UniqueSkill>[painToQigong],
  ),
  parSlay2('PAR Slay+', 2, requirements: <UniqueSkill>[parSlay]),
  colorfulRainQigongRecoveryUp(
    'Colorful Rain: Qigong Recovery ↑',
    2,
    requirements: <UniqueSkill>[colorfulRainQigongGain],
  ),
  focusedGuard2('Focused Guard+', 2, requirements: <UniqueSkill>[focusedGuard]),
  bondsScarletDevilMansion2(
    'Bonds of the Scarlet Devil Mansion+',
    2,
    requirements: <UniqueSkill>[bondsScarletDevilMansion],
  ),
  qiCrestBlossomingLightOrbParBoost(
    'Qi Crest Blossoming Light Orb: PAR Boost',
    3,
    requirements: <UniqueSkill>[
      qiCrestBlossomingLightOrbParAffix,
      qiCrestBlossomingLightOrb2,
    ],
  ),
  qiCrestStarPulseShotQigongParAffix(
    'Qi Crest Star Pulse Shot: Qigong PAR Affix',
    3,
    requirements: <UniqueSkill>[qiCrestStarPulseShot],
  ),
  mountainBreakingCannon3(
    'Mountain-Breaking Cannon: POW ↑+',
    2,
    requirements: <UniqueSkill>[
      mountainBreakingCannon2,
      mountainBreakingCannonDelay,
    ],
  ),
  masterfulMountainBreakingCannon(
    'Ultimate Flower "Masterful Mountain-Breaking Cannon"',
    4,
    requirements: <UniqueSkill>[qiCrestMountainBreakingCannon],
  ),
  qigongEnvelopment3(
    'Qigong Envelopment: Qigong Gain ↑+',
    3,
    requirements: <UniqueSkill>[qigongEnvelopment2],
  ),
  masterfulQigongEnvelopment(
    'Masterful Qigong Envelopment',
    5,
    requirements: <UniqueSkill>[qigongEnvelopment2, qigongFromParFoes],
  ),
  parRemovalDown2(
    'PAR Removal Chance ↓+',
    2,
    requirements: <UniqueSkill>[parRemovalDown],
  ),
  initialQigongGain3(
    'Initial Qigong Gain++',
    2,
    requirements: <UniqueSkill>[initialQigongGain2],
  ),
  gatekeepersDuty2(
    "Gatekeeper's Duty+",
    2,
    requirements: <UniqueSkill>[gatekeepersDuty],
  ),
  directAttackCounter3(
    'Direct Attack Counter++',
    2,
    requirements: <UniqueSkill>[directAttackCounter2],
  ),
  mountainBreakingCannonQigongGain2(
    'Mountain-Breaking Cannon: Qigong Gain+',
    2,
    requirements: <UniqueSkill>[mountainBreakingCannonDelay],
  ),
  painToQigong3(
    'Pain to Qigong++',
    3,
    requirements: <UniqueSkill>[painToQigong2],
  ),
  jiQigongResultsTraining(
    'Ji Qigong: Results of Training',
    3,
    requirements: <UniqueSkill>[masterfulQigongEnvelopment],
  ),
  jiQigongMuscleSolstice(
    'Ji Qigong: Muscle Solstice',
    3,
    requirements: <UniqueSkill>[masterfulQigongEnvelopment, parRemovalDown2],
  ),
  bondsScarletDevilMansion3(
    'Bonds of the Scarlet Devil Mansion++',
    2,
    requirements: <UniqueSkill>[bondsScarletDevilMansion2],
  ),
  masterfulEarthMovingStarPulseShot(
    'Ultimate Star "Masterful Earth-Moving Star Pulse Shot"',
    5,
    requirements: <UniqueSkill>[qiCrestStarPulseShotQigongParAffix],
  ),
  masterfulMountainBreakingCannonGuardPierce(
    'Masterful Mountain-Breaking Cannon: Guard Pierce',
    3,
    requirements: <UniqueSkill>[masterfulMountainBreakingCannon, painToQigong3],
  ),
  jiQigongCulminationTraining(
    'Ji Qigong: Culmination of Training',
    3,
    requirements: <UniqueSkill>[painToQigong, jiQigongResultsTraining],
  ),
  jiQigong2(
    'Ji Qigong: Duration ↑',
    2,
    requirements: <UniqueSkill>[masterfulQigongEnvelopment],
  ),
  // Alice skills
  manipulatePuppet('Puppeteer Sign "Manipulate Puppet"', 3),
  artfulSacrifice('Magic Sign "Artful Sacrifice"', 3),
  shanghaiDolls('Malediction "Magically Luminous Shanghai Dolls"', 3),
  tripwire('Focus Power "Tripwire"', 3),
  artfulSacrificeAcc(
    'Artful Sacrifice: ACC Modifier ↑',
    3,
    requirements: <UniqueSkill>[artfulSacrifice],
  ),
  artfulSacrificeGunpowder(
    'Artful Sacrifice: Gunpowder-Lobbing Witch',
    3,
    requirements: <UniqueSkill>[artfulSacrifice],
  ),
  shanghaiDollsHvy(
    'Magically Luminous Shanghai Dolls: HVY Affix',
    3,
    requirements: <UniqueSkill>[shanghaiDolls],
  ),
  inorganicExpert('Inorganic Expert', 3),
  manipulatePuppet2(
    'Manipulate Puppet: POW ↑',
    3,
    requirements: <UniqueSkill>[manipulatePuppet],
  ),
  mercilessPursuit(
    'Merciless Pursuit',
    3,
    requirements: <UniqueSkill>[manipulatePuppet],
  ),
  hangedHouraiDolls(
    'Malediction "Hanged Hourai Dolls"',
    3,
    requirements: <UniqueSkill>[shanghaiDolls],
  ),
  dollGuard('Doll Guard', 3),
  inorganicExpert2(
    'Inorganic Expert+',
    3,
    requirements: <UniqueSkill>[inorganicExpert],
  ),
  // Copies from focus_reaction.dart
  //quickCharge('Quick Charge', 3),
  mAliceCannonAlice('MAlice Cannon (Alice)', 3),
  manipulatePuppetShanghaiOption(
    'Manipulate Puppet: Shanghai Dolls Option',
    3,
    requirements: <UniqueSkill>[manipulatePuppet2],
  ),
  manipulatePuppetDuration(
    'Manipulate Puppet: Duration ↑',
    3,
    requirements: <UniqueSkill>[manipulatePuppet2],
  ),
  tripwireWireArt(
    'Tripwire: Wire Art',
    3,
    requirements: <UniqueSkill>[tripwire],
  ),
  tripwire2(
    'Tripwire: Damage Multiplier ↑',
    3,
    requirements: <UniqueSkill>[tripwire],
  ),
  soldierOfCross(
    'Sword Sign "Soldier of Cross"',
    3,
    requirements: <UniqueSkill>[inorganicExpert],
  ),
  efficientPuppeteering(
    'Efficient Puppeteering',
    3,
    requirements: <UniqueSkill>[quickCharge, mAliceCannonAlice],
  ),
  manipulatePuppetHouraiOption(
    'Manipulate Puppet: Hanged Hourai Dolls Option',
    3,
    requirements: <UniqueSkill>[manipulatePuppetShanghaiOption],
  ),
  mercilessPursuit2(
    'Merciless Pursuit+',
    2,
    requirements: <UniqueSkill>[mercilessPursuit],
  ),
  littleLegion(
    'War Sign "Little Legion"',
    3,
    requirements: <UniqueSkill>[tripwire2],
  ),
  tripwireAilmentBoost(
    'Tripwire: Ailment Boost',
    3,
    requirements: <UniqueSkill>[tripwire2],
  ),
  suicideSquad(
    'Suicide Squad',
    4,
    requirements: <UniqueSkill>[tripwire, artfulSacrifice, hangedHouraiDolls],
  ),
  dollCrusader('Doll Crusader', 3, requirements: <UniqueSkill>[dollGuard]),
  inorganicExpertDamageTaken(
    'Inorganic Expert: Damage Taken ↓ Augment',
    3,
    requirements: <UniqueSkill>[inorganicExpert2],
  ),
  manipulatePuppetMpCut(
    'Manipulate Puppet: MP Cut',
    3,
    requirements: <UniqueSkill>[manipulatePuppetShanghaiOption],
  ),
  manipulatePuppetDuration2(
    'Manipulate Puppet: Duration ↑+',
    3,
    requirements: <UniqueSkill>[manipulatePuppetDuration],
  ),
  tripwireHighWireArt(
    'Tripwire: Highly-Skilled Wire Art',
    3,
    requirements: <UniqueSkill>[tripwireWireArt],
  ),
  littleLegionDamageRange(
    'Little Legion: Damage Range ↑',
    3,
    requirements: <UniqueSkill>[littleLegion],
  ),
  suicideSquadSize(
    'Suicide Squad: Squad Size ↑',
    3,
    requirements: <UniqueSkill>[suicideSquad],
  ),
  returnInanimateness('Magic Puppeteering "Return Inanimateness"', 3),
  dollGuard2('Doll Guard+', 3, requirements: <UniqueSkill>[dollCrusader]),
  manipulatePuppetTripwireOption(
    'Manipulate Puppet: Tripwire Option',
    3,
    requirements: <UniqueSkill>[manipulatePuppetHouraiOption],
  ),
  ailmentChance(
    'Ailment Chance ↑',
    5,
    requirements: <UniqueSkill>[mercilessPursuit2],
  ),
  littleLegionAtkAffix(
    'Little Legion: ATK ↓ Affix',
    3,
    requirements: <UniqueSkill>[littleLegion],
  ),
  returnInanimatenessBombLobbing(
    'Return Inanimateness: Bomb-Lobbing Witch',
    3,
    requirements: <UniqueSkill>[returnInanimateness],
  ),
  dollCrusader2('Doll Crusader+', 3, requirements: <UniqueSkill>[dollCrusader]),
  guardianMarionette(
    'Knight Sign "Guardian Marionette"',
    3,
    requirements: <UniqueSkill>[soldierOfCross],
  ),
  // Copies from focus_reaction.dart
  //quickCharge2(
  //  'Quick Charge+',
  //  2,
  //  requirements: <UniqueSkill>[quickCharge],
  //),
  mAliceCannonAlice2(
    'MAlice Cannon (Alice)+',
    3,
    requirements: <UniqueSkill>[mAliceCannonAlice],
  ),
  manipulatePuppetOptionChance(
    'Manipulate Puppet: Option Chance ↑',
    3,
    requirements: <UniqueSkill>[manipulatePuppetMpCut],
  ),
  dollsWar(
    '''War Puppeteering "Dolls' War"''',
    3,
    requirements: <UniqueSkill>[littleLegionDamageRange, suicideSquadSize],
  ),
  suicideSquadSize2(
    'Suicide Squad: Squad Size ↑+',
    3,
    requirements: <UniqueSkill>[suicideSquadSize],
  ),
  efficientPuppeteering2(
    'Efficient Puppeteering+',
    5,
    requirements: <UniqueSkill>[
      quickCharge2,
      efficientPuppeteering,
      mAliceCannonAlice2,
    ],
  ),
  // Nitori skills
  kappaObservations('Observations of a Kappa', 3),
  kappaWaterfall('''Water Sign "Kappa's Illusionary Waterfall"''', 3),
  extendingArm('''Kappa "Exteeeending Aaaaarm"''', 3),
  basicMaintenance('Basic Maintenance', 3),
  kappaWaterfallDef(
    "Kappa's Illusionary Waterfall: DEF ↓ Affix",
    3,
    requirements: <UniqueSkill>[kappaWaterfall],
  ),
  kappaWaterfallGadgetCooling(
    "Kappa's Illusionary Waterfall: Gadget-Cooling Feature",
    3,
    requirements: <UniqueSkill>[kappaWaterfall],
  ),
  portableUtilityDevice('Portable Utility Device', 3),
  kappaWaterfallHeatPump(
    "Kappa's Illusionary Waterfall: Heat Pump",
    3,
    requirements: <UniqueSkill>[kappaWaterfallDef],
  ),
  abilityManipulateWater('Ability to Manipulate Water', 3),
  thrillingQuenchHandling(
    'Thrilling Quench Handling',
    3,
    requirements: <UniqueSkill>[kappaWaterfallGadgetCooling],
  ),
  piercingExtendingArm(
    '''Great Kappa "Piercing Exteeeending Aaaaarm"''',
    3,
    requirements: <UniqueSkill>[extendingArm],
  ),
  opticalCamouflage('Optics "Optical Camouflage"', 3),
  exhaustUtilizationSystem(
    'Exhaust Utilization System',
    3,
    requirements: <UniqueSkill>[portableUtilityDevice],
  ),
  properMaintenance(
    'Proper Maintenance',
    3,
    requirements: <UniqueSkill>[basicMaintenance],
  ),
  kappaObservations2(
    'Observations of a Kappa+',
    3,
    requirements: <UniqueSkill>[kappaObservations],
  ),
  overdrive('Overdrive', 3),
  kappaWaterfallImprovedCooling(
    "Kappa's Illusionary Waterfall: Improved Cooling",
    3,
    requirements: <UniqueSkill>[
      abilityManipulateWater,
      kappaWaterfallGadgetCooling,
    ],
  ),
  accelDrive(
    'Accel Drive',
    3,
    requirements: <UniqueSkill>[thrillingQuenchHandling],
  ),
  dividingEdge(
    'River Sign "Dividing Edge"',
    3,
    requirements: <UniqueSkill>[opticalCamouflage],
  ),
  exhaustIncinerator('Explosive Flames "Exhaust Incinerator"', 3),
  portableUtilityDevice2(
    'Portable Utility Device: Effect ↑',
    3,
    requirements: <UniqueSkill>[portableUtilityDevice],
  ),
  exhaustDefensiveSystem(
    'Exhaust Defensive System',
    3,
    requirements: <UniqueSkill>[exhaustUtilizationSystem],
  ),
  exhaustPropulsionSystem(
    'Exhaust Propulsion System',
    3,
    requirements: <UniqueSkill>[exhaustUtilizationSystem],
  ),
  kappaWaterfallAcidicRecycling(
    "Kappa's Illusionary Waterfall: Acidic Wastewater Recycling",
    3,
    requirements: <UniqueSkill>[kappaWaterfallHeatPump],
  ),
  abilityManipulateWater2(
    'Ability to Manipulate Water+',
    3,
    requirements: <UniqueSkill>[abilityManipulateWater],
  ),
  superHighHeatQuenchHandling(
    'Super High-Heat Quench Handling',
    3,
    requirements: <UniqueSkill>[thrillingQuenchHandling],
  ),
  superScope3D(
    'Super Scope 3D',
    3,
    requirements: <UniqueSkill>[piercingExtendingArm],
  ),
  opticalCamouflageBoostGain(
    'Optical Camouflage: Boost Gain',
    3,
    requirements: <UniqueSkill>[opticalCamouflage],
  ),
  autoCooling('Auto-Cooling', 3),
  portableUtilityDeviceScale(
    'Portable Utility Device: Scale Improvements',
    3,
    requirements: <UniqueSkill>[portableUtilityDevice2],
  ),
  efficientExhaustUtilizationSystem(
    'Efficient Exhaust Utilization System',
    3,
    requirements: <UniqueSkill>[exhaustUtilizationSystem],
  ),
  adeptMaintenance(
    'Adept Maintenance',
    3,
    requirements: <UniqueSkill>[properMaintenance],
  ),
  kappaObservationsShieldConversion(
    'Observations of a Kappa: Shield Conversion',
    3,
    requirements: <UniqueSkill>[kappaObservations2],
  ),
  megadrive(
    'Megadrive',
    4,
    requirements: <UniqueSkill>[overdrive, abilityManipulateWater2],
  ),
  kappaWaterfallImprovedCooling2(
    "Kappa's Illusionary Waterfall: Improved Cooling+",
    3,
    requirements: <UniqueSkill>[
      abilityManipulateWater2,
      kappaWaterfallImprovedCooling,
    ],
  ),
  superScope3DImprovedControl(
    'Super Scope 3D: Improved Firing Control',
    3,
    requirements: <UniqueSkill>[superScope3D],
  ),
  highOpticalCamouflage(
    'Optics "High-Optical Camouflage"',
    3,
    requirements: <UniqueSkill>[opticalCamouflageBoostGain],
  ),
  exhaustIncineratorRowModification(
    'Exhaust Incinerator: Row Modification',
    3,
    requirements: <UniqueSkill>[exhaustIncinerator],
  ),
  portableUtilityDevicePortability(
    'Portable Utility Device: Portability Improvements',
    3,
    requirements: <UniqueSkill>[portableUtilityDeviceScale],
  ),
  efficientExhaustDefensiveSystem(
    'Efficent Exhaust Defensive System',
    3,
    requirements: <UniqueSkill>[exhaustUtilizationSystem],
  ),
  efficientExhaustPropulsionSystem(
    'Efficient Exhaust Propulsion System',
    3,
    requirements: <UniqueSkill>[exhaustUtilizationSystem],
  ),
  hiAccelDrive(
    'Hi-Accel Drive',
    3,
    requirements: <UniqueSkill>[superHighHeatQuenchHandling, accelDrive],
  ),
  improvedAutoCooling(
    'Improved Auto-Cooling',
    3,
    requirements: <UniqueSkill>[
      exhaustIncineratorRowModification,
      autoCooling,
      portableUtilityDevicePortability,
    ],
  ),
  lastOne(
    'Last One',
    3,
    requirements: <UniqueSkill>[
      efficientExhaustDefensiveSystem,
      efficientExhaustUtilizationSystem,
      efficientExhaustPropulsionSystem,
    ],
  ),
  gigadrive(
    'Gigadrive',
    5,
    requirements: <UniqueSkill>[kappaObservationsShieldConversion, megadrive],
  ),
  superScope3DImprovedControl2(
    'Super Scope 3D: Improved Firing Control+',
    3,
    requirements: <UniqueSkill>[superScope3DImprovedControl],
  ),
  superHighHeatIncinerator(
    'Raging Flames "Super High-Heat Incinerator"',
    3,
    requirements: <UniqueSkill>[
      highOpticalCamouflage,
      exhaustIncineratorRowModification,
    ],
  ),
  // Aya skills
  gustFan('Gust Fan', 3),
  tenguWind("Tengu's Wind", 3),
  teachingsGensokyosFastest("Teaching of Gensokyo's Fastest", 3),
  agility('Agility', 3),
  abilityManipulateWind('Ability to Manipulate Wind', 3),
  windGodGirl('Gust "Wind God Girl"', 3),
  guidepostDivineGrandsonsAdvent(
    '''Tornado "Guidepost for the Divine Grandson's Advent"''',
    3,
    requirements: <UniqueSkill>[tenguWind],
  ),
  tenguWind2(
    "Tengu's Wind: Effect ↑",
    3,
    requirements: <UniqueSkill>[tenguWind],
  ),
  sarutahikosGuidance(
    "Squall 'Sarutahiko's Guidance'",
    3,
    requirements: <UniqueSkill>[tenguWind],
  ),
  extraStep('Extra Step', 3),
  evasiveAction('Evasive Action', 3),
  abilityManipulateWind2(
    'Ability to Manipulate Wind+',
    3,
    requirements: <UniqueSkill>[abilityManipulateWind],
  ),
  galeFan('Gale Fan', 3, requirements: <UniqueSkill>[gustFan]),
  windGodGirlSpd(
    'Wind God Girl: SPD ↑ Augment',
    3,
    requirements: <UniqueSkill>[windGodGirl],
  ),
  windGodGirlEva(
    'Wind God Girl: EVA ↑ Augment',
    3,
    requirements: <UniqueSkill>[windGodGirl],
  ),
  dashingGrace('Dashing Grace', 3, requirements: <UniqueSkill>[tenguWind]),
  teachingsGensokyosFastest2(
    "Teachings of Gensokyo's Fastest+",
    3,
    requirements: <UniqueSkill>[teachingsGensokyosFastest],
  ),
  tenguOfGales(
    'Tengu of Gales',
    3,
    requirements: <UniqueSkill>[galeFan, windGodGirlSpd],
  ),
  peerlessWindGod(
    'Peerless Wind God',
    3,
    requirements: <UniqueSkill>[windGodGirl],
  ),
  guidepostDivineGrandsonsAdvent2(
    "Guidepost for the Divine Grandson's Advent: Effect ↑",
    3,
    requirements: <UniqueSkill>[guidepostDivineGrandsonsAdvent],
  ),
  sarutahikosTwinklingEyes(
    "Sarutahiko's Guidance: Sarutahiko's Twinkling Eyes",
    3,
    requirements: <UniqueSkill>[sarutahikosGuidance],
  ),
  extraStep2('Extra Step+', 3, requirements: <UniqueSkill>[extraStep]),
  evasiveAction2(
    'Evasive Action+',
    3,
    requirements: <UniqueSkill>[evasiveAction],
  ),
  abilityManipulateWindBoost(
    'Ability to Manipulate Wind: Boost Conversion',
    3,
    requirements: <UniqueSkill>[abilityManipulateWind2],
  ),
  tempestFan(
    'Tempest Fan',
    3,
    requirements: <UniqueSkill>[abilityManipulateWind2, galeFan],
  ),
  peerlessWindGodSpd(
    'Peerless Wind God: SPD ↑ Augment',
    3,
    requirements: <UniqueSkill>[peerlessWindGod],
  ),
  peerlessWindGodEva(
    'Peerless Wind God: EVA ↑ Augment',
    3,
    requirements: <UniqueSkill>[peerlessWindGod],
  ),
  divineGrandsonsAdvent(
    '''Blockade Sign "Divine Grandson's Advent"''',
    3,
    requirements: <UniqueSkill>[guidepostDivineGrandsonsAdvent2, dashingGrace],
  ),
  gracefulEvasion(
    'Graceful Evasion',
    3,
    requirements: <UniqueSkill>[dashingGrace],
  ),
  nanaatasRedNose(
    "Sarutahiko's Guidance: Nanaata's Red Nose",
    3,
    requirements: <UniqueSkill>[sarutahikosTwinklingEyes],
  ),
  teachingsGensokyosFastest3(
    "Teachings of Gensokyo's Fastest++",
    3,
    requirements: <UniqueSkill>[teachingsGensokyosFastest2],
  ),
  agility2('Agility+', 3, requirements: <UniqueSkill>[agility]),
  windGodAvatar(
    'Wind God Avatar',
    3,
    requirements: <UniqueSkill>[peerlessWindGod],
  ),
  dashingGrace2('Dashing Grace+', 3, requirements: <UniqueSkill>[dashingGrace]),
  gracefulWingwork(
    'Graceful Wingwork',
    3,
    requirements: <UniqueSkill>[dashingGrace],
  ),
  extraStep3('Extra Step++', 3, requirements: <UniqueSkill>[extraStep2]),
  evasiveAction3(
    'Evasive Action++',
    3,
    requirements: <UniqueSkill>[evasiveAction2],
  ),
  tenguOfTempests(
    'Tengu of Tempests',
    3,
    requirements: <UniqueSkill>[abilityManipulateWindBoost, tempestFan],
  ),
  flutteringYoukaiFan(
    'Fluttering Youkai Fan',
    3,
    requirements: <UniqueSkill>[abilityManipulateWindBoost, tempestFan],
  ),
  clothedInWindstorms(
    'Clothed in Windstorms',
    3,
    requirements: <UniqueSkill>[windGodAvatar],
  ),
  crossroadsOfHeaven(
    'Crossroad Sign "Crossroads of Heaven"',
    3,
    requirements: <UniqueSkill>[windGodAvatar, divineGrandsonsAdvent],
  ),
  shiningAdventPath(
    "Divine Grandson's Advent: Shining Advent Path",
    3,
    requirements: <UniqueSkill>[divineGrandsonsAdvent],
  ),
  gracefulEvasion2(
    'Graceful Evasion+',
    3,
    requirements: <UniqueSkill>[gracefulEvasion],
  ),
  guidingOnesBack(
    "Sarutahiko's Guidance: Guiding One's Back",
    3,
    requirements: <UniqueSkill>[nanaatasRedNose],
  ),
  teachingsGensokyosFastest4(
    "Teachings of Gensokyo's Fastest+++",
    3,
    requirements: <UniqueSkill>[teachingsGensokyosFastest3],
  ),
  crossroadsOfHeavenEyesOfHeaven(
    'Crossroads of Heaven: Eyes of Heaven',
    3,
    requirements: <UniqueSkill>[flutteringYoukaiFan, crossroadsOfHeaven],
  ),
  crossroadsOfHeavenSoaringEightBoatJump(
    'Crossroads of Heaven: Soaring Eight-Boat Jump',
    3,
    requirements: <UniqueSkill>[crossroadsOfHeaven, shiningAdventPath],
  ),
  takingFantasyByStorm(
    'Taking Fantasy by Storm',
    3,
    requirements: <UniqueSkill>[guidepostDivineGrandsonsAdvent2, dashingGrace],
  ),
  gracefulWingwork2(
    'Graceful Wingwork+',
    3,
    requirements: <UniqueSkill>[gracefulWingwork],
  ),
  // Patchouli skills
  philosopherStone("Philosopher's Stone", 3),
  agniShine('Fire Sign "Agni Shine"', 3),
  gingerGust('Metal Earth Sign "Ginger Gust"', 3),
  metalFatigue('Metal Sign "Metal Fatigue"', 3),
  philosopherStoneInitiative(
    "Philosopher's Stone - Initiative Type",
    3,
    requirements: <UniqueSkill>[philosopherStone],
  ),
  philosopherStoneSustained(
    "Philosopher's Stone - Sustained Type",
    3,
    requirements: <UniqueSkill>[philosopherStone],
  ),
  fundamentalMagicImprovements(
    'Fundamental Magic Improvements',
    3,
    requirements: <UniqueSkill>[philosopherStone],
  ),
  agniShine2(
    'Agni Shine: POW ↑',
    3,
    requirements: <UniqueSkill>[agniShine],
  ),
  princessUndine('Water Sign "Princess Undine"', 3),
  gingerGust2(
    'Ginger Gust: POW ↑',
    3,
    requirements: <UniqueSkill>[gingerGust],
  ),
  satelliteHimawari('Moon Wood Sign "Satellite Himawari"', 3),
  metalFatigue2(
    'Metal Fatigue: POW ↑',
    3,
    requirements: <UniqueSkill>[metalFatigue],
  ),
  philosopherStoneProtective(
    "Philosopher's Stone - Protective Type",
    3,
    requirements: <UniqueSkill>[
      philosopherStoneInitiative,
      philosopherStoneSustained,
    ],
  ),
  philosopherStoneHighLevel(
    "Philosopher's Stone - High-Level Elements",
    3,
    requirements: <UniqueSkill>[philosopherStone],
  ),
  agniShineAtk(
    'Agni Shine: ATK ↑ Augment',
    3,
    requirements: <UniqueSkill>[agniShine2],
  ),
  phlogisticRain(
    'Water Fire Sign "Phlogistic Rain"',
    3,
    requirements: <UniqueSkill>[agniShine2],
  ),
  princessUndine2(
    'Princess Undine: POW ↑',
    3,
    requirements: <UniqueSkill>[princessUndine],
  ),
  gingerGustSpd(
    'Ginger Gust: SPD ↑ Augment',
    3,
    requirements: <UniqueSkill>[gingerGust2],
  ),
  sylphyHorn(
    'Wood Sign "Sylphy Horn"',
    3,
    requirements: <UniqueSkill>[gingerGust],
  ),
  satelliteHimawari2(
    'Satellite Himawari: POW ↑',
    3,
    requirements: <UniqueSkill>[satelliteHimawari],
  ),
  metalFatigueDef(
    'Metal Fatigue: DEF ↑ Augment',
    3,
    requirements: <UniqueSkill>[metalFatigue2],
  ),
  silverDragon(
    'Metal Sign "Silver Dragon"',
    3,
    requirements: <UniqueSkill>[metalFatigue],
  ),
  initiativeTypeImproved(
    'Initiative Type - Improved Quantity',
    3,
    requirements: <UniqueSkill>[philosopherStoneInitiative],
  ),
  sustainedTypeImproved(
    'Sustained Type - Improved Quantity',
    3,
    requirements: <UniqueSkill>[philosopherStoneSustained],
  ),
  phlogisticRain2(
    'Phlogistic Rain: POW ↑',
    3,
    requirements: <UniqueSkill>[phlogisticRain],
  ),
  princessUndineMag(
    'Princess Undine: MAG ↑ Augment',
    3,
    requirements: <UniqueSkill>[princessUndine2],
  ),
  mercuryPoison(
    'Metal Water Sign "Mercury Poison"',
    3,
    requirements: <UniqueSkill>[princessUndine],
  ),
  sylphyHorn2(
    'Sylphy Horn: POW ↑',
    3,
    requirements: <UniqueSkill>[sylphyHorn],
  ),
  satelliteHimawariMnd(
    'Satellite Himawari: MND ↑ Augment',
    3,
    requirements: <UniqueSkill>[satelliteHimawari2],
  ),
  forestBlaze(
    'Wood Fire Sign "Forest Blaze"',
    3,
    requirements: <UniqueSkill>[satelliteHimawari],
  ),
  silverDragon2(
    'Silver Dragon: POW ↑',
    3,
    requirements: <UniqueSkill>[silverDragon],
  ),
  philosopherStoneImprovedProtection(
    "Philosopher's Stone - Improved Protection",
    3,
    requirements: <UniqueSkill>[philosopherStoneProtective],
  ),
  royalFlare(
    'Sun Sign "Royal Flare"',
    3,
    requirements: <UniqueSkill>[philosopherStoneHighLevel],
  ),
  silentSelene(
    'Moon Sign "Silent Selene"',
    3,
    requirements: <UniqueSkill>[philosopherStoneHighLevel],
  ),
  mercuryPoison2(
    'Mercury Poison: POW ↑',
    3,
    requirements: <UniqueSkill>[princessUndine2, mercuryPoison],
  ),
  forestBlaze2(
    'Forest Blaze: POW ↑',
    3,
    requirements: <UniqueSkill>[satelliteHimawari2, forestBlaze],
  ),
  protectiveTypeLatest(
    'Protective Type - Latest Revision',
    3,
    requirements: <UniqueSkill>[
      initiativeTypeImproved,
      philosopherStoneImprovedProtection,
    ],
  ),
  protectiveTypeRecovery(
    'Protective Type - Recovery Response',
    3,
    requirements: <UniqueSkill>[
      philosopherStoneImprovedProtection,
      sustainedTypeImproved,
    ],
  ),
  sunSignRemnantPower(
    'Sun Sign - Remnant Power',
    3,
    requirements: <UniqueSkill>[royalFlare],
  ),
  moonSignRemnantPower(
    'Moon Sign - Remnant Power',
    3,
    requirements: <UniqueSkill>[silentSelene],
  ),
  multiElementCasting(
    'Multi-Element Casting Efficiency',
    3,
    requirements: <UniqueSkill>[
      phlogisticRain2,
      mercuryPoison2,
    ],
  ),
  compoundMagicImprovements(
    'Compound Magic Improvements',
    3,
    requirements: <UniqueSkill>[mercuryPoison2, sylphyHorn2],
  ),
  multiElementPrinciples(
    'Multi-Element Principles',
    3,
    requirements: <UniqueSkill>[sylphyHorn2, forestBlaze2],
  ),
  fiveSeasons(
    'Five Seasons',
    3,
    requirements: <UniqueSkill>[forestBlaze2, silverDragon2],
  ),
  philosopherStoneSacrificial(
    "Philosopher's Stone - Sacrificial Type",
    5,
    requirements: <UniqueSkill>[philosopherStoneImprovedProtection],
  ),
  royalDiamondRing(
    'Sun Moon Sign "Royal Diamond Ring"',
    3,
    requirements: <UniqueSkill>[sunSignRemnantPower, moonSignRemnantPower],
  ),
  fiveSeasonsBuffing(
    'Five Seasons: Buffing Season',
    3,
    requirements: <UniqueSkill>[fiveSeasons],
  ),
  fiveSeasonsDebuffing(
    'Five Seasons: Debuffing Season',
    3,
    requirements: <UniqueSkill>[fiveSeasons],
  ),
  sunMoonPersistentBuffing(
    'Sun & Moon Sign - Persistent Buffing Magic',
    3,
    requirements: <UniqueSkill>[royalDiamondRing],
  ),
  sunMoonEfficientMagic(
    'Sun & Moon Sign - Efficient Magic',
    3,
    requirements: <UniqueSkill>[royalDiamondRing],
  ),
  moonFireWaterWoodMetal(
    'Moon/Fire/Water/Wood/Metal Improvements',
    3,
    requirements: <UniqueSkill>[multiElementCasting, compoundMagicImprovements],
  ),
  fiveSeasonsWeekday(
    'Five Seasons: Weekday Magic Season',
    3,
    requirements: <UniqueSkill>[fiveSeasons],
  ),
  // Cirno skills
  frostKing('Ice King "Frost King"', 3),
  icicleFall('Ice Sign "Icicle Fall"', 3),
  inexhaustibleEnergy('Inexhaustible Energy', 2),
  icicleFallSpdDownAffix(
    'Icicle Fall: SPD ↓ Affix',
    3,
    requirements: <UniqueSkill>[icicleFall],
  ),
  tomboyishGirlIce('Tomboyish Girl of Ice', 3),
  diamondBlizzard(
    'Snow Sign "Diamond Blizzard"',
    3,
    requirements: <UniqueSkill>[icicleFall],
  ),
  tryTryAgain('Try, Try Again!', 4),
  abilityManipulateCold('Ability to Manipulate Cold', 3),
  bondsBakaQuartet('Bonds of the Baka Quartet', 3),
  autoFrostKing(
    'Auto Frost King',
    3,
    requirements: <UniqueSkill>[frostKing],
  ),
  icicleFall2(
    'Icicle Fall: POW ↑',
    2,
    requirements: <UniqueSkill>[icicleFall, tomboyishGirlIce],
  ),
  petalScatteringBlizzardGale(
    'Petal-Scattering Blizzard Gale',
    5,
    requirements: <UniqueSkill>[diamondBlizzard, tryTryAgain],
  ),
  imFineOnMyOwn("I'm Fine On My Own!", 3),
  icicleFallSpdDownBoost(
    'Icicle Fall: SPD ↓ Boost',
    3,
    requirements: <UniqueSkill>[icicleFallSpdDownAffix],
  ),
  superTomboyishGirlIce(
    'Super Tomboyish Girl of Ice',
    2,
    requirements: <UniqueSkill>[tomboyishGirlIce],
  ),
  diamondBlizzardPar(
    'Diamond Blizzard: PAR chance ↑',
    3,
    requirements: <UniqueSkill>[diamondBlizzard],
  ),
  tryTryAgain2(
    'Try, Try Again! ...Again!',
    3,
    requirements: <UniqueSkill>[tryTryAgain],
  ),
  perfectFreeze(
    'Freeze Sign "Perfect Freeze"',
    4,
    requirements: <UniqueSkill>[abilityManipulateCold],
  ),
  abilityManipulateCold2(
    'Ability to Manipulate Cold+',
    2,
    requirements: <UniqueSkill>[abilityManipulateCold],
  ),
  freezeAtmosphere(
    'Freeze Sign "Freeze Atmosphere"',
    3,
    requirements: <UniqueSkill>[abilityManipulateCold],
  ),
  bondsBakaQuartet2(
    'Bonds of the Baka Quartet+',
    2,
    requirements: <UniqueSkill>[bondsBakaQuartet],
  ),
  frostKingUnendingMonarchy(
    'Frost King: Unending Monarchy',
    3,
    requirements: <UniqueSkill>[autoFrostKing],
  ),
  frostColumns('Frost Sign "Frost Columns"', 3),
  absoluteZeroFairy(
    'Absolute Zero Fairy',
    2,
    requirements: <UniqueSkill>[icicleFall2, superTomboyishGirlIce],
  ),
  swordFreezer(
    'Ice Sign "Sword Freezer"',
    4,
    requirements: <UniqueSkill>[superTomboyishGirlIce, diamondBlizzardPar],
  ),
  redHotIcySpirit(
    'Red-Hot Icy Spirit',
    4,
    requirements: <UniqueSkill>[petalScatteringBlizzardGale],
  ),
  inexhaustibleEnergy2(
    'Inexhaustible Energy+',
    2,
    requirements: <UniqueSkill>[inexhaustibleEnergy],
  ),
  abilityManipulateColdBoost(
    'Ability to Manipulate Cold: Boost Conversion',
    2,
    requirements: <UniqueSkill>[abilityManipulateCold2],
  ),
  imFineOnMyOwn2(
    "I'm Fine On My Own!+",
    2,
    requirements: <UniqueSkill>[imFineOnMyOwn],
  ),
  icicleFallSpdDownBoost2(
    'Icicle Fall: SPD ↓ Boost+',
    3,
    requirements: <UniqueSkill>[icicleFallSpdDownBoost],
  ),
  iceFairyFreezingSkills(
    "Ice Fairy's Freezing Skills",
    4,
    requirements: <UniqueSkill>[absoluteZeroFairy],
  ),
  swordFreezerGuardPierce(
    'Sword Freezer: Guard Pierce',
    2,
    requirements: <UniqueSkill>[swordFreezer],
  ),
  stubbornTilTheEnd(
    "Stubborn 'Til the End",
    6,
    requirements: <UniqueSkill>[tryTryAgain2],
  ),
  perfectFreeze2(
    'Perfect Freeze: POW ↑',
    2,
    requirements: <UniqueSkill>[perfectFreeze],
  ),
  bondsBakaQuartet3(
    'Bonds of the Baka Quartet++',
    2,
    requirements: <UniqueSkill>[bondsBakaQuartet2],
  ),
  frostColumnsUnmeltingIcicles(
    'Frost Columns: Unmelting Icicles',
    3,
    requirements: <UniqueSkill>[
      frostKingUnendingMonarchy,
      frostColumns,
      icicleFallSpdDownBoost2,
    ],
  ),
  iceFairyAcrobaticSkills(
    "Ice Fairy's Acrobatic Skills",
    3,
    requirements: <UniqueSkill>[absoluteZeroFairy],
  ),
  swordFreezerParSpdDownSlay(
    'Sword Freezer: PAR+SPD ↓ Slay',
    3,
    requirements: <UniqueSkill>[swordFreezerGuardPierce],
  ),
  persistentSpirit(
    'Persistent Spirit',
    3,
    requirements: <UniqueSkill>[redHotIcySpirit],
  ),
  perfectFreezeSpdDownChanceUp(
    'Perfect Freeze: SPD ↓ Chance ↑',
    3,
    requirements: <UniqueSkill>[perfectFreeze2],
  ),
  perfectFreezeSpdDownSlay(
    'Perfect Freeze: SPD ↓ Slay',
    2,
    requirements: <UniqueSkill>[perfectFreeze2],
  ),
  imFineOnMyOwn3(
    "I'm Fine On My Own!++",
    2,
    requirements: <UniqueSkill>[imFineOnMyOwn2],
  ),
  proofOfTheStrongest(
    'Proof of the Strongest',
    5,
    requirements: <UniqueSkill>[icicleFallSpdDownBoost2],
  ),
  absoluteZeroQueen(
    'Absolute Zero Queen',
    3,
    requirements: <UniqueSkill>[
      iceFairyAcrobaticSkills,
      iceFairyFreezingSkills,
    ],
  ),
  swordFreezerBlizzardBladedance(
    'Sword Freezer: Blizzard Bladedance',
    5,
    requirements: <UniqueSkill>[swordFreezerParSpdDownSlay],
  ),
  perfectFreezeAbsoluteStillness(
    'Perfect Freeze: Absolute Stillness',
    3,
    requirements: <UniqueSkill>[perfectFreezeSpdDownChanceUp],
  ),
  perfectFreezeSpdDownSlay2(
    'Perfect Freeze: SPD ↓ Slay+',
    2,
    requirements: <UniqueSkill>[perfectFreezeSpdDownSlay],
  ),
  // Keine skills
  jewelsDivineProtection("Jewel's Divine Protection", 3),
  oldHistory('''Old History "Untrodden Land's History"''', 3),
  immovable('Immovable', 3),
  historiansPointer("Historian's Pointer", 3),
  swordsDivineProtection(
    "Sword's Divine Protection",
    3,
    requirements: <UniqueSkill>[jewelsDivineProtection],
  ),
  jewelsDivineProtectionDuration(
    "Jewel's Divine Protection: Self-Use Duration ↑",
    3,
    requirements: <UniqueSkill>[jewelsDivineProtection],
  ),
  nextHistory('Next History "New History of Fantasy"', 3),
  organizedFormation(
    'Organized Formation',
    2,
    requirements: <UniqueSkill>[immovable],
  ),
  swordsDivineProtectionDuration(
    "Sword's Divine Protection: Self-Use Duration ↑",
    2,
    requirements: <UniqueSkill>[swordsDivineProtection],
  ),
  countrySignJewel(
    'Country Sign "Three Sacred Treasures - Jewel"',
    4,
  ),
  untroddenLandsHistoryDefMnd(
    "Untrodden Land's History: DEF/MND ↑ Augment",
    2,
    requirements: <UniqueSkill>[oldHistory],
  ),
  wereHakutakuForewarning('Were-Hakutaku Forewarning', 3),
  newHistoryOfFantasyAtkMag(
    'New History of Fantasy: ATK/MAG ↑ Augment',
    2,
    requirements: <UniqueSkill>[nextHistory],
  ),
  immovable2('Immovable+', 3, requirements: <UniqueSkill>[immovable]),
  flawlessLeadership(
    'Flawless Leadership',
    4,
    requirements: <UniqueSkill>[organizedFormation],
  ),
  historiansPointer2(
    "Historian's Pointer+",
    4,
    requirements: <UniqueSkill>[historiansPointer],
  ),
  swordsDivineAutoProtection(
    "Sword's Divine Auto-Protection",
    3,
    requirements: <UniqueSkill>[swordsDivineProtectionDuration],
  ),
  countrySignSword(
    'Country Sign "Three Sacred Treasures - Sword"',
    4,
    requirements: <UniqueSkill>[swordsDivineProtection],
  ),
  jewelsDivineAutoProtection(
    "Jewel's Divine Auto-Protection",
    3,
    requirements: <UniqueSkill>[jewelsDivineProtectionDuration],
  ),
  untroddenLandsHistorySelfRecovery(
    "Untrodden Land's History: Self-Recovery",
    3,
    requirements: <UniqueSkill>[untroddenLandsHistoryDefMnd],
  ),
  organizedFormation2(
    'Organized Formation+',
    2,
    requirements: <UniqueSkill>[organizedFormation],
  ),
  alongsideMokou('Alongside Mokou', 3),
  historyAccumulationSword(
    'History Accumulation - Sword',
    4,
    requirements: <UniqueSkill>[countrySignSword],
  ),
  mirrorsDivineProtection(
    "Mirror's Divine Protection",
    3,
    requirements: <UniqueSkill>[countrySignSword, countrySignJewel],
  ),
  historyAccumulationJewel(
    'History Accumulation - Jewel',
    4,
    requirements: <UniqueSkill>[countrySignJewel],
  ),
  untroddenLandsHistory2(
    "Untrodden Land's History: POW ↑",
    2,
    requirements: <UniqueSkill>[untroddenLandsHistorySelfRecovery],
  ),
  wereHakutakuTransformation(
    'Were-Hakutaku Transformation',
    3,
    requirements: <UniqueSkill>[wereHakutakuForewarning],
  ),
  newHistoryOfFantasyFrontlineRecovery(
    'New History of Fantasy: Frontline Recovery',
    3,
    requirements: <UniqueSkill>[
      wereHakutakuForewarning,
      newHistoryOfFantasyAtkMag,
    ],
  ),
  unrestrainableUrge(
    'Unrestrainable Urge',
    3,
    requirements: <UniqueSkill>[wereHakutakuForewarning, immovable2],
  ),
  flawlessLeadership2(
    'Flawless Leadership+',
    5,
    requirements: <UniqueSkill>[organizedFormation2, flawlessLeadership],
  ),
  historiansPointer3(
    "Historian's Pointer++",
    5,
    requirements: <UniqueSkill>[historiansPointer2],
  ),
  swordsDivineAutoProtection2(
    "Sword's Divine Auto-Protection+",
    2,
    requirements: <UniqueSkill>[swordsDivineAutoProtection],
  ),
  countrySignMirror(
    'Country Sign "Three Sacred Treasures - Mirror"',
    4,
    requirements: <UniqueSkill>[
      historyAccumulationSword,
      mirrorsDivineProtection,
      historyAccumulationJewel,
    ],
  ),
  jewelsDivineAutoProtection2(
    "Jewel's Divine Auto-Protection+",
    2,
    requirements: <UniqueSkill>[jewelsDivineAutoProtection],
  ),
  legendOfGensokyo(
    'Nil History "Legend of Gensokyo"',
    4,
    requirements: <UniqueSkill>[
      untroddenLandsHistorySelfRecovery,
      wereHakutakuTransformation,
    ],
  ),
  newHistoryOfFantasy2(
    'New History of Fantasy: Damage Multiplier ↑',
    2,
    requirements: <UniqueSkill>[newHistoryOfFantasyFrontlineRecovery],
  ),
  perfectFormation(
    'Perfect Formation',
    4,
    requirements: <UniqueSkill>[organizedFormation2],
  ),
  alongsideMokou2(
    'Alongside Mokou+',
    2,
    requirements: <UniqueSkill>[alongsideMokou],
  ),
  grandHistorySword(
    'Grand History - Sword',
    3,
    requirements: <UniqueSkill>[historyAccumulationSword],
  ),
  grandHistoryJewel(
    'Grand History - Jewel',
    3,
    requirements: <UniqueSkill>[historyAccumulationJewel],
  ),
  mitoNoMitsukuni(
    'Hollyhock Sign "Mito no Mitsukuni"',
    4,
    requirements: <UniqueSkill>[
      wereHakutakuTransformation,
      newHistoryOfFantasyFrontlineRecovery,
    ],
  ),
  historiansPointer4(
    "Historian's Pointer+++",
    6,
    requirements: <UniqueSkill>[historiansPointer3],
  ),
  swordsSharedDivineAutoProtection(
    "Sword's Shared Divine Auto-Protection+",
    3,
    requirements: <UniqueSkill>[swordsDivineAutoProtection2],
  ),
  historyEatingHalfBeast(
    'History-Eating Half-Beast',
    4,
    requirements: <UniqueSkill>[
      grandHistorySword,
      countrySignMirror,
      grandHistoryJewel,
    ],
  ),
  jewelsSharedDivineAutoProtection(
    "Jewel's Shared Divine Auto-Protection+",
    3,
    requirements: <UniqueSkill>[jewelsDivineAutoProtection2],
  ),
  amaterasu(
    'Light Sign "Amaterasu"',
    5,
    requirements: <UniqueSkill>[legendOfGensokyo, mitoNoMitsukuni],
  ),
  // Doremy skills
  rulerOfDreams('Ruler of Dreams', 3),
  deepNavyRunawayDream(
    'Dream Sign "Deep Navy Runaway Dream"',
    3,
    requirements: <UniqueSkill>[rulerOfDreams],
  ),
  scarletNightmare(
    'Dream Sign "Scarlet Nightmare"',
    3,
    requirements: <UniqueSkill>[rulerOfDreams],
  ),
  rulerOfTheDreamWorld('Ruler of the Dream World', 3),
  dreamCatcher(
    'Dream Sign "Dream Catcher"',
    3,
    requirements: <UniqueSkill>[deepNavyRunawayDream],
  ),
  dreamBalloonFlight(
    'Dream Balloon Flight',
    3,
    requirements: <UniqueSkill>[rulerOfDreams],
  ),
  frighteningDebilitatingDream(
    'Frigthening Debilitating Dream',
    3,
    requirements: <UniqueSkill>[rulerOfDreams],
  ),
  astonishingDumbfoundingDream(
    'Astonishing Dumbfounding Dream',
    3,
    requirements: <UniqueSkill>[rulerOfDreams],
  ),
  indigoAnxietyDream(
    'Dream Sign "Indigo Anxiety Dream"',
    3,
    requirements: <UniqueSkill>[scarletNightmare],
  ),
  nightmareCatcher(
    'Dream Sign "Nightmare Catcher"',
    3,
    requirements: <UniqueSkill>[scarletNightmare],
  ),
  wryPotency('WRY Potency ↑', 3, requirements: <UniqueSkill>[dreamCatcher]),
  dreamCatcher2(
    'Dream Catcher: Effect ↑',
    3,
    requirements: <UniqueSkill>[dreamCatcher],
  ),
  pitchBlackCosmicDream(
    'Dream Sign "Pitch Black Cosmic Dream"',
    3,
    requirements: <UniqueSkill>[deepNavyRunawayDream],
  ),
  deepNavyRunawayDreamDreamSoulGain(
    'Deep Navy Runaway Dream: Dream Soul Gain',
    3,
    requirements: <UniqueSkill>[deepNavyRunawayDream],
  ),
  dreamSoulsUponEvasion(
    'Dream Souls Upon Evasion',
    3,
    requirements: <UniqueSkill>[
      dreamBalloonFlight,
      frighteningDebilitatingDream,
    ],
  ),
  dreamSoulsToDamageTaken(
    'Dream Souls to Damage Taken',
    3,
    requirements: <UniqueSkill>[
      frighteningDebilitatingDream,
      astonishingDumbfoundingDream,
    ],
  ),
  scarletNightmareEffect(
    'Scarlet Nightmare: Special Effect ↑',
    3,
    requirements: <UniqueSkill>[scarletNightmare],
  ),
  indigoAnxietyDreamEffect(
    'Indigo Anxiety Dream: Special Effect ↑',
    3,
    requirements: <UniqueSkill>[indigoAnxietyDream],
  ),
  nightmareCatcherEffect(
    'Nightmare Catcher: Effect ↑',
    3,
    requirements: <UniqueSkill>[nightmareCatcher],
  ),
  wryChance('WRY Chance ↑', 3, requirements: <UniqueSkill>[nightmareCatcher]),
  rulerOfTheDreamWorld2(
    'Ruler of the Dream World+',
    3,
    requirements: <UniqueSkill>[rulerOfTheDreamWorld],
  ),
  dreamCatcherDamageDealtAbsorption(
    'Dream Catcher: Damage Dealt ↑ Absorption',
    3,
    requirements: <UniqueSkill>[dreamCatcher],
  ),
  pitchBlackCosmicDreamElements(
    'Pitch-Black Cosmic Dream: Dream Souls to Elements',
    3,
    requirements: <UniqueSkill>[pitchBlackCosmicDream],
  ),
  dreamBalloonFlight2(
    'Dream Balloon Flight+',
    3,
    requirements: <UniqueSkill>[dreamBalloonFlight],
  ),
  frighteningDebilitatingDream2(
    'Frigthening Debilitating Dream+',
    3,
    requirements: <UniqueSkill>[frighteningDebilitatingDream],
  ),
  astonishingDumbfoundingDream2(
    'Astonishing Dumbfounding Dream+',
    3,
    requirements: <UniqueSkill>[astonishingDumbfoundingDream],
  ),
  ultramarineLunaticDream(
    'Moon Sign "Ultramarine Lunatic Dream"',
    3,
    requirements: <UniqueSkill>[indigoAnxietyDream],
  ),
  nightmareCatcherBuffs(
    'Nightmare Catcher: Buffs to Damage Taken ↓',
    3,
    requirements: <UniqueSkill>[nightmareCatcher],
  ),
  wryPotencyRange(
    'WRY Potency ↑: Range Expansion',
    3,
    requirements: <UniqueSkill>[wryPotency],
  ),
  dreamCatcher3(
    'Dream Catcher: Effect ↑+',
    3,
    requirements: <UniqueSkill>[dreamCatcher2],
  ),
  pitchBlackCosmicDream2(
    'Pitch-Black Cosmic Dream: Dream Souls to POW',
    3,
    requirements: <UniqueSkill>[pitchBlackCosmicDream],
  ),
  deepNavyRunawayDreamWry(
    'Deep Navy Runaway Dream: Forced WRY Affix',
    3,
    requirements: <UniqueSkill>[deepNavyRunawayDreamDreamSoulGain],
  ),
  buffsUponEvasion(
    'Buffs Upon Evasion',
    3,
    requirements: <UniqueSkill>[dreamSoulsUponEvasion],
  ),
  dreamSoulsToDamageDealt(
    'Dream Souls to Damage Dealt',
    3,
    requirements: <UniqueSkill>[dreamSoulsToDamageTaken],
  ),
  scarletNightmareEffect2(
    'Scarlet Nightmare: Special Effect ↑+',
    3,
    requirements: <UniqueSkill>[scarletNightmareEffect],
  ),
  indigoAnxietyDreamEffect2(
    'Indigo Anxiety Dream: Special Effect ↑+',
    3,
    requirements: <UniqueSkill>[indigoAnxietyDreamEffect],
  ),
  nightmareCatcherEffect2(
    'Nightmare Catcher: Effect ↑+',
    3,
    requirements: <UniqueSkill>[nightmareCatcherEffect],
  ),
  wryChance2('WRY Chance ↑+', 3, requirements: <UniqueSkill>[wryChance]),
  rulerOfTheDreamWorldShield(
    'Ruler of the Dream World: Shield Conversion',
    3,
    requirements: <UniqueSkill>[rulerOfTheDreamWorld2],
  ),
  dreamCatcherSharing(
    'Dream Catcher: Damage Dealt ↑ Sharing',
    3,
    requirements: <UniqueSkill>[dreamCatcherDamageDealtAbsorption],
  ),
  dreamExpress(
    'Super-Express "Dream Express"',
    3,
    requirements: <UniqueSkill>[pitchBlackCosmicDreamElements],
  ),
  doremyPopping(
    'Doremy Popping',
    3,
    requirements: <UniqueSkill>[dreamBalloonFlight2],
  ),
  nightmareCatcherSharing(
    'Nightmare Catcher: Damage Taken ↓ Sharing',
    3,
    requirements: <UniqueSkill>[nightmareCatcherBuffs],
  ),
  ultramarineLunaticDreamEffect(
    'Ultramarine Lunatic Dream: Special Effect ↑',
    3,
    requirements: <UniqueSkill>[ultramarineLunaticDream],
  ),
  dreamExpressRainbow(
    'Dream Express: Rainbow Fright',
    3,
    requirements: <UniqueSkill>[dreamExpress],
  ),
  deepNavyRunawayDreamWry2(
    'Deep Navy Runaway Dream: Forced WRY Affix+',
    3,
    requirements: <UniqueSkill>[deepNavyRunawayDreamWry],
  ),
  mpUponEvasion(
    'MP Upon Evasion',
    3,
    requirements: <UniqueSkill>[buffsUponEvasion],
  ),
  ultramarineLunaticDreamEffect2(
    'Ultramarine Lunatic Dream: Special Effect ↑+',
    3,
    requirements: <UniqueSkill>[
      astonishingDumbfoundingDream2,
      scarletNightmareEffect2,
      ultramarineLunaticDreamEffect,
    ],
  ),
  // Yukari skills
  meshOfLightAndDarkness('Barrier "Mesh of Light and Darkness"', 3),
  hyperactiveFlyingObject(
    'Aerial Bait "Hyperactive High Speed Flying Object"',
    3,
  ),
  meshOfLightAndDarkness2(
    'Mesh of Light and Darkness: Effect Potency ↑',
    3,
    requirements: <UniqueSkill>[meshOfLightAndDarkness],
  ),
  meshOfLightAndDarknessTurnBuff(
    'Mesh of Light and Darkness: Designated Turn Buff',
    3,
    requirements: <UniqueSkill>[meshOfLightAndDarkness],
  ),
  hyperactiveFlyingObjectTurnBuff(
    'Hyperactive High Speed Flying Object: Designated Turn Buff',
    3,
    requirements: <UniqueSkill>[hyperactiveFlyingObject],
  ),
  hyperactiveFlyingObjectFlierSlay(
    'Hyperactive High Speed Flying Object: Flier Slay',
    3,
    requirements: <UniqueSkill>[hyperactiveFlyingObject],
  ),
  yakumoHousehold('Yakumo Household', 3),
  boundaryOfWaveAndParticle('Boundary of Wave and Particle', 3),
  boundaryOfMeleeAndDanmaku(
    'Boundary of Melee and Danmaku',
    3,
    requirements: <UniqueSkill>[meshOfLightAndDarkness],
  ),
  meshOfLightAndDarknessParSpdDownSlay(
    'Mesh of Light and Darkness: PAR+SPD ↓ Slay',
    3,
    requirements: <UniqueSkill>[meshOfLightAndDarkness],
  ),
  hyperactiveFlyingObjectRow(
    'Hyperactive High Speed Flying Object: Row Attack',
    3,
    requirements: <UniqueSkill>[hyperactiveFlyingObject],
  ),
  boundaryOfRecoveryAndInjury(
    'Boundary of Recovery and Injury',
    3,
    requirements: <UniqueSkill>[hyperactiveFlyingObject],
  ),
  boundaryOfFormAndEmptiness('Boundary of Form and Emptiness', 3),
  meshOfLightAndDarknessInfliction(
    'Mesh of Light and Darkness: Infliction Chance ↑',
    3,
    requirements: <UniqueSkill>[meshOfLightAndDarknessParSpdDownSlay],
  ),
  quadrupleImperishableNightBarrier(
    'Boundary "Quadruple Imperishable Night Barrier"',
    3,
  ),
  yakumoRan('Shikigami "Yakumo Ran+"', 3),
  hyperactiveFlyingObjectGuardPierce(
    'Hyperactive High Speed Flying Object: Guard Pierce',
    3,
    requirements: <UniqueSkill>[
      hyperactiveFlyingObjectRow,
      hyperactiveFlyingObjectFlierSlay,
    ],
  ),
  boundaryOfWaveAndParticle2(
    'Boundary of Wave and Particle+',
    3,
    requirements: <UniqueSkill>[boundaryOfWaveAndParticle],
  ),
  boundaryOfMeleeAndDanmakuShare(
    'Boundary of Melee and Danmaku: 1/4 Party Share',
    3,
    requirements: <UniqueSkill>[
      boundaryOfWaveAndParticle,
      boundaryOfMeleeAndDanmaku,
    ],
  ),
  boundaryOfMeleeAndDanmaku2(
    'Boundary of Melee and Danmaku: Effect ↑',
    5,
    requirements: <UniqueSkill>[boundaryOfMeleeAndDanmaku],
  ),
  quadrupleImperishableNightBarrier2(
    'Quadruple Imperishable Night Barrier: Effect ↑',
    3,
    requirements: <UniqueSkill>[quadrupleImperishableNightBarrier],
  ),
  yakumoYukarisSpiritingAway(
    '''Evil Spirits "Yakumo Yukari's Spiriting Away"''',
    3,
    requirements: <UniqueSkill>[quadrupleImperishableNightBarrier, yakumoRan],
  ),
  yakumoRanChensStrength(
    "Yakumo Ran+: Chen's Strength",
    3,
    requirements: <UniqueSkill>[yakumoRan],
  ),
  boundaryOfRecoveryAndInjury2(
    'Boundary of Recovery and Injury: Effect ↑',
    3,
    requirements: <UniqueSkill>[boundaryOfRecoveryAndInjury],
  ),
  boundaryOfRecoveryAndInjuryShare(
    'Boundary of Recovery and Injury: 1/4 Party Share',
    2,
    requirements: <UniqueSkill>[boundaryOfFormAndEmptiness],
  ),
  boundaryOfFormAndEmptiness2(
    'Boundary of Form and Emptiness+',
    3,
    requirements: <UniqueSkill>[boundaryOfFormAndEmptiness],
  ),
  boundaryOfMeleeAndDanmakuShare2(
    'Boundary of Melee and Danmaku: 1/3 Party Share',
    2,
    requirements: <UniqueSkill>[boundaryOfMeleeAndDanmakuShare],
  ),
  danmakuBarrier(
    '''Yukari's Arcanum "Danmaku Barrier"''',
    3,
    requirements: <UniqueSkill>[
      boundaryOfMeleeAndDanmakuShare,
      boundaryOfMeleeAndDanmaku2,
    ],
  ),
  quadrupleImperishableNightBarrierOddTurn(
    'Quadruple Imperishable Night Barrier: Odd Turn Stats ↑',
    3,
    requirements: <UniqueSkill>[quadrupleImperishableNightBarrier2],
  ),
  quadrupleImperishableNightBarrierEvenTurn(
    'Quadruple Imperishable Night Barrier: Even Turn Damage Taken ↓',
    3,
    requirements: <UniqueSkill>[quadrupleImperishableNightBarrier2],
  ),
  yakumoYukarisSpiritingAwayDelay(
    "Yakumo Yukari's Spiriting Away: Delay ↓",
    2,
    requirements: <UniqueSkill>[yakumoYukarisSpiritingAway],
  ),
  yakumoRanRansStrength(
    "Yakumo Ran+: Ran's Strength",
    3,
    requirements: <UniqueSkill>[yakumoRanChensStrength],
  ),
  objectiveBarrier(
    'Barrier "Objective Barrier"',
    3,
    requirements: <UniqueSkill>[
      boundaryOfRecoveryAndInjury2,
      boundaryOfRecoveryAndInjuryShare,
    ],
  ),
  boundaryOfRecoveryAndInjuryShare2(
    'Boundary of Recovery and Injury: 1/3 Party Share',
    2,
    requirements: <UniqueSkill>[boundaryOfRecoveryAndInjuryShare],
  ),
  yakumoHousehold2(
    'Yakumo Household+',
    2,
    requirements: <UniqueSkill>[yakumoHousehold],
  ),
  boundaryOfWaveAndParticle3(
    'Boundary of Wave and Particle++',
    3,
    requirements: <UniqueSkill>[boundaryOfWaveAndParticle2],
  ),
  boundaryOfMeleeAndDanmakuShare3(
    'Boundary of Melee and Danmaku: 1/2 Party Share',
    2,
    requirements: <UniqueSkill>[
      boundaryOfWaveAndParticle,
      boundaryOfMeleeAndDanmakuShare2,
    ],
  ),
  danmakuBarrier2nTurnModulo(
    'Danmaku Barrier: 2n Turn Modulo',
    4,
    requirements: <UniqueSkill>[danmakuBarrier],
  ),
  quadrupleImperishableNightBarrierOddTurn2(
    'Quadruple Imperishable Night Barrier: Odd Turn Stats ↑+',
    3,
    requirements: <UniqueSkill>[quadrupleImperishableNightBarrierOddTurn],
  ),
  yakumoYukarisSpiritingAwayTurnsToMpCostDown(
    "Yakumo Yukari's Spiriting Away: Turns to MP Cost ↓",
    3,
    requirements: <UniqueSkill>[yakumoYukarisSpiritingAway],
  ),
  yakumoYukarisSpiritingAwayDelay2(
    "Yakumo Yukari's Spiriting Away: Delay ↓+",
    2,
    requirements: <UniqueSkill>[yakumoYukarisSpiritingAwayDelay],
  ),
  yakumoRanYakumoHouseholdsBigBrawl(
    "Yakumo Ran+: Yakumo Household's Big Brawl",
    5,
    requirements: <UniqueSkill>[yakumoRanRansStrength],
  ),
  objectiveBarrier2nTurnModulo(
    'Objective Barrier: 2n Turn Modulo',
    4,
    requirements: <UniqueSkill>[objectiveBarrier],
  ),
  boundaryOfRecoveryAndInjuryShare3(
    'Boundary of Recovery and Injury: 1/2 Party Share',
    2,
    requirements: <UniqueSkill>[
      boundaryOfRecoveryAndInjuryShare2,
      boundaryOfFormAndEmptiness,
    ],
  ),
  boundaryOfFormAndEmptiness3(
    'Boundary of Form and Emptiness++',
    3,
    requirements: <UniqueSkill>[boundaryOfFormAndEmptiness2],
  ),
  danmakuBarrierMpCostDown(
    'Danmaku Barrier: MP Cost ↓',
    3,
    requirements: <UniqueSkill>[danmakuBarrier],
  ),
  quadrupleImperishableNightBarrierEvenTurn2(
    'Quadruple Imperishable Night Barrier: Even Turn Damage Taken ↓+',
    3,
    requirements: <UniqueSkill>[
      quadrupleImperishableNightBarrierEvenTurn,
    ],
  ),
  yakumoYukarisSpiritingAwaySelfSpiritingAway(
    "Yakumo Yukari's Spiriting Away: Self-Spiriting Away",
    2,
    requirements: <UniqueSkill>[yakumoYukarisSpiritingAwayDelay2],
  ),
  objectiveBarrierMpCostDown(
    'Objective Barrier: MP Cost ↓',
    3,
    requirements: <UniqueSkill>[objectiveBarrier],
  );

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<UniqueSkill> requirements;

  const UncategorizedUniqueSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <UniqueSkill>[],
  });
}
