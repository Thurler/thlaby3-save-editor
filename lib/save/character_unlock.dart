import 'package:thlaby3_save_editor/save/enums/character.dart';

/// A struct to hold whether a character's recruitment flag is enabled or not
class CharacterUnlockFlag {
  /// The character that is represented by this flag
  final Character character;

  /// Whether the flag is locked or unlocked
  bool isUnlocked;

  CharacterUnlockFlag({
    required this.character,
    required this.isUnlocked,
  });

  /// Copy the data from another instance of [CharacterUnlockFlag]
  CharacterUnlockFlag.from(CharacterUnlockFlag other) :
    character = other.character,
    isUnlocked = other.isUnlocked;

  @override
  String toString() => '${character.name}: $isUnlocked';

  @override
  bool operator ==(Object other) =>
      other is CharacterUnlockFlag &&
      character.name == other.character.name &&
      isUnlocked == other.isUnlocked;

  @override
  int get hashCode => Object.hash(character.name, isUnlocked);
}
