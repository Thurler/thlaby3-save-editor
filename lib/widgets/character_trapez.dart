import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thlaby3_save_editor/widgets/character_portrait.dart';

/// A struct to hold a [CharacterTrapez] width, height and offset measurements
typedef TrapezDimensions = ({double width, double height, double offset});

class ParallelogramShape extends ShapeBorder {
  final double shift; // Amount to offset the top/bottom vertices

  final double width;

  const ParallelogramShape({this.shift = 20.0, this.width = 5});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      // Top-left shifted right
      ..moveTo(rect.right - shift + width, rect.top - width)
      // Top-right
      ..lineTo(rect.right - width, rect.top - width)
      // Bottom-right shifted left
      ..lineTo(rect.left + shift - width, rect.bottom + width)
      // Bottom-left
      ..lineTo(rect.left + shift, rect.bottom + width)
      ..close();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.right - shift, rect.top) // Top-left shifted right
      ..lineTo(rect.right, rect.top) // Top-right
      ..lineTo(rect.left + shift, rect.bottom) // Bottom-right shifted left
      ..lineTo(rect.left, rect.bottom) // Bottom-left
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    Path outer = getOuterPath(rect, textDirection: textDirection);
    Path inner = getInnerPath(rect, textDirection: textDirection);
    Path borderPath = Path()
      ..addPath(outer, Offset.zero)
      ..addPath(inner, Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(borderPath, paint);
  }

  @override
  ShapeBorder scale(double t) => ParallelogramShape(shift: shift * t);
}

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

  @override
  Decoration buildDecoration(BuildContext context) {
    return ShapeDecoration(
      shape: ParallelogramShape(shift: makeMagic(context).offset),
      color: isHighlighted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withAlpha(127),
    );
  }
}

/// A stateful version of [CharacterTrapez] that automatically toggles the
/// highlighted property when hovering over the box
class CharacterTrapezHover extends CharacterPortraitHover {
  CharacterTrapezHover({
    required super.filename,
    required super.title,
    required super.onHoverTap,
    required super.hoverUpdateCallback,
    super.hoverEnabled,
    super.key,
  }) : super(
    showBorderWhenNotHighlighted: false,
    titleDirection: VerticalDirection.up,
    alignment: AlignmentGeometry.topRight,
    fit: BoxFit.none,
    buildFunction: (BuildContext context, {required bool isHighlighted}) {
      return CharacterTrapez(
        filename: filename,
        title: title,
        isHighlighted: isHighlighted,
      );
    },
  );
}
