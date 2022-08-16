import 'package:flutter/material.dart';

import '../color/color_token.dart';

const _bukaSansDisplay = 'BukaSansDisplay';
const _bukaSansText = 'BukaSansText';

class TypographyToken {
  TypographyToken._();

  static TextStyle caption08({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption08;
    if (color == _caption08.color && decoration == _caption08.decoration) {
      return _caption08;
    }
    return _caption08.apply(color: color, decoration: decoration);
  }

  static TextStyle caption10({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption10;
    if (color == _caption10.color && decoration == _caption10.decoration) {
      return _caption10;
    }
    return _caption10.apply(color: color, decoration: decoration);
  }

  static TextStyle caption10Medium({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption10Medium;
    if (color == _caption10Medium.color &&
        decoration == _caption10Medium.decoration) {
      return _caption10Medium;
    }
    return _caption10Medium.apply(color: color, decoration: decoration);
  }

  static TextStyle caption10Bold({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption10Bold;
    if (color == _caption10Bold.color &&
        decoration == _caption10Bold.decoration) {
      return _caption10Bold;
    }
    return _caption10Bold.apply(color: color, decoration: decoration);
  }

  static TextStyle caption12({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption12;
    if (color == _caption12.color && decoration == _caption12.decoration) {
      return _caption12;
    }
    return _caption12.apply(color: color, decoration: decoration);
  }

  static TextStyle caption12Medium({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption12Medium;
    if (color == _caption12Medium.color &&
        decoration == _caption12Medium.decoration) {
      return _caption12Medium;
    }
    return _caption12Medium.apply(color: color, decoration: decoration);
  }

  static TextStyle caption12Bold({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _caption12Bold;
    if (color == _caption12Bold.color &&
        decoration == _caption12Bold.decoration) {
      return _caption12Bold;
    }
    return _caption12Bold.apply(color: color, decoration: decoration);
  }

  static TextStyle body14({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _body14;
    if (color == _body14.color && decoration == _body14.decoration) {
      return _body14;
    }
    return _body14.apply(color: color, decoration: decoration);
  }

  static TextStyle body14Bold({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _body14Bold;
    if (color == _body14Bold.color && decoration == _body14Bold.decoration) {
      return _body14Bold;
    }
    return _body14Bold.apply(color: color, decoration: decoration);
  }

  static TextStyle body16({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _body16;
    if (color == _body16.color && decoration == _body16.decoration) {
      return _body16;
    }
    return _body16.apply(color: color, decoration: decoration);
  }

  static TextStyle body16Bold({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _body16Bold;
    if (color == _body16Bold.color && decoration == _body16Bold.decoration) {
      return _body16Bold;
    }
    return _body16Bold.apply(color: color, decoration: decoration);
  }

  static TextStyle subheading18({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _subheading18;
    if (color == _subheading18.color &&
        decoration == _subheading18.decoration) {
      return _subheading18;
    }
    return _subheading18.apply(color: color, decoration: decoration);
  }

  static TextStyle subheading20({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _subheading20;
    if (color == _subheading20.color &&
        decoration == _subheading20.decoration) {
      return _subheading20;
    }
    return _subheading20.apply(color: color, decoration: decoration);
  }

  static TextStyle heading24({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _heading24;
    if (color == _heading24.color && decoration == _heading24.decoration) {
      return _heading24;
    }
    return _heading24.apply(color: color, decoration: decoration);
  }

  static TextStyle heading28({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _heading28;
    if (color == _heading28.color && decoration == _heading28.decoration) {
      return _heading28;
    }
    return _heading28.apply(color: color, decoration: decoration);
  }

  static TextStyle heading32({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _heading32;
    if (color == _heading32.color && decoration == _heading32.decoration) {
      return _heading32;
    }
    return _heading32.apply(color: color, decoration: decoration);
  }

  static TextStyle heading42({Color? color, TextDecoration? decoration}) {
    if (color == null && decoration == null) return _heading42;
    if (color == _heading42.color && decoration == _heading42.decoration) {
      return _heading42;
    }
    return _heading42.apply(color: color, decoration: decoration);
  }

  static final TextStyle _caption08 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 8,
    fontWeight: FontWeight.w500,
    color: ColorToken.textSecondary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption10 = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 10,
    color: ColorToken.textSecondary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption10Medium = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption10Bold = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption12 = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 12,
    color: ColorToken.textSecondary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption12Medium = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _caption12Bold = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle _body14 = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 14,
    color: ColorToken.textSecondary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _body14Bold = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _body16 = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 16,
    color: ColorToken.textSecondary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _body16Bold = TextStyle(
    fontFamily: _bukaSansText,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle _subheading18 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _subheading20 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static final TextStyle _heading24 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _heading28 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _heading32 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static final TextStyle _heading42 = TextStyle(
    fontFamily: _bukaSansDisplay,
    fontSize: 42,
    fontWeight: FontWeight.w500,
    color: ColorToken.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
}
