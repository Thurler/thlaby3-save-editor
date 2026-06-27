/// An interface for skills that completely cleanse attack debuffs from the
/// target
abstract interface class AttackDebuffCleanser {}

/// An interface for skills that completely cleanse defense debuffs from the
/// target
abstract interface class DefenseDebuffCleanser {}

/// An interface for skills that completely cleanse magic debuffs from the
/// target
abstract interface class MagicDebuffCleanser {}

/// An interface for skills that completely cleanse mind debuffs from the
/// target
abstract interface class MindDebuffCleanser {}

/// An interface for skills that completely cleanse speed debuffs from the
/// target
abstract interface class SpeedDebuffCleanser {}

/// An interface for skills that completely cleanse accuracy debuffs from the
/// target
abstract interface class AccuracyDebuffCleanser {}

/// An interface for skills that completely cleanse evasion debuffs from the
/// target
abstract interface class EvasionDebuffCleanser {}

/// An interface for skills that completely cleanse all stat debuffs from the
/// target
abstract interface class AllDebuffCleanser
    implements
        AttackDebuffCleanser,
        DefenseDebuffCleanser,
        MagicDebuffCleanser,
        MindDebuffCleanser,
        SpeedDebuffCleanser,
        AccuracyDebuffCleanser,
        EvasionDebuffCleanser {}
