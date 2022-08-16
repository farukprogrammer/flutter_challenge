import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color/color_token.dart';
import '../corner/corner_token.dart';
import '../text/text_component.dart';
import '../typography/typography_token.dart';

class BadgeGeneralComponent extends StatelessWidget {
  final int badgeCount;
  final BaseBadgeStyle? style;
  final BaseBadgeBorderStyle? borderStyle;
  final double _badgeSize;

  static const keyValueBadgeGeneral = "Base_BadgeGeneral";
  static const keyValueBadgeGeneralText = "BadgeGeneral_Text";

  static const double _sizeMedium = 20;
  static const double _sizeRegular = 18;
  static const double _sizeDot = 12;
  static const String badgeMax = "99+";

  const BadgeGeneralComponent.regular(
    this.badgeCount, {
    Key? key = const Key(keyValueBadgeGeneral),
    this.style,
    this.borderStyle
  }) : _badgeSize = _sizeRegular, super(key: key);

  const BadgeGeneralComponent.medium(
    this.badgeCount, {
    Key? key = const Key(keyValueBadgeGeneral),
    this.style,
    this.borderStyle
  }) : _badgeSize = _sizeMedium, super(key: key);

  const BadgeGeneralComponent.dot({
    Key? key = const Key(keyValueBadgeGeneral),
    this.style,
    this.borderStyle
  }) : _badgeSize = _sizeDot, badgeCount = 0, super(key: key);

  @override
  Widget build(BuildContext context) {
    final badgeStyle = style ?? BaseBadgeStyle.primary;
    final badgeBorderStyle = borderStyle ?? BaseBadgeBorderStyle.light;
    final borderColor = badgeBorderStyle.borderColor;
    final border = borderColor != null ? BoxDecoration(
      color: borderColor,
      border: Border.all(color: borderColor, width: badgeBorderStyle.borderSize),
      borderRadius: CornerToken.radiusCircle
    ) : null;

    if (border != null && badgeBorderStyle.borderSize > 0) {
      return Container(
        height: _badgeSize,
        decoration: border,
        constraints: _getBadgeSize(),
        child: Container(
          decoration: BoxDecoration(
            color: badgeStyle.color,
            borderRadius: CornerToken.radiusCircle
          ),
          alignment: Alignment.center,
          child: _badgeSize == _sizeDot ?
            _getBadgeDot() : _getBadgeText(badgeStyle),
        )
      );
    }
    return Container(
      height: _badgeSize,
      decoration: BoxDecoration(
        color: badgeStyle.color,
        borderRadius: CornerToken.radiusCircle
      ),
      constraints: _getBadgeSize(),
      alignment: Alignment.center,
      child: _badgeSize == _sizeDot ?
        _getBadgeDot() : _getBadgeText(badgeStyle),
    );
  }

  BoxConstraints _getBadgeSize() {
    if (badgeCount < 10) {
      return BoxConstraints(
        minHeight: _badgeSize,
        minWidth: _badgeSize,
        maxWidth: _badgeSize
      );
    }

    // horizontal padding = 5, total 10 (left 5 and right 5)
    const padding = 10;
    final maxWidth = _badgeSize + padding;
    return BoxConstraints(
      minHeight: _badgeSize,
      minWidth: _badgeSize,
      maxWidth: maxWidth
    );
  }

  Widget _getBadgeDot() {
    return const SizedBox.shrink(key: Key(keyValueBadgeGeneralText));
  }

  Widget _getBadgeText(BaseBadgeStyle style) {
    final count = _getBadgeCount();
    final textStyle = _badgeSize == _sizeMedium
      ? TypographyToken.caption12Medium(color: style.textColor)
      : TypographyToken.caption10Medium(color: style.textColor);
    return TextComponent(
      count,
      key: const Key(keyValueBadgeGeneralText),
      style: textStyle,
      textAlign: TextAlign.center
    );
  }

  String _getBadgeCount() {
    if (badgeCount >= 100) return badgeMax;
    if (badgeCount <= 0) return "";
    return "$badgeCount";
  }
}

class BaseBadgeStyle {
  final Color color;
  final Color textColor;

  const BaseBadgeStyle(this.color, this.textColor);
  
  static final BaseBadgeStyle primary =
    BaseBadgeStyle(ColorToken.brand01, ColorToken.textInverse);

  static final BaseBadgeStyle secondary =
    BaseBadgeStyle(ColorToken.backgroundAttention, ColorToken.textInverse);

  static final BaseBadgeStyle whiteActive =
    BaseBadgeStyle(ColorToken.theBackground, ColorToken.textInformational02);
}

class BaseBadgeBorderStyle {
  final double borderSize;
  final Color? borderColor;

  const BaseBadgeBorderStyle(this.borderSize, this.borderColor);

  static final BaseBadgeBorderStyle light =
    BaseBadgeBorderStyle(2, ColorToken.borderInverse);

  static final BaseBadgeBorderStyle dark =
    BaseBadgeBorderStyle(2, ColorToken.borderForeground);

  static BaseBadgeBorderStyle adaptive(Color borderColor) {
    return BaseBadgeBorderStyle(2, borderColor);
  }
}