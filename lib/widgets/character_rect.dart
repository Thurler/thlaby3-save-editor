import 'package:flutter/material.dart';
import 'package:thlaby3_save_editor/widgets/character_portrait.dart';

/// A widget that displays the Rect version of a character's portrait
class CharacterRect extends CharacterPortrait {
  /// A helper function to return the [Image] instance associated with an asset
  ///
  /// Made static here to be used by precache calls
  static Image imageFromName(String filename) => Image.asset(
    'img/characterRect/RectL_$filename.png',
    fit: BoxFit.none,
    alignment: AlignmentGeometry.topCenter,
  );

  const CharacterRect({
    required super.filename,
    required super.title,
    required super.isHighlighted,
    required super.unlocked,
    super.titleAppend,
    super.key,
  }) : super(
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.topCenter,
    fit: BoxFit.none,
    widthOverride: 100,
    heightOverride: 240,
  );

  @override
  String get filenamePrefix => 'RectL';

  @override
  String get assetDir => 'characterRect';
}

/// A stateful version of [CharacterRect] that automatically toggles the
/// highlighted property when hovering over the box
class CharacterRectHover extends CharacterPortraitHover {
  CharacterRectHover({
    required super.filename,
    required super.title,
    required super.onHoverTap,
    required super.hoverUpdateCallback,
    required super.unlocked,
    super.hoverEnabled,
    super.interactWhenLocked,
    super.titleAppend,
    super.key,
  }) : super(
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.topCenter,
    fit: BoxFit.none,
    heightOverride: 240,
    buildFunction: (BuildContext context, {required bool isHighlighted}) {
      return CharacterRect(
        filename: filename,
        title: title,
        isHighlighted: isHighlighted,
        unlocked: unlocked,
        titleAppend: titleAppend,
      );
    },
  );
}
