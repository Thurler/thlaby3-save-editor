/// A mixin for skills that completely cleanse attack debuffs from the target
mixin AttackDebuffCleanser {}

/// A mixin for skills that completely cleanse defense debuffs from the target
mixin DefenseDebuffCleanser {}

/// A mixin for skills that completely cleanse magic debuffs from the target
mixin MagicDebuffCleanser {}

/// A mixin for skills that completely cleanse mind debuffs from the target
mixin MindDebuffCleanser {}

/// A mixin for skills that completely cleanse speed debuffs from the target
mixin SpeedDebuffCleanser {}

/// A mixin for skills that completely cleanse accuracy debuffs from the target
mixin AccuracyDebuffCleanser {}

/// A mixin for skills that completely cleanse evasion debuffs from the target
mixin EvasionDebuffCleanser {}

/// A mixin for skills that completely cleanse all stat debuffs from the target
mixin AllDebuffCleanser
    implements
        AttackDebuffCleanser,
        DefenseDebuffCleanser,
        MagicDebuffCleanser,
        MindDebuffCleanser,
        SpeedDebuffCleanser,
        AccuracyDebuffCleanser,
        EvasionDebuffCleanser {}
