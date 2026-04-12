import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tfields/widgets.dart';
import 'package:thlaby3_save_editor/widgets/character_trapez.dart';

class PartyHighlight extends StatefulWidget with THoverWidget {
  @override
  final bool hoverEnabled;

  @override
  final void Function() hoverUpdateCallback;

  final void Function(int) tapIndexCallback;

  const PartyHighlight({
    required this.hoverEnabled,
    required this.hoverUpdateCallback,
    required this.tapIndexCallback,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => PartyHighlightState();

  // We null this since we need custom behavior in the state
  @override
  void Function()? get onHoverTap => null;
}

class PartyHighlightState extends State<PartyHighlight>
    with THoverState<PartyHighlight>, THoverTrackerState<PartyHighlight> {
  int? _index;

  GlobalKey key = GlobalKey();

  TrapezDimensions _magic = (width: 0, height: 0, offset: 0);

  @override
  void onHoverTap() {
    int? tapIndex = _index;
    if (tapIndex != null) {
      widget.tapIndexCallback(tapIndex);
    }
  }

  @override
  void onHoverEvent(PointerHoverEvent hoverEvent) {
    Offset hoverPos = hoverEvent.localPosition;
    double heightProportion = 1 - (hoverPos.dy / _magic.height);
    double discard = (_magic.width - _magic.offset) * heightProportion;
    if (hoverPos.dx < discard) {
      setState(() {
        _index = null;
      });
      return;
    }
    int newIndex = (hoverPos.dx - discard) ~/ _magic.offset;
    if (newIndex != _index) {
      setState(() {
        _index = newIndex < 0 || newIndex > 7 ? null : newIndex;
      });
    }
  }

  @override
  Widget buildChild(BuildContext context) {
    _magic = CharacterTrapez.makeMagic(context);
    print('building $_index');
    return Material(
      key: key,
      color: Colors.transparent,
      shape: _ParallelogramShape(
        width: _magic.width,
        padding: (_index ?? 0) * _magic.offset,
        shift: _magic.offset,
        side: isHighlighted && _index != null
          ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 4)
          : BorderSide.none,
      ),
      child: SizedBox(
        width: _magic.offset * 7 + _magic.width,
        height: _magic.height,
      ),
    );
  }
}

class _ParallelogramShape extends ShapeBorder {
  final double padding;

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
