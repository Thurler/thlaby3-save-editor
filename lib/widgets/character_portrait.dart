import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';

/// A widget that displays a character's portrait, applying a grayscale filter
/// automtically when that character is identified as locked
abstract class CharacterPortrait extends StatelessWidget {
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

  /// The filename suffix associated with the asset
  final String filename;

  /// How the image is supposed to fit into containers
  final BoxFit fit;

  /// How the image is supposed to align itself in containers
  final AlignmentGeometry alignment;

  /// The title to display by the character portrait, usually the character's
  /// name
  final String title;

  /// Whether the title should be positioned above or below the portrait
  final VerticalDirection titleDirection;

  /// An optional widget to display next to the title
  final Widget? titleAppend;

  /// Whether the box should be highlighted or not
  final bool isHighlighted;

  /// Whether the character has been unlocked or not, used to determine which
  /// image filter to use when displaying the portrait
  final bool unlocked;

  /// Override the width of the image asset
  final double? widthOverride;

  /// Override the height of the image asset
  final double? heightOverride;

  /// Whether a border will be drawn around the portrait when it is not being
  /// highlighted
  final bool showBorderWhenNotHighlighted;

  const CharacterPortrait({
    required this.filename,
    required this.title,
    required this.titleDirection,
    required this.isHighlighted,
    this.fit = BoxFit.none,
    this.alignment = AlignmentGeometry.center,
    this.unlocked = true,
    this.showBorderWhenNotHighlighted = true,
    this.titleAppend,
    this.widthOverride,
    this.heightOverride,
    super.key,
  });

  /// The asset directory associated with the asset
  String get assetDir;

  /// The filename prefix associated with the asset
  String get filenamePrefix;

  /// A getter that returns the image instance associated with this portrait
  Image get image => Image.asset(
    'img/$assetDir/${filenamePrefix}_$filename.png',
    fit: fit,
    alignment: alignment,
  );

  /// Builds the decoration for the decorated box that houses the portrait
  Decoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        width: isHighlighted ? 4 : 1,
        color: isHighlighted
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface.withAlpha(127),
      ),
    );
  }

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    Image imageWidget = image;
    Widget titleWidget = Row(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$title${titleAppend != null ? ':' : ''}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isHighlighted ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
        if (titleAppend != null) titleAppend!,
      ],
    );
    return Column(
      children: <Widget>[
        if (titleDirection == VerticalDirection.up) titleWidget,
        SizedBox(
          width: widthOverride ?? imageWidget.width,
          height: heightOverride ?? imageWidget.height,
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: showBorderWhenNotHighlighted || isHighlighted
              ? buildDecoration(context)
              : const BoxDecoration(),
            child: ColorFiltered(
              colorFilter: unlocked ? identity : greyscale,
              child: imageWidget,
            ),
          ),
        ),
        if (titleDirection == VerticalDirection.down) titleWidget,
      ],
    );
  }
}

/// A stateful version of [CharacterPortrait] that automatically toggles the
/// highlighted property when hovering over the box
class CharacterPortraitHover extends StatefulWidget with THoverWidget {
  /// The filename suffix associated with the asset
  final String filename;

  /// How the image is supposed to fit into containers
  final BoxFit fit;

  /// How the image is supposed to align itself in containers
  final AlignmentGeometry alignment;

  /// The title to display by the character portrait, usually the character's
  /// name
  final String title;

  /// Whether the title should be positioned above or below the portrait
  final VerticalDirection titleDirection;

  /// An optional widget to display next to the title
  final Widget? titleAppend;

  /// Whether the character has been unlocked or not, used to determine which
  /// image filter to use when displaying the portrait
  final bool unlocked;

  /// Override the width of the image asset
  final double? widthOverride;

  /// Override the height of the image asset
  final double? heightOverride;

  /// Whether the hover behavior should still be applied when the character is
  /// locked
  final bool interactWhenLocked;

  /// Whether a border will be drawn around the portrait when it is not being
  /// highlighted
  final bool showBorderWhenNotHighlighted;

  /// The function that builds the stateless version of this widget
  final CharacterPortrait Function(
    BuildContext context, {
    required bool isHighlighted,
  }) buildFunction;

  @override
  final bool hoverEnabled;

  @override
  final void Function() hoverUpdateCallback;

  @override
  final void Function()? onHoverTap;

  const CharacterPortraitHover({
    required this.filename,
    required this.title,
    required this.titleDirection,
    required this.onHoverTap,
    required this.hoverUpdateCallback,
    required this.buildFunction,
    bool hoverEnabled = true,
    this.fit = BoxFit.none,
    this.alignment = AlignmentGeometry.center,
    this.interactWhenLocked = false,
    this.showBorderWhenNotHighlighted = true,
    this.unlocked = true,
    this.titleAppend,
    this.widthOverride,
    this.heightOverride,
    super.key,
  }) : hoverEnabled = hoverEnabled && (unlocked || interactWhenLocked);

  @override
  State<StatefulWidget> createState() => _CharacterRectState();
}

class _CharacterRectState extends State<CharacterPortraitHover>
    with THoverState<CharacterPortraitHover> {
  @override
  Widget buildChild(BuildContext context) {
    return widget.buildFunction(context, isHighlighted: isHighlighted);
  }
}
