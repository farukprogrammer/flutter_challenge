import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A widget replacement for [InkWell] or [gestureDetector]
class Tappable extends StatelessWidget {
  // InkWell and GestureDetector states & events
  final Widget? child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;

  // GestureDetector states & events
  final GestureTapUpCallback? onTapUp;
  final GestureTapDownCallback? onTapDown;
  final GestureTapDownCallback? onDoubleTapDown;
  final GestureLongPressDownCallback? onLongPressDown;
  final GestureDragEndCallback? onPanEnd;
  final GestureDragUpdateCallback? onPanUpdate;

  // InkWell states & events
  final BorderRadius? borderRadius;
  final bool _shouldUseInkWell;

  /// Trackable [InkWell]
  const Tappable({
    Key? key,
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.borderRadius,
  }) : _shouldUseInkWell = true,
      onTapUp = null,
      onTapDown = null,
      onDoubleTapDown = null,
      onLongPressDown = null,
      onPanEnd = null,
      onPanUpdate = null,
      super(key: key);

  /// Trackable [GestureDetector]
  /// Currently limited for some gesture based on current needs.
  const Tappable.gestureDetector({
    Key? key,
    this.child,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onDoubleTap,
    this.onDoubleTapDown,
    this.onLongPress,
    this.onLongPressDown,
    this.onPanEnd,
    this.onPanUpdate,
  }) : _shouldUseInkWell = false, borderRadius = null, super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_shouldUseInkWell) {
      return InkWell(
        borderRadius: borderRadius,
        onTap: _onTap,
        onDoubleTap: _onDoubleTap,
        onLongPress: _onLongPress,
        child: child,
      );
    }

    return GestureDetector(
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      onTap: (onTap == null && onTapUp == null && onTapDown == null)
          ? null
          : () {
              // Since all events of single tap (onTap, onTapUp, onTapDown & onTapCancel)
              // will trigger onTap, so tracker is implemented here,
              // to achieve just to send single UserEvent.click.
              // If other event is added, then the condition above should be updated.
              onTap?.call();
            },
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTap: (onDoubleTap == null && onDoubleTapDown == null)
          ? null
          : () {
              // since all events of double tap (onDoubleTap, onDoubleTapDown & onDoubleTapCancel)
              // will trigger onDoubleTap, so tracker is implemented here,
              // to achieve just to send single UserEvent.doubleClick.
              // If other event is added, then the condition above should be updated.
              onDoubleTap?.call();
            },
      onLongPressDown: onLongPressDown,
      onLongPress: (onLongPress == null && onLongPressDown == null)
          ? null
          : () {
              // since all events of long press (onLongPress, onLongPressDown, onLongPressUp, onLongPressStart, etc)
              // will trigger onLongPress, so tracker is implemented here,
              // to achieve just to send single UserEvent.doubleClick.
              // If other event is added, then the condition above should be updated.
              onLongPress?.call();
            },
      onPanUpdate: onPanUpdate,
      onPanEnd: (onPanEnd == null && onPanUpdate == null)
          ? null
          : (value) {
              // since all events of pan gesture (onPanDown, onPanStart, onPanUpdate & onPanCancel)
              // will trigger onPanEnd, so tracker is implemented here,
              // to achieve just to send single UserEvent.click.
              // If other event is added, then the condition above should be updated.
              onPanEnd?.call(value);
            },
      child: child,
    );
  }

  GestureTapCallback? get _onTap => onTap != null ? _tap : null;

  GestureTapCallback? get _onDoubleTap => onDoubleTap != null ? _doubleTap : null;

  GestureLongPressCallback? get _onLongPress => onLongPress != null ? _longPress : null;

  void _tap() {
    onTap?.call();
  }

  void _doubleTap() {
    onDoubleTap?.call();
  }

  void _longPress() {
    onLongPress?.call();
  }
}
