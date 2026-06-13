import 'package:thlaby3_save_editor/save/enums/skills/skill.dart';
import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';

enum KoTriggerRange {
  self,
  allAllies;
}

enum KoEffectRange {
  self,
  frontline,
  frontlineMinusSelf,
  backline;
}

/// A mixin for skills that trigger upon a ko happening in the field
mixin KoReactioner on UniqueSkill {
  /// The requirement that must be met to make the reaction effect trigger. If
  /// null, then no requirement is needed
  EffectRequirement? get reactionRequirement;

  /// The range associated with KO detection
  KoTriggerRange get triggerRange;

  /// The range associated with the KO effect
  KoEffectRange get effectRange;

  static List<KoReactioner> get values => const <KoReactioner>[
    // Reimu ko reactions
    reimuPrivileges,
    reimuPrivilegesShare,
    finalPrayer,
    finalPrayerRange,
    trueFinalPrayer,
  ];
}
