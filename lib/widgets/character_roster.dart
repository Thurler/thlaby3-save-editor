import 'package:flutter/material.dart';
import 'package:tfields/extensions.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/save/character_unlock.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/widgets/character_rect.dart';

/// A widget that renders the entire roster in a [TGridRow], automatically
/// resizing how many characters are drawn per line based on the screen width
class CharacterRoster extends StatelessWidget {
  /// Callback for when a character portrait is tapped on
  final void Function(Character character) onTap;

  /// The character unlock flags to determine whether a character will display
  /// as locked or not
  final List<CharacterUnlockFlag> unlockFlags;

  /// Whether interactions with the portrait (tap and hover) are allowed when a
  /// character is locked
  final bool interactWhenLocked;

  /// A callback to notify the parent widget of when the inner
  /// [CharacterRectHover] widget's state has changed
  final void Function() stateUpdateCallback;

  const CharacterRoster({
    required this.onTap,
    required this.unlockFlags,
    required this.stateUpdateCallback,
    this.interactWhenLocked = false,
    super.key,
  });

  /// A helper function to pre-cache character portraits to avoid slow loading
  /// of portraits as the application loads the entire roster
  ///
  /// Typically called BEFORE [CharacterRoster] is rendered, so that the images
  /// will already be cached by the time it is rendered
  static Future<void> precachePortraits(BuildContext context) async {
    for (Character character in Character.values) {
      await precacheImage(
        CharacterRect.imageFromName(character.filename).image,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TGridRow.withExpandedSizes(
      mainAxisAlignment: MainAxisAlignment.center,
      horizontalSpacer: const SizedBox(width: 5),
      smFlexLimit: 4,
      mdFlexLimit: 6,
      xlFlexLimit: 8,
      uhdFlexLimit: 12,
      children: Character.values.map(
        (Character character) => TGridItem(
          child: CharacterRectHover(
            title: character.name.upperCaseFirstChar(),
            filename: character.filename,
            unlocked: unlockFlags[character.index].isUnlocked,
            onHoverTap: () async => onTap(character),
            hoverUpdateCallback: stateUpdateCallback,
            interactWhenLocked: interactWhenLocked,
          ),
        ),
      ).toList(),
    );
  }
}
