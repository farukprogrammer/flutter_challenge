import 'package:flutter/material.dart';

/// A Widget replacement for [Focus]
class Focusable extends StatelessWidget {
  final Widget child;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ValueChanged<bool>? onFocusChange;
  final bool? _canRequestFocus;
  final bool? _descendantsAreFocusable;

  const Focusable({
    Key? key,
    required this.child,
    this.focusNode,
    this.autoFocus = false,
    this.onFocusChange,
    bool? canRequestFocus,
    bool? descendantsAreFocusable,
  }) : _canRequestFocus = canRequestFocus,
      _descendantsAreFocusable = descendantsAreFocusable,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      autofocus: autoFocus,
      onFocusChange: (focused) {
        onFocusChange?.call(focused);
      },
      canRequestFocus: _canRequestFocus,
      descendantsAreFocusable: _descendantsAreFocusable,
      child: child,
    );
  }
}