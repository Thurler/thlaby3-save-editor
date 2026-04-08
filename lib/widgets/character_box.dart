import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';

/// A widget that displays the Rect version of a character's portrait, applying
/// a grayscale filter automtically when that character is identified as locked
class CharacterBox extends StatelessWidget {
  /// The identity matrix's red channel vector
  static const List<double> identityR = <double>[1, 0, 0, 0, 0];

  /// The identity matrix's green channel vector
  static const List<double> identityG = <double>[0, 1, 0, 0, 0];

  /// The identity matrix's blue channel vector
  static const List<double> identityB = <double>[0, 0, 1, 0, 0];

  /// The identity matrix's alpha channel vector
  static const List<double> identityA = <double>[0, 0, 0, 1, 0];

  /// The grayscale filter's transformation vector
  static const List<double> greyscaleC = <double>[0.2126, 0.7152, 0.0722, 0, 0];

  /// The identity transformation matrix
  static final ColorFilter identity = ColorFilter.matrix(
    identityR + identityG + identityB + identityA,
  );

  /// The grayscale transformation matrix
  static final ColorFilter greyscale = ColorFilter.matrix(
    greyscaleC + greyscaleC + greyscaleC + identityA,
  );

  /// A helper function to return the [Image] instance associated with an asset
  ///
  /// Used both by this widget and by precache calls
  static Image imageFromName(String filename) =>
      Image.asset('img/characterRect/RectL_$filename.png', fit: BoxFit.contain);

  /// The title to display above the character portrait, usually the character's
  /// name
  final String title;

  /// An optional widget to display next to the title
  final Widget? titleAppend;

  /// The filename to use when loading the image asset
  final String filename;

  /// Whether the box should be highlighted or not
  final bool isHighlighted;

  /// Whether the character has been unlocked or not, used to determine which
  /// image filter to use when displaying the portrait
  final bool unlocked;

  const CharacterBox({
    required this.title,
    required this.filename,
    required this.unlocked,
    required this.isHighlighted,
    this.titleAppend,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$title${titleAppend != null ? ':' : ''}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : null,
              ),
            ),
            if (titleAppend != null) titleAppend!,
          ],
        ),
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(
              width: isHighlighted ? 4 : 1,
              color: isHighlighted
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withAlpha(127),
            ),
          ),
          child: ColorFiltered(
            colorFilter: unlocked ? identity : greyscale,
            child: CharacterBox.imageFromName(filename),
          ),
        ),
      ],
    );
  }
}

/// A stateful version of [CharacterBox] that automatically toggles the
/// highlighted property when hovering over the box
class CharacterBoxHover extends StatefulWidget with THoverWidget {
  /// The title to display above the character portrait, usually the character's
  /// name
  final String title;

  /// An optional widget to display next to the title
  final Widget? titleAppend;

  /// The filename to use when loading the image asset
  final String filename;

  /// Whether the character has been unlocked or not, used to determine which
  /// image filter to use when displaying the portrait
  final bool unlocked;

  /// Whether the hover behavior should still be applied when the character is
  /// locked
  final bool interactWhenLocked;

  @override
  final bool hoverEnabled;

  @override
  final void Function() hoverUpdateCallback;

  @override
  final void Function()? onHoverTap;

  const CharacterBoxHover({
    required this.title,
    required this.filename,
    required this.unlocked,
    required this.onHoverTap,
    required this.hoverUpdateCallback,
    bool hoverEnabled = true,
    this.interactWhenLocked = false,
    this.titleAppend,
    super.key,
  }) : hoverEnabled = hoverEnabled && (unlocked || interactWhenLocked);

  @override
  State<StatefulWidget> createState() => CharacterBoxState();
}

class CharacterBoxState extends State<CharacterBoxHover>
    with THoverState<CharacterBoxHover> {
  @override
  Widget buildChild(BuildContext context) {
    return CharacterBox(
      title: widget.title,
      titleAppend: widget.titleAppend,
      filename: widget.filename,
      unlocked: widget.unlocked,
      isHighlighted: isHighlighted,
    );
  }
}
