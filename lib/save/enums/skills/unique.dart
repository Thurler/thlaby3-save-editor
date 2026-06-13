import 'package:thlaby3_save_editor/save/enums/skills/element.dart';
import 'package:thlaby3_save_editor/save/enums/skills/focus_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/ko_reaction.dart';
import 'package:thlaby3_save_editor/save/enums/skills/race.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/skill_augment.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell_augment.dart';

/// A mixin to unify all character unique skills, be they spells, passives or
/// augments
mixin UniqueSkill on Skill {
  static List<UniqueSkill> get values =>
      (UncategorizedUniqueSkill.values as List<UniqueSkill>) +
      PassiveSkill.values +
      SkillAugmentSkill.values +
      SpellSkill.values +
      SpellAugmentSkill.values +
      ElementProtector.values +
      RaceSlayer.values +
      KoReactioner.values +
      FocusReactioner.values;
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
  eagerSupport('Eager Support', 3),
  readingStarsPositions("Reading the Stars' Positions", 3),
  firstAid('First Aid', 3),
  warningBeacon('Warning Beacon', 3),
  beaconSpecialist('Beacon Specialist', 3),
  signalBeacon('Signal Beacon', 3),
  knowledgeStrangeThings('Knowledge of Strange Things', 3),
  swiftBeacon('Swift Beacon', 3, requirements: <Skill>[warningBeacon]),
  targetBeacon('Target Beacon', 3, requirements: <Skill>[signalBeacon]),
  eagerSupportMentalCare(
    'Eager Support: Mental Care Boost',
    3,
    requirements: <Skill>[eagerSupport],
  ),
  firstAidTraining(
    'First Aid: First Aid Training',
    3,
    requirements: <Skill>[firstAid],
  ),
  maryShield("Mary's Shield", 3),
  warningBeacon2(
    'Warning Beacon: Effect ↑',
    3,
    requirements: <Skill>[warningBeacon],
  ),
  adeptBeaconSpecialist(
    'Adept Beacon Specialist',
    3,
    requirements: <Skill>[swiftBeacon, beaconSpecialist, targetBeacon],
  ),
  signalBeacon2(
    'Signal Beacon: Effect ↑',
    3,
    requirements: <Skill>[signalBeacon],
  ),
  abilityReadStars(
    'Ability to Read the Stars',
    3,
    requirements: <Skill>[readingStarsPositions],
  ),
  abilityReadMoon(
    'Ability to Read the Moon',
    3,
    requirements: <Skill>[readingStarsPositions],
  ),
  knowledgeStrangeThings2(
    'Knowledge of Strange Things: Effect ↑',
    3,
    requirements: <Skill>[knowledgeStrangeThings],
  ),
  learningListExpansion1('Learning List Expansion #1', 4),
  firCldDamage('FIR/CLD Damage ↑', 3),
  wndNtrDamage('WND/NTR Damage ↑', 3),
  mysSpiDamage('MYS/SPI Damage ↑', 3),
  drkPhyDamage('DRK/PHY Damage ↑', 3),
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
  knowledgeStrangeThingsShield(
    'Knowledge of Strange Things: Shield Conversion',
    3,
    requirements: <Skill>[knowledgeStrangeThings2],
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
