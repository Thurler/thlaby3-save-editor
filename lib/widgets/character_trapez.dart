import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thlaby3_save_editor/widgets/character_portrait.dart';

/// A struct to hold a [CharacterTrapez] width, height and offset measurements
typedef TrapezDimensions = ({double width, double height, double offset});

/// A widget that displays the Rect version of a character's portrait
class CharacterTrapez extends CharacterPortrait {
  /// The portrait width
  static const double width = 304;

  /// The portrait height
  static const double height = 540;

  /// The parallellogram offset
  static const double offset = 159;

  /// Responsive magic for resizing stacking Trapez portraits
  static TrapezDimensions makeMagic(BuildContext context) {
    double magicWidth = min(MediaQuery.of(context).size.width / 8, width);
    return (
      width: magicWidth,
      height: height * magicWidth / width,
      offset: offset * magicWidth / width,
    );
  }

  const CharacterTrapez({
    required super.filename,
    required super.title,
    required super.isHighlighted,
    super.key,
  }) : super(
    showBorderWhenNotHighlighted: false,
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.topRight,
    fit: BoxFit.contain,
  );

  @override
  String get filenamePrefix => 'Trapez';

  @override
  String get assetDir => 'characterTrapez';
}
