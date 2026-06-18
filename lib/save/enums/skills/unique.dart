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
// - (Renko) Does Eager Support roll the cleanses separately?

/// A mixin to unify all character unique skills, be they spells, passives or
/// augments
mixin UniqueSkill on Skill {
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
    youkaiBuster,
    reimuPrivileges,
    reimuPrivilegesShare,
    finalPrayer,
    finalPrayerRange,
    trueFinalPrayer,
    // Renko unique skills
    readingStars,
    knowledgeStrangeStrings,
    maryShield,
    abilityReadStars,
    abilityReadMoon,
    firCldDamage,
    wndNtrDamage,
    mysSpiDamage,
    drkPhyDamage,
  ];
}

/// Enumeration of passive skills that don't have effects that are relevant to
/// the other classes
enum PassiveSkill implements UniqueSkill {
  // Reimu passives
  hakureiProtection("Hakurei's Divine Protection", 3),
  hakureiProtection2(
    "Hakurei's Divine Protection: Effect ↑",
    2,
    requirements: <Skill>[hakureiProtection],
  ),
  hakureiProtection3(
    "Hakurei's Divine Protection: Effect ↑+",
    2,
    requirements: <Skill>[hakureiProtection2],
  ),
  hakureiProtectionRange(
    "Hakurei's Divine Protection: Range ↑",
    2,
    requirements: <Skill>[hakureiProtection3],
  ),
  turnCounterPreservation(
    'Turn Counter Preservation',
    5,
    requirements: <Skill>[hakureiProtectionRange],
  ),
  turnCounterPreservation2(
    'Turn Counter Preservation+',
    5,
    requirements: <Skill>[turnCounterPreservation],
  ),
  // Renko passives
  beaconSpecialist('Beacon Specialist', 3),
  learningListExpansion1('Learning List Expansion #1', 4),
  skill('Skill', 3);

  @override
  final String prettyName;

  @override
  final int cost;

  @override
  final List<Skill> requirements;

  const PassiveSkill(
    this.prettyName,
    this.cost, {
    this.requirements = const <Skill>[],
  });
}

enum UncategorizedUniqueSkill implements UniqueSkill {
  // Renko skills
  swiftBeacon2('Swift Beacon: Effect ↑', 3, requirements: <Skill>[swiftBeacon]),
  targetBeacon2(
    'Target Beacon: Effect ↑',
    3,
    requirements: <Skill>[targetBeacon],
  ),
  eagerSupportSelfCare(
    'Eager Support: Self-Care Reminder',
    3,
    requirements: <Skill>[eagerSupportMentalCare],
  ),
  firstAidEmergencySmoke(
    'First Aid: Emergency Smoke Treatment',
    3,
    requirements: <Skill>[firstAidTraining],
  ),
  maryKnight("Mary's Knight", 3, requirements: <Skill>[maryShield]),
  directAttackDamage('Direct Attack Damage ↑', 5),
  magicAttackDamage('Magic Attack Damage ↑', 5),
  assaultBeacon(
    'Assault Beacon',
    3,
    requirements: <Skill>[swiftBeacon, targetBeacon],
  ),
  eagerSupportDevotedHeart(
    'Eager Support: Devoted Heart',
    3,
    requirements: <Skill>[eagerSupportSelfCare],
  ),
  skillfulTreatment(
    'Skillful Treatment',
    3,
    requirements: <Skill>[firstAidEmergencySmoke],
  ),
  knowledgeStrangeStringsShield(
    'Knowledge of Strange Strings: Shield Conversion',
    3,
    requirements: <Skill>[knowledgeStrangeStrings2],
  ),
  learningListExpansion2(
    'Learning List Expansion #2',
    5,
    requirements: <Skill>[learningListExpansion1],
  ),
  firCldDamage2('FIR/CLD Damage ↑+', 3, requirements: <Skill>[firCldDamage]),
  wndNtrDamage2('WND/NTR Damage ↑+', 3, requirements: <Skill>[wndNtrDamage]),
  mysSpiDamage2('MYS/SPI Damage ↑+', 3, requirements: <Skill>[mysSpiDamage]),
  drkPhyDamage2('DRK/PHY Damage ↑+', 3, requirements: <Skill>[drkPhyDamage]),
  assaultBeaconTurnGauge(
    'Assault Beacon: Turn Gauge Increase',
    3,
    requirements: <Skill>[swiftBeacon2, assaultBeacon],
  ),
  assaultBeaconTurnConversion(
    'Assault Beacon: Turn Conversion',
    3,
    requirements: <Skill>[assaultBeacon, targetBeacon2],
  ),
  celestialStasis(
    'Celestial Stasis',
    3,
    requirements: <Skill>[abilityReadStars, abilityReadMoon],
  ),
  ailmentAttackBoost(
    'Ailment Attack Boost',
    5,
    requirements: <Skill>[firCldDamage2, directAttackDamage, wndNtrDamage2],
  ),
  buffDebuffBoost(
    'Buff & Debuff Boost',
    5,
    requirements: <Skill>[mysSpiDamage2, magicAttackDamage, drkPhyDamage2],
  ),
  assaultBeacon2(
    'Assault Beacon: Effect ↑',
    3,
    requirements: <Skill>[assaultBeaconTurnGauge],
  ),
  assaultBeaconHpLoss(
    'Assault Beacon: HP Loss ↓',
    3,
    requirements: <Skill>[assaultBeaconTurnConversion],
  ),
  celestialStasisTurnGauge(
    'Celestial Stasis: Turn Gauge Loss ↓',
    3,
    requirements: <Skill>[eagerSupportDevotedHeart, celestialStasis],
  ),
  celestialStasisTurnConversion(
    'Celestial Stasis: Turn Conversion',
    3,
    requirements: <Skill>[celestialStasis, skillfulTreatment],
  ),
  learningListExpansion3(
    'Learning List Expansion #3',
    6,
    requirements: <Skill>[learningListExpansion2],
  ),
  directAttackDamage2(
    'Direct Attack Damage ↑+',
    5,
    requirements: <Skill>[firCldDamage2, ailmentAttackBoost, buffDebuffBoost],
  ),
  learningCooldown(
    'Learning Cooldown ↓',
    5,
    requirements: <Skill>[ailmentAttackBoost, mysSpiDamage2],
  ),
  learningMpCost(
    'Learning MP Cost ↓',
    5,
    requirements: <Skill>[wndNtrDamage2, buffDebuffBoost],
  ),
  magicAttackDamage2(
    'Magic Attack Damage ↑+',
    5,
    requirements: <Skill>[ailmentAttackBoost, buffDebuffBoost, drkPhyDamage2],
  ),
  // Maribel skills
  hazyBarrierDefense('Hazy Barrier Defense', 3),
  hazyBarrierAttack('Hazy Barrier Attack', 3),
  relativePsychology('Relative Psychology Knowledge', 3),
  noviceBarrier(
    'Novice Handmade Barrier',
    3,
    requirements: <Skill>[hazyBarrierDefense],
  ),
  disorderlyBarrier(
    'Disorderly Duplex Barrier',
    3,
    requirements: <Skill>[hazyBarrierAttack],
  ),
  hazyBarrierAttackLucidification(
    'Hazy Barrier Attack: Barrier Lucidification',
    3,
    requirements: <Skill>[hazyBarrierAttack],
  ),
  boundaryManipulation(
    'Boundary Manipulation',
    3,
    requirements: <Skill>[relativePsychology],
  ),
  noviceBarrierRecovery(
    'Novice Handmade Barrier: Recovery Augment',
    3,
    requirements: <Skill>[noviceBarrier],
  ),
  noviceBarrier2(
    'Novice Handmade Barrier: Boost ↑',
    3,
    requirements: <Skill>[noviceBarrier],
  ),
  disorderlyBarrierThirdLayer(
    'Disorderly Duplex Barrier: Third Layer',
    3,
    requirements: <Skill>[disorderlyBarrier],
  ),
  boundaryAnchoring(
    'Boundary Anchoring',
    3,
    requirements: <Skill>[boundaryManipulation],
  ),
  abilitySeeBarriers(
    'Ability to See Barriers',
    3,
    requirements: <Skill>[relativePsychology],
  ),
  relativePsychologySecrets(
    'Relative Psychology Secrets',
    3,
    requirements: <Skill>[relativePsychology],
  ),
  abilityUnbridled('Ability Unbridled', 3),
  // Copies from focus_reaction.dart
  //quickCharge('Quick Charge', 3),
  renkosEyes("Renko's Eyes", 3),
  noviceBarrierRecovery2(
    'Novice Handmade Barrier: Recovery ↑',
    3,
    requirements: <Skill>[noviceBarrierRecovery],
  ),
  noviceBarrier3(
    'Novice Handmade Barrier: Boost ↑+',
    3,
    requirements: <Skill>[noviceBarrier2],
  ),
  hazyBarrierAttackSpi(
    'Hazy Barrier Attack: SPI Augment',
    4,
    requirements: <Skill>[
      disorderlyBarrierThirdLayer,
      hazyBarrierAttackLucidification,
    ],
  ),
  overflowingAnomalousPower(
    'Overflowing Anomalous Power',
    3,
    requirements: <Skill>[abilitySeeBarriers],
  ),
  abilityFiddleBarriers(
    'Ability to Fiddle with Barriers',
    3,
    requirements: <Skill>[abilitySeeBarriers],
  ),
  abilityUnbridledGuardPierce(
    'Ability Unbridled: Guard Pierce',
    3,
    requirements: <Skill>[abilityUnbridled],
  ),
  chaosBarrier(
    'Chaos Barrier',
    3,
    requirements: <Skill>[noviceBarrier3, disorderlyBarrierThirdLayer],
  ),
  disorderlyBarrierFourthLayer(
    'Disorderly Duplex Barrier: Fourth Layer',
    3,
    requirements: <Skill>[disorderlyBarrierThirdLayer],
  ),
  hazyBuffAbsorption(
    'Hazy Buff Absorption',
    5,
    requirements: <Skill>[hazyBarrierAttackSpi, overflowingAnomalousPower],
  ),
  abilityUnderstandBoundaries(
    'Ability to Understand Boundaries',
    3,
    requirements: <Skill>[abilityFiddleBarriers],
  ),
  relativePsychologyMastery(
    'Relative Psychology Mastery',
    5,
    requirements: <Skill>[relativePsychologySecrets],
  ),
  abilityUnbridledPowerControl(
    'Ability Unbridled: Power Control',
    3,
    requirements: <Skill>[abilityUnbridled],
  ),
  // Copies from focus_reaction.dart
  //focusedRecitation(
  //  'Focused Recitation',
  //  3,
  //  requirements: <Skill>[quickCharge],
  //),
  chaosBarrierBoundary(
    'Chaos Barrier: Boundary Between Chaos and Order',
    4,
    requirements: <Skill>[chaosBarrier],
  ),
  hazyMoonBarrier(
    'Hazy Moon Barrier',
    3,
    requirements: <Skill>[hazyBarrierAttackSpi],
  ),
  overflowingAnomalousPowerAnomaly(
    'Overflowing Anomalous Power: Menacing Anomaly',
    3,
    requirements: <Skill>[overflowingAnomalousPower],
  ),
  abilityUnbridledGuardPierce2(
    'Ability Unbridled: Guard Pierce+',
    3,
    requirements: <Skill>[abilityUnbridledGuardPierce],
  ),
  // Copies from focus_reaction.dart
  //quickCharge2('Quick Charge+', 2, requirements: <Skill>[quickCharge]),
  noviceBarrierKnowledge(
    "Novice Handmade Barrier: Dr. Latency's Knowledge",
    5,
    requirements: <Skill>[noviceBarrierRecovery2, noviceBarrier3],
  ),
  chaosBarrierDoubleBoost(
    'Chaos Barrier: Double Boost',
    4,
    requirements: <Skill>[chaosBarrier],
  ),
  disorderlyBarrierExpansion(
    'Disorderly Duplex Barrier: Expansion',
    3,
    requirements: <Skill>[disorderlyBarrierFourthLayer],
  ),
  boundaryFantasyReality(
    'Boundary Between Fantasy and Reality',
    5,
    requirements: <Skill>[
      abilityUnderstandBoundaries,
      relativePsychologyMastery,
    ],
  ),
  abilityUnbridledPowerDevelopment(
    'Ability Unbridled: Power Development',
    3,
    requirements: <Skill>[abilityUnbridledGuardPierce],
  ),
  renkosPartner("Renko's Partner", 3, requirements: <Skill>[renkosEyes]),
  maryMagician(
    'Mary the Magician',
    6,
    requirements: <Skill>[
      disorderlyBarrierExpansion,
      hazyMoonBarrier,
      hazyBuffAbsorption,
    ],
  ),
  overflowingAnomalousPowerFearsome(
    'Overflowing Anomalous Power: Fearsome Anomalous Avatar',
    3,
    requirements: <Skill>[overflowingAnomalousPowerAnomaly],
  ),
  overflowingAnomalousPowerBudding(
    'Overflowing Anomalous Power: Budding of Latent Power',
    4,
    requirements: <Skill>[overflowingAnomalousPowerAnomaly],
  ),
  abilityUnbridledPowerAwakening(
    'Ability Unbridled: Power Awakening',
    4,
    requirements: <Skill>[abilityUnbridledPowerDevelopment],
  ),
  allEncompassingGuardPierce(
    'All-Encompassing Guard Pierce',
    3,
    requirements: <Skill>[abilityUnbridledGuardPierce, quickCharge2],
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
    requirements: <Skill>[blossomingLightOrb],
  ),
  combo2('C-C-Combo', 2, requirements: <Skill>[combo]),
  mountainBreakingCannon('Flower Sign "Mountain-Breaking Cannon"', 3),
  qigongEnvelopment('Qigong Envelopment', 3),
  restorativeQigongAilmentRecovery(
    'Restorative Qigong: Ailment Recovery Augment',
    2,
    requirements: <Skill>[restorativeQigong],
  ),
  colorfulRain('Colorful Rain', 3, requirements: <Skill>[restorativeQigong]),
  initialQigongGain('Initial Qigong Gain', 3),
  gatekeepersDuty("Gatekeeper's Duty", 3),
  qiCrestBlossomingLightOrbQigongGain(
    'Qi Crest Blossoming Light Orb: Qigong Gain',
    2,
    requirements: <Skill>[qiCrestBlossomingLightOrb],
  ),
  directAttackCounter('Direct Attack Counter', 4),
  mountainBreakingCannonQigongGain(
    'Mountain-Breaking Cannon: Qigong Gain',
    3,
    requirements: <Skill>[mountainBreakingCannon],
  ),
  painToQigong('Pain to Qigong', 4, requirements: <Skill>[qigongEnvelopment]),
  qigongToStats('Qigong to Stats', 4, requirements: <Skill>[qigongEnvelopment]),
  parSlay('PAR Slay', 3),
  colorfulRainQigongGain(
    'Colorful Rain: Qigong Gain',
    2,
    requirements: <Skill>[colorfulRain],
  ),
  qiCrestBlossomingLightOrbParAffix(
    'Qi Crest Blossoming Light Orb: PAR Affix',
    2,
    requirements: <Skill>[qiCrestBlossomingLightOrb],
  ),
  qiCrestStarPulseShot(
    'Star Qi "Qi Crest Star Pulse Shot"',
    3,
    requirements: <Skill>[qiCrestBlossomingLightOrbQigongGain],
  ),
  mountainBreakingCannon2(
    'Mountain-Breaking Cannon: POW ↑',
    2,
    requirements: <Skill>[
      mountainBreakingCannonQigongGain,
      directAttackCounter,
    ],
  ),
  qiCrestMountainBreakingCannon(
    'Flower Qi "Qi Crest Mountain-Breaking Cannon"',
    4,
    requirements: <Skill>[mountainBreakingCannonQigongGain],
  ),
  qigongEnvelopment2(
    'Qigong Envelopment: Qigong Gain ↑',
    3,
    requirements: <Skill>[qigongEnvelopment],
  ),
  qigongFromParFoes(
    'Qigong From PAR-Afflicted Foes',
    5,
    requirements: <Skill>[restorativeQigongAilmentRecovery],
  ),
  parRemovalDown('PAR Removal Chance ↓', 2, requirements: <Skill>[parSlay]),
  initialQigongGain2(
    'Initial Qigong Gain+',
    2,
    requirements: <Skill>[colorfulRainQigongGain, initialQigongGain],
  ),
  qiCrestBlossomingLightOrb2(
    'Qi Crest Blossoming Light Orb: POW ↑',
    3,
    requirements: <Skill>[qiCrestBlossomingLightOrbQigongGain],
  ),
  directAttackCounter2(
    'Direct Attack Counter+',
    2,
    requirements: <Skill>[directAttackCounter],
  ),
  mountainBreakingCannonDelay(
    'Mountain-Breaking Cannon: Delay ↓',
    2,
    requirements: <Skill>[mountainBreakingCannonQigongGain],
  ),
  painToQigong2('Pain to Qigong+', 3, requirements: <Skill>[painToQigong]),
  parSlay2('PAR Slay+', 2, requirements: <Skill>[parSlay]),
  colorfulRainQigongRecoveryUp(
    'Colorful Rain: Qigong Recovery ↑',
    2,
    requirements: <Skill>[colorfulRainQigongGain],
  ),
  focusedGuard2('Focused Guard+', 2, requirements: <Skill>[focusedGuard]),
  bondsScarletDevilMansion2(
    'Bonds of the Scarlet Devil Mansion+',
    2,
    requirements: <Skill>[bondsScarletDevilMansion],
  ),
  qiCrestBlossomingLightOrbParBoost(
    'Qi Crest Blossoming Light Orb: PAR Boost',
    3,
    requirements: <Skill>[
      qiCrestBlossomingLightOrbParAffix,
      qiCrestBlossomingLightOrb2,
    ],
  ),
  qiCrestStarPulseShotQigongParAffix(
    'Qi Crest Star Pulse Shot: Qigong PAR Affix',
    3,
    requirements: <Skill>[qiCrestStarPulseShot],
  ),
  mountainBreakingCannon3(
    'Mountain-Breaking Cannon: POW ↑+',
    2,
    requirements: <Skill>[mountainBreakingCannon2, mountainBreakingCannonDelay],
  ),
  masterfulMountainBreakingCannon(
    'Ultimate Flower "Masterful Mountain-Breaking Cannon"',
    4,
    requirements: <Skill>[qiCrestMountainBreakingCannon],
  ),
  qigongEnvelopment3(
    'Qigong Envelopment: Qigong Gain ↑+',
    3,
    requirements: <Skill>[qigongEnvelopment2],
  ),
  masterfulQigongEnvelopment(
    'Masterful Qigong Envelopment',
    5,
    requirements: <Skill>[qigongEnvelopment2, qigongFromParFoes],
  ),
  parRemovalDown2(
    'PAR Removal Chance ↓+',
    2,
    requirements: <Skill>[parRemovalDown],
  ),
  initialQigongGain3(
    'Initial Qigong Gain++',
    2,
    requirements: <Skill>[initialQigongGain2],
  ),
  gatekeepersDuty2(
    "Gatekeeper's Duty+",
    2,
    requirements: <Skill>[gatekeepersDuty],
  ),
  directAttackCounter3(
    'Direct Attack Counter++',
    2,
    requirements: <Skill>[directAttackCounter2],
  ),
  mountainBreakingCannonQigongGain2(
    'Mountain-Breaking Cannon: Qigong Gain+',
    2,
    requirements: <Skill>[mountainBreakingCannonDelay],
  ),
  painToQigong3('Pain to Qigong++', 3, requirements: <Skill>[painToQigong2]),
  jiQigongResultsTraining(
    'Ji Qigong: Results of Training',
    3,
    requirements: <Skill>[masterfulQigongEnvelopment],
  ),
  jiQigongMuscleSolstice(
    'Ji Qigong: Muscle Solstice',
    3,
    requirements: <Skill>[masterfulQigongEnvelopment, parRemovalDown2],
  ),
  bondsScarletDevilMansion3(
    'Bonds of the Scarlet Devil Mansion++',
    2,
    requirements: <Skill>[bondsScarletDevilMansion2],
  ),
  masterfulEarthMovingStarPulseShot(
    'Ultimate Star "Masterful Earth-Moving Star Pulse Shot"',
    5,
    requirements: <Skill>[qiCrestStarPulseShotQigongParAffix],
  ),
  masterfulMountainBreakingCannonGuardPierce(
    'Masterful Mountain-Breaking Cannon: Guard Pierce',
    3,
    requirements: <Skill>[masterfulMountainBreakingCannon, painToQigong3],
  ),
  jiQigongCulminationTraining(
    'Ji Qigong: Culmination of Training',
    3,
    requirements: <Skill>[painToQigong, jiQigongResultsTraining],
  ),
  jiQigong2(
    'Ji Qigong: Duration ↑',
    2,
    requirements: <Skill>[masterfulQigongEnvelopment],
  ),
  // Alice skills
  manipulatePuppet('Puppeteer Sign "Manipulate Puppet"', 3),
  artfulSacrifice('Magic Sign "Artful Sacrifice"', 3),
  shanghaiDolls('Malediction "Magically Luminous Shanghai Dolls"', 3),
  tripwire('Focus Power "Tripwire"', 3),
  artfulSacrificeAcc(
    'Artful Sacrifice: ACC Modifier ↑',
    3,
    requirements: <Skill>[artfulSacrifice],
  ),
  artfulSacrificeGunpowder(
    'Artful Sacrifice: Gunpowder-Lobbing Witch',
    3,
    requirements: <Skill>[artfulSacrifice],
  ),
  shanghaiDollsHvy(
    'Magically Luminous Shanghai Dolls: HVY Affix',
    3,
    requirements: <Skill>[shanghaiDolls],
  ),
  inorganicExpert('Inorganic Expert', 3),
  manipulatePuppet2(
    'Manipulate Puppet: POW ↑',
    3,
    requirements: <Skill>[manipulatePuppet],
  ),
  mercilessPursuit(
    'Merciless Pursuit',
    3,
    requirements: <Skill>[manipulatePuppet],
  ),
  hangedHouraiDolls(
    'Malediction "Hanged Hourai Dolls"',
    3,
    requirements: <Skill>[shanghaiDolls],
  ),
  dollGuard('Doll Guard', 3),
  inorganicExpert2(
    'Inorganic Expert+',
    3,
    requirements: <Skill>[inorganicExpert],
  ),
  // Copies from focus_reaction.dart
  //quickCharge('Quick Charge', 3),
  mAliceCannonAlice('MAlice Cannon (Alice)', 3),
  manipulatePuppetShanghaiOption(
    'Manipulate Puppet: Shanghai Dolls Option',
    3,
    requirements: <Skill>[manipulatePuppet2],
  ),
  manipulatePuppetDuration(
    'Manipulate Puppet: Duration ↑',
    3,
    requirements: <Skill>[manipulatePuppet2],
  ),
  tripwireWireArt('Tripwire: Wire Art', 3, requirements: <Skill>[tripwire]),
  tripwire2(
    'Tripwire: Damage Multiplier ↑',
    3,
    requirements: <Skill>[tripwire],
  ),
  soldierOfCross(
    'Sword Sign "Soldier of Cross"',
    3,
    requirements: <Skill>[inorganicExpert],
  ),
  efficientPuppeteering(
    'Efficient Puppeteering',
    3,
    requirements: <Skill>[quickCharge, mAliceCannonAlice],
  ),
  manipulatePuppetHouraiOption(
    'Manipulate Puppet: Hanged Hourai Dolls Option',
    3,
    requirements: <Skill>[manipulatePuppetShanghaiOption],
  ),
  mercilessPursuit2(
    'Merciless Pursuit+',
    2,
    requirements: <Skill>[mercilessPursuit],
  ),
  littleLegion('War Sign "Little Legion"', 3, requirements: <Skill>[tripwire2]),
  tripwireAilmentBoost(
    'Tripwire: Ailment Boost',
    3,
    requirements: <Skill>[tripwire2],
  ),
  suicideSquad(
    'Suicide Squad',
    4,
    requirements: <Skill>[tripwire, artfulSacrifice, hangedHouraiDolls],
  ),
  dollCrusader('Doll Crusader', 3, requirements: <Skill>[dollGuard]),
  inorganicExpertDamageTaken(
    'Inorganic Expert: Damage Taken ↓ Augment',
    3,
    requirements: <Skill>[inorganicExpert2],
  ),
  manipulatePuppetMpCut(
    'Manipulate Puppet: MP Cut',
    3,
    requirements: <Skill>[manipulatePuppetShanghaiOption],
  ),
  manipulatePuppetDuration2(
    'Manipulate Puppet: Duration ↑+',
    3,
    requirements: <Skill>[manipulatePuppetDuration],
  ),
  tripwireHighWireArt(
    'Tripwire: Highly-Skilled Wire Art',
    3,
    requirements: <Skill>[tripwireWireArt],
  ),
  littleLegionDamageRange(
    'Little Legion: Damage Range ↑',
    3,
    requirements: <Skill>[littleLegion],
  ),
  suicideSquadSize(
    'Suicide Squad: Squad Size ↑',
    3,
    requirements: <Skill>[suicideSquad],
  ),
  returnInanimateness('Magic Puppeteering "Return Inanimateness"', 3),
  dollGuard2('Doll Guard+', 3, requirements: <Skill>[dollCrusader]),
  manipulatePuppetTripwireOption(
    'Manipulate Puppet: Tripwire Option',
    3,
    requirements: <Skill>[manipulatePuppetHouraiOption],
  ),
  ailmentChance(
    'Ailment Chance ↑',
    5,
    requirements: <Skill>[mercilessPursuit2],
  ),
  littleLegionAtkAffix(
    'Little Legion: ATK ↓ Affix',
    3,
    requirements: <Skill>[littleLegion],
  ),
  returnInanimatenessBombLobbing(
    'Return Inanimateness: Bomb-Lobbing Witch',
    3,
    requirements: <Skill>[returnInanimateness],
  ),
  dollCrusader2('Doll Crusader+', 3, requirements: <Skill>[dollCrusader]),
  guardianMarionette(
    'Knight Sign "Guardian Marionette"',
    3,
    requirements: <Skill>[soldierOfCross],
  ),
  // Copies from focus_reaction.dart
  //quickCharge2(
  //  'Quick Charge+',
  //  2,
  //  requirements: <Skill>[quickCharge],
  //),
  mAliceCannonAlice2(
    'MAlice Cannon (Alice)+',
    3,
    requirements: <Skill>[mAliceCannonAlice],
  ),
  manipulatePuppetOptionChance(
    'Manipulate Puppet: Option Chance ↑',
    3,
    requirements: <Skill>[manipulatePuppetMpCut],
  ),
  dollsWar(
    '''War Puppeteering "Dolls' War"''',
    3,
    requirements: <Skill>[littleLegionDamageRange, suicideSquadSize],
  ),
  suicideSquadSize2(
    'Suicide Squad: Squad Size ↑+',
    3,
    requirements: <Skill>[suicideSquadSize],
  ),
  efficientPuppeteering2(
    'Efficient Puppeteering+',
    5,
    requirements: <Skill>[
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
    requirements: <Skill>[kappaWaterfall],
  ),
  kappaWaterfallGadgetCooling(
    "Kappa's Illusionary Waterfall: Gadget-Cooling Feature",
    3,
    requirements: <Skill>[kappaWaterfall],
  ),
  portableUtilityDevice('Portable Utility Device', 3),
  kappaWaterfallHeatPump(
    "Kappa's Illusionary Waterfall: Heat Pump",
    3,
    requirements: <Skill>[kappaWaterfallDef],
  ),
  abilityManipulateWater('Ability to Manipulate Water', 3),
  thrillingQuenchHandling(
    'Thrilling Quench Handling',
    3,
    requirements: <Skill>[kappaWaterfallGadgetCooling],
  ),
  piercingExtendingArm(
    '''Great Kappa "Piercing Exteeeending Aaaaarm"''',
    3,
    requirements: <Skill>[extendingArm],
  ),
  opticalCamouflage('Optics "Optical Camouflage"', 3),
  exhaustUtilizationSystem(
    'Exhaust Utilization System',
    3,
    requirements: <Skill>[portableUtilityDevice],
  ),
  properMaintenance(
    'Proper Maintenance',
    3,
    requirements: <Skill>[basicMaintenance],
  ),
  kappaObservations2(
    'Observations of a Kappa+',
    3,
    requirements: <Skill>[kappaObservations],
  ),
  overdrive('Overdrive', 3),
  kappaWaterfallImprovedCooling(
    "Kappa's Illusionary Waterfall: Improved Cooling",
    3,
    requirements: <Skill>[abilityManipulateWater, kappaWaterfallGadgetCooling],
  ),
  accelDrive('Accel Drive', 3, requirements: <Skill>[thrillingQuenchHandling]),
  dividingEdge(
    'River Sign "Dividing Edge"',
    3,
    requirements: <Skill>[opticalCamouflage],
  ),
  exhaustIncinerator('Explosive Flames "Exhaust Incinerator"', 3),
  portableUtilityDevice2(
    'Portable Utility Device: Effect ↑',
    3,
    requirements: <Skill>[portableUtilityDevice],
  ),
  exhaustDefensiveSystem(
    'Exhaust Defensive System',
    3,
    requirements: <Skill>[exhaustUtilizationSystem],
  ),
  exhaustPropulsionSystem(
    'Exhaust Propulsion System',
    3,
    requirements: <Skill>[exhaustUtilizationSystem],
  ),
  kappaWaterfallAcidicRecycling(
    "Kappa's Illusionary Waterfall: Acidic Wastewater Recycling",
    3,
    requirements: <Skill>[kappaWaterfallHeatPump],
  ),
  abilityManipulateWater2(
    'Ability to Manipulate Water+',
    3,
    requirements: <Skill>[abilityManipulateWater],
  ),
  superHighHeatQuenchHandling(
    'Super High-Heat Quench Handling',
    3,
    requirements: <Skill>[thrillingQuenchHandling],
  ),
  superScope3D(
    'Super Scope 3D',
    3,
    requirements: <Skill>[piercingExtendingArm],
  ),
  opticalCamouflageBoostGain(
    'Optical Camouflage: Boost Gain',
    3,
    requirements: <Skill>[opticalCamouflage],
  ),
  autoCooling('Auto-Cooling', 3),
  portableUtilityDeviceScale(
    'Portable Utility Device: Scale Improvements',
    3,
    requirements: <Skill>[portableUtilityDevice2],
  ),
  efficientExhaustUtilizationSystem(
    'Efficient Exhaust Utilization System',
    3,
    requirements: <Skill>[exhaustUtilizationSystem],
  ),
  adeptMaintenance(
    'Adept Maintenance',
    3,
    requirements: <Skill>[properMaintenance],
  ),
  kappaObservationsShieldConversion(
    'Observations of a Kappa: Shield Conversion',
    3,
    requirements: <Skill>[kappaObservations2],
  ),
  megadrive(
    'Megadrive',
    4,
    requirements: <Skill>[overdrive, abilityManipulateWater2],
  ),
  kappaWaterfallImprovedCooling2(
    "Kappa's Illusionary Waterfall: Improved Cooling+",
    3,
    requirements: <Skill>[
      abilityManipulateWater2,
      kappaWaterfallImprovedCooling,
    ],
  ),
  superScope3DImprovedControl(
    'Super Scope 3D: Improved Firing Control',
    3,
    requirements: <Skill>[superScope3D],
  ),
  highOpticalCamouflage(
    'Optics "High-Optical Camouflage"',
    3,
    requirements: <Skill>[opticalCamouflageBoostGain],
  ),
  exhaustIncineratorRowModification(
    'Exhaust Incinerator: Row Modification',
    3,
    requirements: <Skill>[exhaustIncinerator],
  ),
  portableUtilityDevicePortability(
    'Portable Utility Device: Portability Improvements',
    3,
    requirements: <Skill>[portableUtilityDeviceScale],
  ),
  efficientExhaustDefensiveSystem(
    'Efficent Exhaust Defensive System',
    3,
    requirements: <Skill>[exhaustUtilizationSystem],
  ),
  efficientExhaustPropulsionSystem(
    'Efficient Exhaust Propulsion System',
    3,
    requirements: <Skill>[exhaustUtilizationSystem],
  ),
  hiAccelDrive(
    'Hi-Accel Drive',
    3,
    requirements: <Skill>[superHighHeatQuenchHandling, accelDrive],
  ),
  improvedAutoCooling(
    'Improved Auto-Cooling',
    3,
    requirements: <Skill>[
      exhaustIncineratorRowModification,
      autoCooling,
      portableUtilityDevicePortability,
    ],
  ),
  lastOne(
    'Last One',
    3,
    requirements: <Skill>[
      efficientExhaustDefensiveSystem,
      efficientExhaustUtilizationSystem,
      efficientExhaustPropulsionSystem,
    ],
  ),
  gigadrive(
    'Gigadrive',
    5,
    requirements: <Skill>[kappaObservationsShieldConversion, megadrive],
  ),
  superScope3DImprovedControl2(
    'Super Scope 3D: Improved Firing Control+',
    3,
    requirements: <Skill>[superScope3DImprovedControl],
  ),
  superHighHeatIncinerator(
    'Raging Flames "Super High-Heat Incinerator"',
    3,
    requirements: <Skill>[
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
    requirements: <Skill>[tenguWind],
  ),
  tenguWind2("Tengu's Wind: Effect ↑", 3, requirements: <Skill>[tenguWind]),
  sarutahikosGuidance(
    "Squall 'Sarutahiko's Guidance'",
    3,
    requirements: <Skill>[tenguWind],
  ),
  extraStep('Extra Step', 3),
  evasiveAction('Evasive Action', 3),
  abilityManipulateWind2(
    'Ability to Manipulate Wind+',
    3,
    requirements: <Skill>[abilityManipulateWind],
  ),
  galeFan('Gale Fan', 3, requirements: <Skill>[gustFan]),
  windGodGirlSpd(
    'Wind God Girl: SPD ↑ Augment',
    3,
    requirements: <Skill>[windGodGirl],
  ),
  windGodGirlEva(
    'Wind God Girl: EVA ↑ Augment',
    3,
    requirements: <Skill>[windGodGirl],
  ),
  dashingGrace('Dashing Grace', 3, requirements: <Skill>[tenguWind]),
  teachingsGensokyosFastest2(
    "Teachings of Gensokyo's Fastest+",
    3,
    requirements: <Skill>[teachingsGensokyosFastest],
  ),
  tenguOfGales(
    'Tengu of Gales',
    3,
    requirements: <Skill>[galeFan, windGodGirlSpd],
  ),
  peerlessWindGod('Peerless Wind God', 3, requirements: <Skill>[windGodGirl]),
  guidepostDivineGrandsonsAdvent2(
    "Guidepost for the Divine Grandson's Advent: Effect ↑",
    3,
    requirements: <Skill>[guidepostDivineGrandsonsAdvent],
  ),
  sarutahikosTwinklingEyes(
    "Sarutahiko's Guidance: Sarutahiko's Twinkling Eyes",
    3,
    requirements: <Skill>[sarutahikosGuidance],
  ),
  extraStep2('Extra Step+', 3, requirements: <Skill>[extraStep]),
  evasiveAction2('Evasive Action+', 3, requirements: <Skill>[evasiveAction]),
  abilityManipulateWindBoost(
    'Ability to Manipulate Wind: Boost Conversion',
    3,
    requirements: <Skill>[abilityManipulateWind2],
  ),
  tempestFan(
    'Tempest Fan',
    3,
    requirements: <Skill>[abilityManipulateWind2, galeFan],
  ),
  peerlessWindGodSpd(
    'Peerless Wind God: SPD ↑ Augment',
    3,
    requirements: <Skill>[peerlessWindGod],
  ),
  peerlessWindGodEva(
    'Peerless Wind God: EVA ↑ Augment',
    3,
    requirements: <Skill>[peerlessWindGod],
  ),
  divineGrandsonsAdvent(
    '''Blockade Sign "Divine Grandson's Advent"''',
    3,
    requirements: <Skill>[guidepostDivineGrandsonsAdvent2, dashingGrace],
  ),
  gracefulEvasion('Graceful Evasion', 3, requirements: <Skill>[dashingGrace]),
  nanaatasRedNose(
    "Sarutahiko's Guidance: Nanaata's Red Nose",
    3,
    requirements: <Skill>[sarutahikosTwinklingEyes],
  ),
  teachingsGensokyosFastest3(
    "Teachings of Gensokyo's Fastest++",
    3,
    requirements: <Skill>[teachingsGensokyosFastest2],
  ),
  agility2('Agility+', 3, requirements: <Skill>[agility]),
  windGodAvatar('Wind God Avatar', 3, requirements: <Skill>[peerlessWindGod]),
  dashingGrace2('Dashing Grace+', 3, requirements: <Skill>[dashingGrace]),
  gracefulWingwork('Graceful Wingwork', 3, requirements: <Skill>[dashingGrace]),
  extraStep3('Extra Step++', 3, requirements: <Skill>[extraStep2]),
  evasiveAction3('Evasive Action++', 3, requirements: <Skill>[evasiveAction2]),
  tenguOfTempests(
    'Tengu of Tempests',
    3,
    requirements: <Skill>[abilityManipulateWindBoost, tempestFan],
  ),
  flutteringYoukaiFan(
    'Fluttering Youkai Fan',
    3,
    requirements: <Skill>[abilityManipulateWindBoost, tempestFan],
  ),
  clothedInWindstorms(
    'Clothed in Windstorms',
    3,
    requirements: <Skill>[windGodAvatar],
  ),
  crossroadsOfHeaven(
    'Crossroad Sign "Crossroads of Heaven"',
    3,
    requirements: <Skill>[windGodAvatar, divineGrandsonsAdvent],
  ),
  shiningAdventPath(
    "Divine Grandson's Advent: Shining Advent Path",
    3,
    requirements: <Skill>[divineGrandsonsAdvent],
  ),
  gracefulEvasion2(
    'Graceful Evasion+',
    3,
    requirements: <Skill>[gracefulEvasion],
  ),
  guidingOnesBack(
    "Sarutahiko's Guidance: Guiding One's Back",
    3,
    requirements: <Skill>[nanaatasRedNose],
  ),
  teachingsGensokyosFastest4(
    "Teachings of Gensokyo's Fastest+++",
    3,
    requirements: <Skill>[teachingsGensokyosFastest3],
  ),
  crossroadsOfHeavenEyesOfHeaven(
    'Crossroads of Heaven: Eyes of Heaven',
    3,
    requirements: <Skill>[flutteringYoukaiFan, crossroadsOfHeaven],
  ),
  crossroadsOfHeavenSoaringEightBoatJump(
    'Crossroads of Heaven: Soaring Eight-Boat Jump',
    3,
    requirements: <Skill>[crossroadsOfHeaven, shiningAdventPath],
  ),
  takingFantasyByStorm(
    'Taking Fantasy by Storm',
    3,
    requirements: <Skill>[guidepostDivineGrandsonsAdvent2, dashingGrace],
  ),
  gracefulWingwork2(
    'Graceful Wingwork+',
    3,
    requirements: <Skill>[gracefulWingwork],
  ),
  // Patchouli skills
  philosopherStone("Philosopher's Stone", 3),
  agniShine('Fire Sign "Agni Shine"', 3),
  gingerGust('Metal Earth Sign "Ginger Gust"', 3),
  metalFatigue('Metal Sign "Metal Fatigue"', 3),
  philosopherStoneInitiative(
    "Philosopher's Stone - Initiative Type",
    3,
    requirements: <Skill>[philosopherStone],
  ),
  philosopherStoneSustained(
    "Philosopher's Stone - Sustained Type",
    3,
    requirements: <Skill>[philosopherStone],
  ),
  fundamentalMagicImprovements(
    'Fundamental Magic Improvements',
    3,
    requirements: <Skill>[philosopherStone],
  ),
  agniShine2(
    'Agni Shine: POW ↑',
    3,
    requirements: <Skill>[agniShine],
  ),
  princessUndine('Water Sign "Princess Undine"', 3),
  gingerGust2(
    'Ginger Gust: POW ↑',
    3,
    requirements: <Skill>[gingerGust],
  ),
  satelliteHimawari('Moon Wood Sign "Satellite Himawari"', 3),
  metalFatigue2(
    'Metal Fatigue: POW ↑',
    3,
    requirements: <Skill>[metalFatigue],
  ),
  philosopherStoneProtective(
    "Philosopher's Stone - Protective Type",
    3,
    requirements: <Skill>[
      philosopherStoneInitiative,
      philosopherStoneSustained,
    ],
  ),
  philosopherStoneHighLevel(
    "Philosopher's Stone - High-Level Elements",
    3,
    requirements: <Skill>[philosopherStone],
  ),
  agniShineAtk(
    'Agni Shine: ATK ↑ Augment',
    3,
    requirements: <Skill>[agniShine2],
  ),
  phlogisticRain(
    'Water Fire Sign "Phlogistic Rain"',
    3,
    requirements: <Skill>[agniShine2],
  ),
  princessUndine2(
    'Princess Undine: POW ↑',
    3,
    requirements: <Skill>[princessUndine],
  ),
  gingerGustSpd(
    'Ginger Gust: SPD ↑ Augment',
    3,
    requirements: <Skill>[gingerGust2],
  ),
  sylphyHorn(
    'Wood Sign "Sylphy Horn"',
    3,
    requirements: <Skill>[gingerGust],
  ),
  satelliteHimawari2(
    'Satellite Himawari: POW ↑',
    3,
    requirements: <Skill>[satelliteHimawari],
  ),
  metalFatigueDef(
    'Metal Fatigue: DEF ↑ Augment',
    3,
    requirements: <Skill>[metalFatigue2],
  ),
  silverDragon(
    'Metal Sign "Silver Dragon"',
    3,
    requirements: <Skill>[metalFatigue],
  ),
  initiativeTypeImproved(
    'Initiative Type - Improved Quantity',
    3,
    requirements: <Skill>[philosopherStoneInitiative],
  ),
  sustainedTypeImproved(
    'Sustained Type - Improved Quantity',
    3,
    requirements: <Skill>[philosopherStoneSustained],
  ),
  phlogisticRain2(
    'Phlogistic Rain: POW ↑',
    3,
    requirements: <Skill>[phlogisticRain],
  ),
  princessUndineMag(
    'Princess Undine: MAG ↑ Augment',
    3,
    requirements: <Skill>[princessUndine2],
  ),
  mercuryPoison(
    'Metal Water Sign "Mercury Poison"',
    3,
    requirements: <Skill>[princessUndine],
  ),
  sylphyHorn2(
    'Sylphy Horn: POW ↑',
    3,
    requirements: <Skill>[sylphyHorn],
  ),
  satelliteHimawariMnd(
    'Satellite Himawari: MND ↑ Augment',
    3,
    requirements: <Skill>[satelliteHimawari2],
  ),
  forestBlaze(
    'Wood Fire Sign "Forest Blaze"',
    3,
    requirements: <Skill>[satelliteHimawari],
  ),
  silverDragon2(
    'Silver Dragon: POW ↑',
    3,
    requirements: <Skill>[silverDragon],
  ),
  philosopherStoneImprovedProtection(
    "Philosopher's Stone - Improved Protection",
    3,
    requirements: <Skill>[philosopherStoneProtective],
  ),
  royalFlare(
    'Sun Sign "Royal Flare"',
    3,
    requirements: <Skill>[philosopherStoneHighLevel],
  ),
  silentSelene(
    'Moon Sign "Silent Selene"',
    3,
    requirements: <Skill>[philosopherStoneHighLevel],
  ),
  mercuryPoison2(
    'Mercury Poison: POW ↑',
    3,
    requirements: <Skill>[princessUndine2, mercuryPoison],
  ),
  forestBlaze2(
    'Forest Blaze: POW ↑',
    3,
    requirements: <Skill>[satelliteHimawari2, forestBlaze],
  ),
  protectiveTypeLatest(
    'Protective Type - Latest Revision',
    3,
    requirements: <Skill>[
      initiativeTypeImproved,
      philosopherStoneImprovedProtection,
    ],
  ),
  protectiveTypeRecovery(
    'Protective Type - Recovery Response',
    3,
    requirements: <Skill>[
      philosopherStoneImprovedProtection,
      sustainedTypeImproved,
    ],
  ),
  sunSignRemnantPower(
    'Sun Sign - Remnant Power',
    3,
    requirements: <Skill>[royalFlare],
  ),
  moonSignRemnantPower(
    'Moon Sign - Remnant Power',
    3,
    requirements: <Skill>[silentSelene],
  ),
  multiElementCasting(
    'Multi-Element Casting Efficiency',
    3,
    requirements: <Skill>[
      phlogisticRain2,
      mercuryPoison2,
    ],
  ),
  compoundMagicImprovements(
    'Compound Magic Improvements',
    3,
    requirements: <Skill>[mercuryPoison2, sylphyHorn2],
  ),
  multiElementPrinciples(
    'Multi-Element Principles',
    3,
    requirements: <Skill>[sylphyHorn2, forestBlaze2],
  ),
  fiveSeasons(
    'Five Seasons',
    3,
    requirements: <Skill>[forestBlaze2, silverDragon2],
  ),
  philosopherStoneSacrificial(
    "Philosopher's Stone - Sacrificial Type",
    5,
    requirements: <Skill>[philosopherStoneImprovedProtection],
  ),
  royalDiamondRing(
    'Sun Moon Sign "Royal Diamond Ring"',
    3,
    requirements: <Skill>[sunSignRemnantPower, moonSignRemnantPower],
  ),
  fiveSeasonsBuffing(
    'Five Seasons: Buffing Season',
    3,
    requirements: <Skill>[fiveSeasons],
  ),
  fiveSeasonsDebuffing(
    'Five Seasons: Debuffing Season',
    3,
    requirements: <Skill>[fiveSeasons],
  ),
  sunMoonPersistentBuffing(
    'Sun & Moon Sign - Persistent Buffing Magic',
    3,
    requirements: <Skill>[royalDiamondRing],
  ),
  sunMoonEfficientMagic(
    'Sun & Moon Sign - Efficient Magic',
    3,
    requirements: <Skill>[royalDiamondRing],
  ),
  moonFireWaterWoodMetal(
    'Moon/Fire/Water/Wood/Metal Improvements',
    3,
    requirements: <Skill>[multiElementCasting, compoundMagicImprovements],
  ),
  fiveSeasonsWeekday(
    'Five Seasons: Weekday Magic Season',
    3,
    requirements: <Skill>[fiveSeasons],
  ),
  // Cirno skills
  frostKing('Ice King "Frost King"', 3),
  icicleFall('Ice Sign "Icicle Fall"', 3),
  inexhaustibleEnergy('Inexhaustible Energy', 2),
  icicleFallSpdDownAffix(
    'Icicle Fall: SPD ↓ Affix',
    3,
    requirements: <Skill>[icicleFall],
  ),
  tomboyishGirlIce('Tomboyish Girl of Ice', 3),
  diamondBlizzard(
    'Snow Sign "Diamond Blizzard"',
    3,
    requirements: <Skill>[icicleFall],
  ),
  tryTryAgain('Try, Try Again!', 4),
  abilityManipulateCold('Ability to Manipulate Cold', 3),
  bondsBakaQuartet('Bonds of the Baka Quartet', 3),
  autoFrostKing(
    'Auto Frost King',
    3,
    requirements: <Skill>[frostKing],
  ),
  icicleFall2(
    'Icicle Fall: POW ↑',
    2,
    requirements: <Skill>[icicleFall, tomboyishGirlIce],
  ),
  petalScatteringBlizzardGale(
    'Petal-Scattering Blizzard Gale',
    5,
    requirements: <Skill>[diamondBlizzard, tryTryAgain],
  ),
  imFineOnMyOwn("I'm Fine On My Own!", 3),
  icicleFallSpdDownBoost(
    'Icicle Fall: SPD ↓ Boost',
    3,
    requirements: <Skill>[icicleFallSpdDownAffix],
  ),
  superTomboyishGirlIce(
    'Super Tomboyish Girl of Ice',
    2,
    requirements: <Skill>[tomboyishGirlIce],
  ),
  diamondBlizzardPar(
    'Diamond Blizzard: PAR chance ↑',
    3,
    requirements: <Skill>[diamondBlizzard],
  ),
  tryTryAgain2(
    'Try, Try Again! ...Again!',
    3,
    requirements: <Skill>[tryTryAgain],
  ),
  perfectFreeze(
    'Freeze Sign "Perfect Freeze"',
    4,
    requirements: <Skill>[abilityManipulateCold],
  ),
  abilityManipulateCold2(
    'Ability to Manipulate Cold+',
    2,
    requirements: <Skill>[abilityManipulateCold],
  ),
  freezeAtmosphere(
    'Freeze Sign "Freeze Atmosphere"',
    3,
    requirements: <Skill>[abilityManipulateCold],
  ),
  bondsBakaQuartet2(
    'Bonds of the Baka Quartet+',
    2,
    requirements: <Skill>[bondsBakaQuartet],
  ),
  frostKingUnendingMonarchy(
    'Frost King: Unending Monarchy',
    3,
    requirements: <Skill>[autoFrostKing],
  ),
  frostColumns('Frost Sign "Frost Columns"', 3),
  absoluteZeroFairy(
    'Absolute Zero Fairy',
    2,
    requirements: <Skill>[icicleFall2, superTomboyishGirlIce],
  ),
  swordFreezer(
    'Ice Sign "Sword Freezer"',
    4,
    requirements: <Skill>[superTomboyishGirlIce, diamondBlizzardPar],
  ),
  redHotIcySpirit(
    'Red-Hot Icy Spirit',
    4,
    requirements: <Skill>[petalScatteringBlizzardGale],
  ),
  inexhaustibleEnergy2(
    'Inexhaustible Energy+',
    2,
    requirements: <Skill>[inexhaustibleEnergy],
  ),
  abilityManipulateColdBoost(
    'Ability to Manipulate Cold: Boost Conversion',
    2,
    requirements: <Skill>[abilityManipulateCold2],
  ),
  imFineOnMyOwn2(
    "I'm Fine On My Own!+",
    2,
    requirements: <Skill>[imFineOnMyOwn],
  ),
  icicleFallSpdDownBoost2(
    'Icicle Fall: SPD ↓ Boost+',
    3,
    requirements: <Skill>[icicleFallSpdDownBoost],
  ),
  iceFairyFreezingSkills(
    "Ice Fairy's Freezing Skills",
    4,
    requirements: <Skill>[absoluteZeroFairy],
  ),
  swordFreezerGuardPierce(
    'Sword Freezer: Guard Pierce',
    2,
    requirements: <Skill>[swordFreezer],
  ),
  stubbornTilTheEnd(
    "Stubborn 'Til the End",
    6,
    requirements: <Skill>[tryTryAgain2],
  ),
  perfectFreeze2(
    'Perfect Freeze: POW ↑',
    2,
    requirements: <Skill>[perfectFreeze],
  ),
  bondsBakaQuartet3(
    'Bonds of the Baka Quartet++',
    2,
    requirements: <Skill>[bondsBakaQuartet2],
  ),
  frostColumnsUnmeltingIcicles(
    'Frost Columns: Unmelting Icicles',
    3,
    requirements: <Skill>[
      frostKingUnendingMonarchy,
      frostColumns,
      icicleFallSpdDownBoost2,
    ],
  ),
  iceFairyAcrobaticSkills(
    "Ice Fairy's Acrobatic Skills",
    3,
    requirements: <Skill>[absoluteZeroFairy],
  ),
  swordFreezerParSpdDownSlay(
    'Sword Freezer: PAR+SPD ↓ Slay',
    3,
    requirements: <Skill>[swordFreezerGuardPierce],
  ),
  persistentSpirit(
    'Persistent Spirit',
    3,
    requirements: <Skill>[redHotIcySpirit],
  ),
  perfectFreezeSpdDownChanceUp(
    'Perfect Freeze: SPD ↓ Chance ↑',
    3,
    requirements: <Skill>[perfectFreeze2],
  ),
  perfectFreezeSpdDownSlay(
    'Perfect Freeze: SPD ↓ Slay',
    2,
    requirements: <Skill>[perfectFreeze2],
  ),
  imFineOnMyOwn3(
    "I'm Fine On My Own!++",
    2,
    requirements: <Skill>[imFineOnMyOwn2],
  ),
  proofOfTheStrongest(
    'Proof of the Strongest',
    5,
    requirements: <Skill>[icicleFallSpdDownBoost2],
  ),
  absoluteZeroQueen(
    'Absolute Zero Queen',
    3,
    requirements: <Skill>[iceFairyAcrobaticSkills, iceFairyFreezingSkills],
  ),
  swordFreezerBlizzardBladedance(
    'Sword Freezer: Blizzard Bladedance',
    5,
    requirements: <Skill>[swordFreezerParSpdDownSlay],
  ),
  perfectFreezeAbsoluteStillness(
    'Perfect Freeze: Absolute Stillness',
    3,
    requirements: <Skill>[perfectFreezeSpdDownChanceUp],
  ),
  perfectFreezeSpdDownSlay2(
    'Perfect Freeze: SPD ↓ Slay+',
    2,
    requirements: <Skill>[perfectFreezeSpdDownSlay],
  ),
  // Keine skills
  jewelsDivineProtection("Jewel's Divine Protection", 3),
  oldHistory('''Old History "Untrodden Land's History"''', 3),
  immovable('Immovable', 3),
  historiansPointer("Historian's Pointer", 3),
  swordsDivineProtection(
    "Sword's Divine Protection",
    3,
    requirements: <Skill>[jewelsDivineProtection],
  ),
  jewelsDivineProtectionDuration(
    "Jewel's Divine Protection: Self-Use Duration ↑",
    3,
    requirements: <Skill>[jewelsDivineProtection],
  ),
  nextHistory('Next History "New History of Fantasy"', 3),
  organizedFormation(
    'Organized Formation',
    2,
    requirements: <Skill>[immovable],
  ),
  swordsDivineProtectionDuration(
    "Sword's Divine Protection: Self-Use Duration ↑",
    2,
    requirements: <Skill>[swordsDivineProtection],
  ),
  countrySignJewel(
    'Country Sign "Three Sacred Treasures - Jewel"',
    4,
  ),
  untroddenLandsHistoryDefMnd(
    "Untrodden Land's History: DEF/MND ↑ Augment",
    2,
    requirements: <Skill>[oldHistory],
  ),
  wereHakutakuForewarning('Were-Hakutaku Forewarning', 3),
  newHistoryOfFantasyAtkMag(
    'New History of Fantasy: ATK/MAG ↑ Augment',
    2,
    requirements: <Skill>[nextHistory],
  ),
  immovable2('Immovable+', 3, requirements: <Skill>[immovable]),
  flawlessLeadership(
    'Flawless Leadership',
    4,
    requirements: <Skill>[organizedFormation],
  ),
  historiansPointer2(
    "Historian's Pointer+",
    4,
    requirements: <Skill>[historiansPointer],
  ),
  swordsDivineAutoProtection(
    "Sword's Divine Auto-Protection",
    3,
    requirements: <Skill>[swordsDivineProtectionDuration],
  ),
  countrySignSword(
    'Country Sign "Three Sacred Treasures - Sword"',
    4,
    requirements: <Skill>[swordsDivineProtection],
  ),
  jewelsDivineAutoProtection(
    "Jewel's Divine Auto-Protection",
    3,
    requirements: <Skill>[jewelsDivineProtectionDuration],
  ),
  untroddenLandsHistorySelfRecovery(
    "Untrodden Land's History: Self-Recovery",
    3,
    requirements: <Skill>[untroddenLandsHistoryDefMnd],
  ),
  organizedFormation2(
    'Organized Formation+',
    2,
    requirements: <Skill>[organizedFormation],
  ),
  alongsideMokou('Alongside Mokou', 3),
  historyAccumulationSword(
    'History Accumulation - Sword',
    4,
    requirements: <Skill>[countrySignSword],
  ),
  mirrorsDivineProtection(
    "Mirror's Divine Protection",
    3,
    requirements: <Skill>[countrySignSword, countrySignJewel],
  ),
  historyAccumulationJewel(
    'History Accumulation - Jewel',
    4,
    requirements: <Skill>[countrySignJewel],
  ),
  untroddenLandsHistory2(
    "Untrodden Land's History: POW ↑",
    2,
    requirements: <Skill>[untroddenLandsHistorySelfRecovery],
  ),
  wereHakutakuTransformation(
    'Were-Hakutaku Transformation',
    3,
    requirements: <Skill>[wereHakutakuForewarning],
  ),
  newHistoryOfFantasyFrontlineRecovery(
    'New History of Fantasy: Frontline Recovery',
    3,
    requirements: <Skill>[wereHakutakuForewarning, newHistoryOfFantasyAtkMag],
  ),
  unrestrainableUrge(
    'Unrestrainable Urge',
    3,
    requirements: <Skill>[wereHakutakuForewarning, immovable2],
  ),
  flawlessLeadership2(
    'Flawless Leadership+',
    5,
    requirements: <Skill>[organizedFormation2, flawlessLeadership],
  ),
  historiansPointer3(
    "Historian's Pointer++",
    5,
    requirements: <Skill>[historiansPointer2],
  ),
  swordsDivineAutoProtection2(
    "Sword's Divine Auto-Protection+",
    2,
    requirements: <Skill>[swordsDivineAutoProtection],
  ),
  countrySignMirror(
    'Country Sign "Three Sacred Treasures - Mirror"',
    4,
    requirements: <Skill>[
      historyAccumulationSword,
      mirrorsDivineProtection,
      historyAccumulationJewel,
    ],
  ),
  jewelsDivineAutoProtection2(
    "Jewel's Divine Auto-Protection+",
    2,
    requirements: <Skill>[jewelsDivineAutoProtection],
  ),
  legendOfGensokyo(
    'Nil History "Legend of Gensokyo"',
    4,
    requirements: <Skill>[
      untroddenLandsHistorySelfRecovery,
      wereHakutakuTransformation,
    ],
  ),
  newHistoryOfFantasy2(
    'New History of Fantasy: Damage Multiplier ↑',
    2,
    requirements: <Skill>[newHistoryOfFantasyFrontlineRecovery],
  ),
  perfectFormation(
    'Perfect Formation',
    4,
    requirements: <Skill>[organizedFormation2],
  ),
  alongsideMokou2(
    'Alongside Mokou+',
    2,
    requirements: <Skill>[alongsideMokou],
  ),
  grandHistorySword(
    'Grand History - Sword',
    3,
    requirements: <Skill>[historyAccumulationSword],
  ),
  grandHistoryJewel(
    'Grand History - Jewel',
    3,
    requirements: <Skill>[historyAccumulationJewel],
  ),
  mitoNoMitsukuni(
    'Hollyhock Sign "Mito no Mitsukuni"',
    4,
    requirements: <Skill>[
      wereHakutakuTransformation,
      newHistoryOfFantasyFrontlineRecovery,
    ],
  ),
  historiansPointer4(
    "Historian's Pointer+++",
    6,
    requirements: <Skill>[historiansPointer3],
  ),
  swordsSharedDivineAutoProtection(
    "Sword's Shared Divine Auto-Protection+",
    3,
    requirements: <Skill>[swordsDivineAutoProtection2],
  ),
  historyEatingHalfBeast(
    'History-Eating Half-Beast',
    4,
    requirements: <Skill>[
      grandHistorySword,
      countrySignMirror,
      grandHistoryJewel,
    ],
  ),
  jewelsSharedDivineAutoProtection(
    "Jewel's Shared Divine Auto-Protection+",
    3,
    requirements: <Skill>[jewelsDivineAutoProtection2],
  ),
  amaterasu(
    'Light Sign "Amaterasu"',
    5,
    requirements: <Skill>[legendOfGensokyo, mitoNoMitsukuni],
  ),
  // Doremy skills
  rulerOfDreams('Ruler of Dreams', 3),
  deepNavyRunawayDream(
    'Dream Sign "Deep Navy Runaway Dream"',
    3,
    requirements: <Skill>[rulerOfDreams],
  ),
  scarletNightmare(
    'Dream Sign "Scarlet Nightmare"',
    3,
    requirements: <Skill>[rulerOfDreams],
  ),
  rulerOfTheDreamWorld('Ruler of the Dream World', 3),
  dreamCatcher(
    'Dream Sign "Dream Catcher"',
    3,
    requirements: <Skill>[deepNavyRunawayDream],
  ),
  dreamBalloonFlight(
    'Dream Balloon Flight',
    3,
    requirements: <Skill>[rulerOfDreams],
  ),
  frighteningDebilitatingDream(
    'Frigthening Debilitating Dream',
    3,
    requirements: <Skill>[rulerOfDreams],
  ),
  astonishingDumbfoundingDream(
    'Astonishing Dumbfounding Dream',
    3,
    requirements: <Skill>[rulerOfDreams],
  ),
  indigoAnxietyDream(
    'Dream Sign "Indigo Anxiety Dream"',
    3,
    requirements: <Skill>[scarletNightmare],
  ),
  nightmareCatcher(
    'Dream Sign "Nightmare Catcher"',
    3,
    requirements: <Skill>[scarletNightmare],
  ),
  wryPotency('WRY Potency ↑', 3, requirements: <Skill>[dreamCatcher]),
  dreamCatcher2(
    'Dream Catcher: Effect ↑',
    3,
    requirements: <Skill>[dreamCatcher],
  ),
  pitchBlackCosmicDream(
    'Dream Sign "Pitch Black Cosmic Dream"',
    3,
    requirements: <Skill>[deepNavyRunawayDream],
  ),
  deepNavyRunawayDreamDreamSoulGain(
    'Deep Navy Runaway Dream: Dream Soul Gain',
    3,
    requirements: <Skill>[deepNavyRunawayDream],
  ),
  dreamSoulsUponEvasion(
    'Dream Souls Upon Evasion',
    3,
    requirements: <Skill>[dreamBalloonFlight, frighteningDebilitatingDream],
  ),
  dreamSoulsToDamageTaken(
    'Dream Souls to Damage Taken',
    3,
    requirements: <Skill>[
      frighteningDebilitatingDream,
      astonishingDumbfoundingDream,
    ],
  ),
  scarletNightmareEffect(
    'Scarlet Nightmare: Special Effect ↑',
    3,
    requirements: <Skill>[scarletNightmare],
  ),
  indigoAnxietyDreamEffect(
    'Indigo Anxiety Dream: Special Effect ↑',
    3,
    requirements: <Skill>[indigoAnxietyDream],
  ),
  nightmareCatcherEffect(
    'Nightmare Catcher: Effect ↑',
    3,
    requirements: <Skill>[nightmareCatcher],
  ),
  wryChance('WRY Chance ↑', 3, requirements: <Skill>[nightmareCatcher]),
  rulerOfTheDreamWorld2(
    'Ruler of the Dream World+',
    3,
    requirements: <Skill>[rulerOfTheDreamWorld],
  ),
  dreamCatcherDamageDealtAbsorption(
    'Dream Catcher: Damage Dealt ↑ Absorption',
    3,
    requirements: <Skill>[dreamCatcher],
  ),
  pitchBlackCosmicDreamElements(
    'Pitch-Black Cosmic Dream: Dream Souls to Elements',
    3,
    requirements: <Skill>[pitchBlackCosmicDream],
  ),
  dreamBalloonFlight2(
    'Dream Balloon Flight+',
    3,
    requirements: <Skill>[dreamBalloonFlight],
  ),
  frighteningDebilitatingDream2(
    'Frigthening Debilitating Dream+',
    3,
    requirements: <Skill>[frighteningDebilitatingDream],
  ),
  astonishingDumbfoundingDream2(
    'Astonishing Dumbfounding Dream+',
    3,
    requirements: <Skill>[astonishingDumbfoundingDream],
  ),
  ultramarineLunaticDream(
    'Moon Sign "Ultramarine Lunatic Dream"',
    3,
    requirements: <Skill>[indigoAnxietyDream],
  ),
  nightmareCatcherBuffs(
    'Nightmare Catcher: Buffs to Damage Taken ↓',
    3,
    requirements: <Skill>[nightmareCatcher],
  ),
  wryPotencyRange(
    'WRY Potency ↑: Range Expansion',
    3,
    requirements: <Skill>[wryPotency],
  ),
  dreamCatcher3(
    'Dream Catcher: Effect ↑+',
    3,
    requirements: <Skill>[dreamCatcher2],
  ),
  pitchBlackCosmicDream2(
    'Pitch-Black Cosmic Dream: Dream Souls to POW',
    3,
    requirements: <Skill>[pitchBlackCosmicDream],
  ),
  deepNavyRunawayDreamWry(
    'Deep Navy Runaway Dream: Forced WRY Affix',
    3,
    requirements: <Skill>[deepNavyRunawayDreamDreamSoulGain],
  ),
  buffsUponEvasion(
    'Buffs Upon Evasion',
    3,
    requirements: <Skill>[dreamSoulsUponEvasion],
  ),
  dreamSoulsToDamageDealt(
    'Dream Souls to Damage Dealt',
    3,
    requirements: <Skill>[dreamSoulsToDamageTaken],
  ),
  scarletNightmareEffect2(
    'Scarlet Nightmare: Special Effect ↑+',
    3,
    requirements: <Skill>[scarletNightmareEffect],
  ),
  indigoAnxietyDreamEffect2(
    'Indigo Anxiety Dream: Special Effect ↑+',
    3,
    requirements: <Skill>[indigoAnxietyDreamEffect],
  ),
  nightmareCatcherEffect2(
    'Nightmare Catcher: Effect ↑+',
    3,
    requirements: <Skill>[nightmareCatcherEffect],
  ),
  wryChance2('WRY Chance ↑+', 3, requirements: <Skill>[wryChance]),
  rulerOfTheDreamWorldShield(
    'Ruler of the Dream World: Shield Conversion',
    3,
    requirements: <Skill>[rulerOfTheDreamWorld2],
  ),
  dreamCatcherSharing(
    'Dream Catcher: Damage Dealt ↑ Sharing',
    3,
    requirements: <Skill>[dreamCatcherDamageDealtAbsorption],
  ),
  dreamExpress(
    'Super-Express "Dream Express"',
    3,
    requirements: <Skill>[pitchBlackCosmicDreamElements],
  ),
  doremyPopping(
    'Doremy Popping',
    3,
    requirements: <Skill>[dreamBalloonFlight2],
  ),
  nightmareCatcherSharing(
    'Nightmare Catcher: Damage Taken ↓ Sharing',
    3,
    requirements: <Skill>[nightmareCatcherBuffs],
  ),
  ultramarineLunaticDreamEffect(
    'Ultramarine Lunatic Dream: Special Effect ↑',
    3,
    requirements: <Skill>[ultramarineLunaticDream],
  ),
  dreamExpressRainbow(
    'Dream Express: Rainbow Fright',
    3,
    requirements: <Skill>[dreamExpress],
  ),
  deepNavyRunawayDreamWry2(
    'Deep Navy Runaway Dream: Forced WRY Affix+',
    3,
    requirements: <Skill>[deepNavyRunawayDreamWry],
  ),
  mpUponEvasion('MP Upon Evasion', 3, requirements: <Skill>[buffsUponEvasion]),
  ultramarineLunaticDreamEffect2(
    'Ultramarine Lunatic Dream: Special Effect ↑+',
    3,
    requirements: <Skill>[
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
    requirements: <Skill>[meshOfLightAndDarkness],
  ),
  meshOfLightAndDarknessTurnBuff(
    'Mesh of Light and Darkness: Designated Turn Buff',
    3,
    requirements: <Skill>[meshOfLightAndDarkness],
  ),
  hyperactiveFlyingObjectTurnBuff(
    'Hyperactive High Speed Flying Object: Designated Turn Buff',
    3,
    requirements: <Skill>[hyperactiveFlyingObject],
  ),
  hyperactiveFlyingObjectFlierSlay(
    'Hyperactive High Speed Flying Object: Flier Slay',
    3,
    requirements: <Skill>[hyperactiveFlyingObject],
  ),
  yakumoHousehold('Yakumo Household', 3),
  boundaryOfWaveAndParticle('Boundary of Wave and Particle', 3),
  boundaryOfMeleeAndDanmaku(
    'Boundary of Melee and Danmaku',
    3,
    requirements: <Skill>[meshOfLightAndDarkness],
  ),
  meshOfLightAndDarknessParSpdDownSlay(
    'Mesh of Light and Darkness: PAR+SPD ↓ Slay',
    3,
    requirements: <Skill>[meshOfLightAndDarkness],
  ),
  hyperactiveFlyingObjectRow(
    'Hyperactive High Speed Flying Object: Row Attack',
    3,
    requirements: <Skill>[hyperactiveFlyingObject],
  ),
  boundaryOfRecoveryAndInjury(
    'Boundary of Recovery and Injury',
    3,
    requirements: <Skill>[hyperactiveFlyingObject],
  ),
  boundaryOfFormAndEmptiness('Boundary of Form and Emptiness', 3),
  meshOfLightAndDarknessInfliction(
    'Mesh of Light and Darkness: Infliction Chance ↑',
    3,
    requirements: <Skill>[meshOfLightAndDarknessParSpdDownSlay],
  ),
  quadrupleImperishableNightBarrier(
    'Boundary "Quadruple Imperishable Night Barrier"',
    3,
  ),
  yakumoRan('Shikigami "Yakumo Ran+"', 3),
  hyperactiveFlyingObjectGuardPierce(
    'Hyperactive High Speed Flying Object: Guard Pierce',
    3,
    requirements: <Skill>[
      hyperactiveFlyingObjectRow,
      hyperactiveFlyingObjectFlierSlay,
    ],
  ),
  boundaryOfWaveAndParticle2(
    'Boundary of Wave and Particle+',
    3,
    requirements: <Skill>[boundaryOfWaveAndParticle],
  ),
  boundaryOfMeleeAndDanmakuShare(
    'Boundary of Melee and Danmaku: 1/4 Party Share',
    3,
    requirements: <Skill>[boundaryOfWaveAndParticle, boundaryOfMeleeAndDanmaku],
  ),
  boundaryOfMeleeAndDanmaku2(
    'Boundary of Melee and Danmaku: Effect ↑',
    5,
    requirements: <Skill>[boundaryOfMeleeAndDanmaku],
  ),
  quadrupleImperishableNightBarrier2(
    'Quadruple Imperishable Night Barrier: Effect ↑',
    3,
    requirements: <Skill>[quadrupleImperishableNightBarrier],
  ),
  yakumoYukarisSpiritingAway(
    '''Evil Spirits "Yakumo Yukari's Spiriting Away"''',
    3,
    requirements: <Skill>[quadrupleImperishableNightBarrier, yakumoRan],
  ),
  yakumoRanChensStrength(
    "Yakumo Ran+: Chen's Strength",
    3,
    requirements: <Skill>[yakumoRan],
  ),
  boundaryOfRecoveryAndInjury2(
    'Boundary of Recovery and Injury: Effect ↑',
    3,
    requirements: <Skill>[boundaryOfRecoveryAndInjury],
  ),
  boundaryOfRecoveryAndInjuryShare(
    'Boundary of Recovery and Injury: 1/4 Party Share',
    2,
    requirements: <Skill>[boundaryOfFormAndEmptiness],
  ),
  boundaryOfFormAndEmptiness2(
    'Boundary of Form and Emptiness+',
    3,
    requirements: <Skill>[boundaryOfFormAndEmptiness],
  ),
  boundaryOfMeleeAndDanmakuShare2(
    'Boundary of Melee and Danmaku: 1/3 Party Share',
    2,
    requirements: <Skill>[boundaryOfMeleeAndDanmakuShare],
  ),
  danmakuBarrier(
    '''Yukari's Arcanum "Danmaku Barrier"''',
    3,
    requirements: <Skill>[
      boundaryOfMeleeAndDanmakuShare,
      boundaryOfMeleeAndDanmaku2,
    ],
  ),
  quadrupleImperishableNightBarrierOddTurn(
    'Quadruple Imperishable Night Barrier: Odd Turn Stats ↑',
    3,
    requirements: <Skill>[quadrupleImperishableNightBarrier2],
  ),
  quadrupleImperishableNightBarrierEvenTurn(
    'Quadruple Imperishable Night Barrier: Even Turn Damage Taken ↓',
    3,
    requirements: <Skill>[quadrupleImperishableNightBarrier2],
  ),
  yakumoYukarisSpiritingAwayDelay(
    "Yakumo Yukari's Spiriting Away: Delay ↓",
    2,
    requirements: <Skill>[yakumoYukarisSpiritingAway],
  ),
  yakumoRanRansStrength(
    "Yakumo Ran+: Ran's Strength",
    3,
    requirements: <Skill>[yakumoRanChensStrength],
  ),
  objectiveBarrier(
    'Barrier "Objective Barrier"',
    3,
    requirements: <Skill>[
      boundaryOfRecoveryAndInjury2,
      boundaryOfRecoveryAndInjuryShare,
    ],
  ),
  boundaryOfRecoveryAndInjuryShare2(
    'Boundary of Recovery and Injury: 1/3 Party Share',
    2,
    requirements: <Skill>[boundaryOfRecoveryAndInjuryShare],
  ),
  yakumoHousehold2(
    'Yakumo Household+',
    2,
    requirements: <Skill>[yakumoHousehold],
  ),
  boundaryOfWaveAndParticle3(
    'Boundary of Wave and Particle++',
    3,
    requirements: <Skill>[boundaryOfWaveAndParticle2],
  ),
  boundaryOfMeleeAndDanmakuShare3(
    'Boundary of Melee and Danmaku: 1/2 Party Share',
    2,
    requirements: <Skill>[
      boundaryOfWaveAndParticle,
      boundaryOfMeleeAndDanmakuShare2,
    ],
  ),
  danmakuBarrier2nTurnModulo(
    'Danmaku Barrier: 2n Turn Modulo',
    4,
    requirements: <Skill>[danmakuBarrier],
  ),
  quadrupleImperishableNightBarrierOddTurn2(
    'Quadruple Imperishable Night Barrier: Odd Turn Stats ↑+',
    3,
    requirements: <Skill>[quadrupleImperishableNightBarrierOddTurn],
  ),
  yakumoYukarisSpiritingAwayTurnsToMpCostDown(
    "Yakumo Yukari's Spiriting Away: Turns to MP Cost ↓",
    3,
    requirements: <Skill>[yakumoYukarisSpiritingAway],
  ),
  yakumoYukarisSpiritingAwayDelay2(
    "Yakumo Yukari's Spiriting Away: Delay ↓+",
    2,
    requirements: <Skill>[yakumoYukarisSpiritingAwayDelay],
  ),
  yakumoRanYakumoHouseholdsBigBrawl(
    "Yakumo Ran+: Yakumo Household's Big Brawl",
    5,
    requirements: <Skill>[yakumoRanRansStrength],
  ),
  objectiveBarrier2nTurnModulo(
    'Objective Barrier: 2n Turn Modulo',
    4,
    requirements: <Skill>[objectiveBarrier],
  ),
  boundaryOfRecoveryAndInjuryShare3(
    'Boundary of Recovery and Injury: 1/2 Party Share',
    2,
    requirements: <Skill>[
      boundaryOfRecoveryAndInjuryShare2,
      boundaryOfFormAndEmptiness,
    ],
  ),
  boundaryOfFormAndEmptiness3(
    'Boundary of Form and Emptiness++',
    3,
    requirements: <Skill>[boundaryOfFormAndEmptiness2],
  ),
  danmakuBarrierMpCostDown(
    'Danmaku Barrier: MP Cost ↓',
    3,
    requirements: <Skill>[danmakuBarrier],
  ),
  quadrupleImperishableNightBarrierEvenTurn2(
    'Quadruple Imperishable Night Barrier: Even Turn Damage Taken ↓+',
    3,
    requirements: <Skill>[
      quadrupleImperishableNightBarrierEvenTurn,
    ],
  ),
  yakumoYukarisSpiritingAwaySelfSpiritingAway(
    "Yakumo Yukari's Spiriting Away: Self-Spiriting Away",
    2,
    requirements: <Skill>[yakumoYukarisSpiritingAwayDelay2],
  ),
  objectiveBarrierMpCostDown(
    'Objective Barrier: MP Cost ↓',
    3,
    requirements: <Skill>[objectiveBarrier],
  );

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
