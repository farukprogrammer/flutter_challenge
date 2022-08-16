import 'package:flutter/material.dart';

import '../typography/typography_token.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final TextSpan? textSpan;
  final TextStyle? style;
  final bool textSelectable;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final String? semanticsLabel;

  static TextStyle defaultStyle = TypographyToken.body14();

  /// Normal text without spannable text support
  const TextComponent(
    this.text, {
    this.style,
    Key? key,
    this.textSelectable = false,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines = 1000,
    this.semanticsLabel,
  })  : textSpan = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final span = textSpan;
    final textStyle = style ?? defaultStyle;

    if (textSelectable) {
      // At the moment unable to change selectable text highlight color
      // related with this issue https://github.com/flutter/flutter/issues/74890
      // Todo: fix the issue later

      if (span != null) {
        // spannable text with selection support
        return SelectableText.rich(
          span,
          style: textStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
      }

      // normal text with selection support
      return SelectableText(
        text,
        style: textStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
    }

    if (span != null) {
      if (style != null) {
        // spannable text (simplified) no selection support
        return Text.rich(
          span,
          style: textStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
      }

      // spannable text (advanced styling) no selection support
      return RichText(
        text: span,
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
      );
    }

    // normal text (no spannable and selection support)
    return Text(
      text,
      maxLines: maxLines,
      style: textStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
    );
  }

  /// With spannable text support [TextSpan]
  /// * Return [RichText] when [style] is null
  /// * Return [Text.rich] when [style] is not null
  const TextComponent.rich(
    this.textSpan, {
    Key? key,
    this.style,
    this.textSelectable = false,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLines = 1000,
    this.semanticsLabel,
  })  : text = "",
        super(key: key);

}