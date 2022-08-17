import 'package:flutter/material.dart';

import '../../color/color_token.dart';
import 'snackbar_component.dart';

class Snackbar {
  static void showError(BuildContext context, String text, {Key? key}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          key: key,
          padding: const EdgeInsets.all(12),
          content: SnackbarComponent(text),
          backgroundColor: ColorToken.backgroundError01,
          behavior: SnackBarBehavior.floating,
          duration: _getDuration(text)),
    );
  }

  static void showNeutral(BuildContext context, String text,
      {Key? key, String? action, VoidCallback? onActionTap}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          key: key,
          padding: const EdgeInsets.all(12),
          content: SnackbarComponent(text, action: action, onActionTap: onActionTap),
          backgroundColor: ColorToken.backgroundHigh,
          behavior: SnackBarBehavior.floating,
          duration: _getDuration(text)),
    );
  }

  static Duration _getDuration(String text) {
    // snackbar duration automatically set based on text length
    return text.length <= 40
        ? const Duration(milliseconds: 2000)
        : const Duration(milliseconds: 3200);
  }
}
