import 'package:flutter/material.dart';
import 'package:thlaby3_save_editor/widgets/character_portrait.dart';

/// A widget that displays the Rect version of a character's portrait
class CharacterBox extends CharacterPortrait {
  const CharacterBox({
    required super.filename,
    required super.title,
    required super.isHighlighted,
    super.key,
  }) : super(
    showBorderWhenNotHighlighted: false,
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.bottomCenter,
    fit: BoxFit.contain,
  );

  @override
  String get filenamePrefix => 'StandS';

  @override
  String get assetDir => 'characterBox';
}

/// A stateful version of [CharacterBox] that automatically toggles the
/// highlighted property when hovering over the box
class CharacterBoxHover extends CharacterPortraitHover {
  CharacterBoxHover({
    required super.filename,
    required super.title,
    required super.onHoverTap,
    required super.hoverUpdateCallback,
    super.hoverEnabled,
    super.key,
  }) : super(
    showBorderWhenNotHighlighted: false,
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.bottomCenter,
    fit: BoxFit.none,
    buildFunction: (BuildContext context, {required bool isHighlighted}) {
      return CharacterBox(
        filename: filename,
        title: title,
        isHighlighted: isHighlighted,
      );
    },
  );
}
