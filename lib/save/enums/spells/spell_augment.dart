import 'package:thlaby3_save_editor/save/enums/skills/unique.dart';
import 'package:thlaby3_save_editor/save/enums/spells/reimu.dart';
import 'package:thlaby3_save_editor/save/enums/spells/spell.dart';

/// A mixin for skills that augment a spell's functionalities
mixin SpellAugmentSkill on UniqueSkill {
  /// The spell the augment acts on
  SpellSkill get baseSpell;

  static List<SpellAugmentSkill> get values => const <SpellAugmentSkill>[
    yinYangOrbParAffix,
    yinYangOrbPow,
    yinYangOrbDelay,
    yinYangOrbParBoost,
    yinYangOrbDelay2,
    yinYangOrbCooldownPow,
  ];
}

/// A mixin for skills that augment another augment, effectively replacing it
mixin SpellAugmentChainSkill on SpellAugmentSkill {
  /// The augment the augment acts on
  SpellAugmentSkill get baseAugment;
}

/// A mixin for augments that change a spell's pow
mixin PowAugment on SpellAugmentSkill {
  double get pow;
}

/// A mixin for augments that change a spell's delay
mixin DelayAugment on SpellAugmentSkill {
  double get delay;
}

/// A mixin for augments that change a spell's cooldown
mixin CooldownAugment on SpellAugmentSkill {
  int get cooldown;
}
