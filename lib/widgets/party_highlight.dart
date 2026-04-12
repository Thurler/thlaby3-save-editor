import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/widgets/character_trapez.dart';

/// A widget to control the highlight logic for [CharacterTrapez] widgets laid
/// on top of one another
///
/// Because this is only ever helpful when rendering the back party slots, the
/// logic here will hardcode offsets for 8 slots only
class PartyHighlight extends StatefulWidget with THoverWidget {
  /// The function to call when a specific portrait index is clicked on
  final void Function(int) tapIndexCallback;

  const PartyHighlight({
    required this.tapIndexCallback,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => PartyHighlightState();

  // We null this since we need custom behavior in the state
  @override
  void Function()? get onHoverTap => null;

  // We nop this since we don't need to propagate calls upwards
  @override
  void Function() get hoverUpdateCallback => () {};

  // We can set this to always true since it is the purpose of this widget
  @override
  bool get hoverEnabled => true;
}

class PartyHighlightState extends State<PartyHighlight>
    with THoverState<PartyHighlight>, THoverTrackerState<PartyHighlight> {
  /// The index we are currently hovering on
  int? _index;

  /// The previously known screen width
  double? _previousWidth;

  /// The cached [TrapezDimensions] for magic responsive computations
  late TrapezDimensions _magic;

  /// The cahced [Material] widgets that will be rendered for each index, to
  /// avoid recomputing them every frame
  late List<Material> _materials;

  /// Updates the cached data if the screen width has changed from the previous
  /// known value
  void _recomputeMaterials() {
    // If same as previous known width, abort
    double width = MediaQuery.of(context).size.width;
    if (width == _previousWidth) {
      return;
    }
    // Otherwise, update all cached values
    _previousWidth = width;
    _magic = CharacterTrapez.makeMagic(context);
    _materials = List<Material>.generate(
      8,
      (int i) => Material(
        color: Colors.transparent,
        shape: _ParallelogramShape(
          width: _magic.width,
          padding: i * _magic.offset,
          shift: _magic.offset,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 4,
          ),
        ),
        child: SizedBox(
          width: _magic.offset * 7 + _magic.width,
          height: _magic.height,
        ),
      ),
      growable: false,
    );
  }

  /// Update the currently hovered index based on hover offset position
  void _updateIndex(Offset? position) {
    // If we don't have a hover position, force to null
    if (position == null) {
      _index = null;
      return;
    }
    // Get the Y offset as a percentage of the height
    double heightProportion = 1 - (position.dy / _magic.height);
    // Get the X offset for the first valid index
    double discard = (_magic.width - _magic.offset) * heightProportion;
    // If we are in the blank space before the first index, force to null
    if (position.dx < discard) {
      _index = null;
      return;
    }
    // Each index occupies [offset] pixels, so we can just divide the coordinate
    // by the offset to get the index
    int newIndex = (position.dx - discard) ~/ _magic.offset;
    if (newIndex != _index) {
      // Make sure we have a valid index in the [0-7] range
      _index = newIndex < 0 || newIndex > 7 ? null : newIndex;
    }
  }

  @override
  void onHoverTap() {
    // If we have a valid index on hover, call the callback on it
    int? tapIndex = _index;
    if (tapIndex != null) {
      widget.tapIndexCallback(tapIndex);
    }
  }

  @override
  Widget buildChild(BuildContext context) {
    // Update our cache values, if necessary
    _recomputeMaterials();
    // Update the index position every frame
    _updateIndex(hoverPosition);
    // If something is highlighted, draw the appropriate material on top
    return isHighlighted && _index != null
      ? _materials[_index ?? 0]
      : SizedBox(
          width: _magic.offset * 7 + _magic.width,
          height: _magic.height,
        );
  }
}

/// A custom [ShapeBorder] that draws a parallelogram border
class _ParallelogramShape extends ShapeBorder {
  /// The left padding to account for when drawing the border
  final double padding;

  /// The width to consider when drawing the border - we do not trust
  /// [Rect.right] in the render calls
  final double width;

  /// Amount to offset the top/bottom vertices
  final double shift;

  /// The border data to use when painting the highlight
  final BorderSide side;

  const _ParallelogramShape({
    required this.width,
    required this.shift,
    this.padding = 0,
    this.side = BorderSide.none,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect.deflate(side.width), textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      // Top-left shifted right
      ..moveTo(padding + rect.left + width - shift, rect.top)
      // Top-right
      ..lineTo(padding + rect.left + width, rect.top)
      // Bottom-right shifted left
      ..lineTo(padding + rect.left + shift, rect.bottom)
      // Bottom-left
      ..lineTo(padding + rect.left, rect.bottom)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none) {
      return;
    }
    canvas.drawPath(
      getOuterPath(rect, textDirection: textDirection),
      side.toPaint(),
    );
  }

  @override
  ShapeBorder scale(double t) => _ParallelogramShape(
    shift: shift * t,
    width: width * t,
    side: side.scale(t),
  );
}
