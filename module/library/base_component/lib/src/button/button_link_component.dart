import 'package:flutter/material.dart';

import '../color/color_token.dart';
import '../container/tappable_container.dart';
import '../corner/corner_token.dart';
import '../icon/icon_component.dart';
import '../icon_position.dart';
import '../image/image_holder.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';

class ButtonLinkComponent extends StatelessWidget {

  final String text;
  final BaseLinkStyle? style;
  final bool enabled;
  final VoidCallback? onTap;
  final ImageHolder? icon;
  final double iconSize;
  final IconPosition iconPosition;
  final Key? keyButtonLink;

  static const keyValueText = "ButtonLink_Text";
  static const keyValueLeftIcon = "ButtonLink_LeftIcon";
  static const keyValueRightIcon = "ButtonLink_RightIcon";
  static const keyValueTappable = "Base_ButtonLink";

  /// [text] Button link text
  /// [style] Button link style
  /// [enabled] Button link state enabled or disabled
  /// [onTap] Button link listener
  /// [icon] Button link icon
  /// [iconSize] Button link icon size
  /// [iconPosition] Button link icon position left or right
  const ButtonLinkComponent(
    this.text, {
    Key? key,
    this.style,
    this.enabled = true,
    this.onTap,
    this.icon,
    this.iconSize = IconComponent.sizeMinor,
    this.iconPosition = IconPosition.left,
    this.keyButtonLink = const Key(keyValueTappable),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linkStyle = style ?? BaseLinkStyle.primary(
      style: TypographyToken.body14Bold()
    );
    return Tappable(
      key: keyButtonLink,
      onTap: enabled ? onTap : null,
      borderRadius: CornerToken.radius4,
      child: Padding(
        // add extra padding for better touch area component
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null && iconPosition == IconPosition.left) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconComponent.imageHolder(
                  icon,
                  color: _getColor(linkStyle),
                  size: iconSize,
                  key: const Key(keyValueLeftIcon),
                )
              )
            ],
            TextComponent(
              text,
              style: linkStyle.textStyle.apply(
                color: _getColor(linkStyle)
              ),
              key: const Key(keyValueText)
            ),
            if (icon != null && iconPosition == IconPosition.right) ...[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconComponent.imageHolder(
                  icon,
                  color: _getColor(linkStyle),
                  size: iconSize,
                  key: const Key(keyValueRightIcon),
                )
              )
            ]
          ],
        ),
      ),
    );
  }

  Color _getColor(BaseLinkStyle linkStyle) {
    if (enabled) {
      return linkStyle.textColorEnabled;
    } else {
      return linkStyle.textColorDisabled;
    }
  }
}

/// Link style for [ButtonLinkComponent] and hyperlink [TextSpan]
/// * Use [textStyle] to get the [TextStyle] from [BaseLinkStyle]
class BaseLinkStyle {
  final TextStyle textStyle;
  final TextDecoration? decoration;
  final Color textColorEnabled;
  final Color textColorDisabled;

  const BaseLinkStyle(
    this.textStyle,
    this.decoration,
    this.textColorEnabled,
    this.textColorDisabled
  );

  BaseLinkStyle apply(TextStyle style) {
    return BaseLinkStyle(
      style.apply(
        color: textColorEnabled,
        decoration: decoration
      ),
      decoration,
      textColorEnabled,
      textColorDisabled
    );
  }

  static BaseLinkStyle primary({TextStyle? style}) {
    if (style != null && style != _primary.textStyle) {
      return _primary.apply(style);
    }
    return _primary;
  }

  static BaseLinkStyle secondary({TextStyle? style}) {
    if (style != null && style != _secondary.textStyle) {
      return _secondary.apply(style);
    }
    return _secondary;
  }

  static BaseLinkStyle white({TextStyle? style}) {
    if (style != null && style != _white.textStyle) {
      return _white.apply(style);
    }
    return _white;
  }

  static final BaseLinkStyle _primary = BaseLinkStyle(
    TypographyToken.body14Bold(
      color: ColorToken.link01,
      decoration: null
    ),
    null,
    ColorToken.link01,
    ColorToken.link01Disabled
  );

  static final BaseLinkStyle _secondary = BaseLinkStyle(
    TypographyToken.body14Bold(
      color: ColorToken.textSecondary,
      decoration: TextDecoration.underline
    ),
    null,
    ColorToken.textSecondary,
    ColorToken.textDisabled
  );

  static final BaseLinkStyle _white = BaseLinkStyle(
    TypographyToken.body14Bold(
      color: ColorToken.textInverse,
      decoration: TextDecoration.underline
    ),
    null,
    ColorToken.textInverse,
    ColorToken.textDisabled
  );
}