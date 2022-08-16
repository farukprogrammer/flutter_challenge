import 'dart:ui';

import 'base_color.dart';

class ColorToken {
  ColorToken._();

  // Link color token
  static Color get link01 => BaseColor.navy[50] ?? BaseColor.navy;
  static Color get link01Inverse => BaseColor.navy[20] ?? BaseColor.navy;
  static Color get link01Disabled => BaseColor.navy[20] ?? BaseColor.navy;
  static Color get link01Pressed => BaseColor.navy[70] ?? BaseColor.navy;

  // Text color token
  static Color get textAttention01 => BaseColor.yellow[100] ?? BaseColor.yellow;
  static Color get textBrand01 => BaseColor.crimson[50] ?? BaseColor.crimson;
  static Color get textDisabled => disabled03;
  static Color get textError01 => danger50;
  static Color get textError02 => BaseColor.red[90] ?? BaseColor.red;
  static Color get textHighlight01 => highlight50;
  static Color get textInformational01 => informational50;
  static Color get textInformational02 => BaseColor.navy[40] ?? BaseColor.navy;
  static Color get textInverse => inverse01;
  static Color get textPrimary => BaseColor.gray[100] ?? BaseColor.gray;
  static Color get textSecondary => BaseColor.gray[80] ?? BaseColor.gray;
  static Color get textSubdued => BaseColor.gray[50] ?? BaseColor.gray;
  static Color get textSuccess01 => success50;
  static Color get textSuccess02 => success30;
  static Color get textWarning01 => warning50;
  static Color get textWarning02 => BaseColor.orange[100] ?? BaseColor.orange;

  // Background color token
  static Color get backgroundActive => focus;
  static Color get backgroundActivePressed01 => BaseColor.navy[70] ?? BaseColor.navy;
  static Color get backgroundAttention => BaseColor.yellow[80] ?? BaseColor.yellow;
  static Color get backgroundDanger01 => danger10;
  static Color get backgroundDanger02 => BaseColor.red[0] ?? BaseColor.red;
  static Color get backgroundDisabled => disabled01;
  static Color get backgroundError01 => BaseColor.red[70] ?? BaseColor.red;
  static Color get backgroundHigh => ui06;
  static Color get backgroundHighlight01 => highlight10;
  static Color get backgroundInformational01 => informational10;
  static Color get backgroundInformational02 => BaseColor.navy[10] ?? BaseColor.navy;
  static Color get backgroundInformational03 => BaseColor.navy[40] ?? BaseColor.navy;
  static Color get backgroundLow => ui03;
  static Color get backgroundMedium => ui05;
  static Color get backgroundMedium02 => BaseColor.gray[70] ?? BaseColor.gray;
  static Color get backgroundMedium03 => BaseColor.gray[80] ?? BaseColor.gray;
  static Color get backgroundOverlay01 => BaseColor.gray[100]?.withOpacity(0.5) ??
      BaseColor.gray.withOpacity(0.5);
  static Color get backgroundOverlay02 => BaseColor.grape[100]?.withOpacity(0.13) ??
      BaseColor.grape.withOpacity(0.13);
  static Color get backgroundOverlay03 => BaseColor.gray[100]?.withOpacity(0.05) ??
      BaseColor.gray.withOpacity(0.05);
  static Color get backgroundPlayfulDisabled02 => BaseColor.crimson[20] ?? BaseColor.crimson;
  static Color get backgroundPlayfulPressed01 => BaseColor.crimson[70] ?? BaseColor.crimson;
  static Color get backgroundSubtle => ui01;
  static Color get backgroundSuccess01 => success10;
  static Color get backgroundSuccess02 => BaseColor.green[10] ?? BaseColor.green;
  static Color get backgroundSuccess03 => BaseColor.green[50] ?? BaseColor.green;
  static Color get backgroundWarning01 => warning10;
  static Color get backgroundWarning02 => BaseColor.orange[10] ?? BaseColor.orange;
  static Color get backgroundWashedout => BaseColor.gray[0] ?? BaseColor.gray;
  static Color get brand01 => BaseColor.crimson[50] ?? BaseColor.crimson;
  static Color get brand02 => BaseColor.grape[70] ?? BaseColor.grape;
  static Color get theBackground => BaseColor.systemWhite;
  static Color get theForeground => BaseColor.gray[100] ?? BaseColor.gray;

  // State color token
  static Color get disabled01 => BaseColor.gray[05] ?? BaseColor.gray;
  static Color get disabled02 => BaseColor.gray[10] ?? BaseColor.gray;
  static Color get disabled03 => BaseColor.gray[40] ?? BaseColor.gray;
  static Color get focus => BaseColor.navy[50] ?? BaseColor.gray;
  static Color get inverse01 => BaseColor.systemWhite;
  static Color get inverse02 =>  BaseColor.gray[0] ?? BaseColor.gray;
  static Color get danger10 => BaseColor.red[05] ?? BaseColor.red;
  static Color get danger50 => BaseColor.red[60] ?? BaseColor.red;
  static Color get highlight10 => BaseColor.crimson[05] ?? BaseColor.crimson;
  static Color get highlight50 => BaseColor.crimson[60] ?? BaseColor.crimson;

  // Semantic color token
  static Color get informational10 => BaseColor.navy[05] ?? BaseColor.navy;
  static Color get informational20 => BaseColor.navy[30] ?? BaseColor.navy;
  static Color get informational50 => BaseColor.navy[90] ?? BaseColor.navy;
  static Color get success10 => BaseColor.green[05] ?? BaseColor.green;
  static Color get success30 => BaseColor.green[60] ?? BaseColor.green;
  static Color get success50 => BaseColor.green[90] ?? BaseColor.green;
  static Color get warning10 => BaseColor.orange[05] ?? BaseColor.orange;
  static Color get warning20 => BaseColor.orange[40] ?? BaseColor.orange;
  static Color get warning30 => BaseColor.orange[60] ?? BaseColor.orange;
  static Color get warning50 => BaseColor.orange[90] ?? BaseColor.orange;

  // Ui color token
  static Color get ui01 => BaseColor.gray[05] ?? BaseColor.gray;
  static Color get ui02 => BaseColor.gray[10] ?? BaseColor.gray;
  static Color get ui03 => BaseColor.gray[20] ?? BaseColor.gray;
  static Color get ui04 => BaseColor.gray[30] ?? BaseColor.gray;
  static Color get ui05 => BaseColor.gray[50] ?? BaseColor.gray;
  static Color get ui06 => BaseColor.gray[90] ?? BaseColor.gray;

  // Border color token
  static Color get borderDisabled => disabled02;
  static Color get borderError01 => danger50;
  static Color get borderFocus => focus;
  static Color get borderForeground => BaseColor.gray[100] ?? BaseColor.gray;
  static Color get borderHigh => ui05;
  static Color get borderInformational01 => informational20;
  static Color get borderInverse => inverse01;
  static Color get borderLow => ui03;
  static Color get borderMedium => ui04;
  static Color get borderSubtle => ui02;
  static Color get borderSuccess01 => BaseColor.green[50] ?? BaseColor.green;
  static Color get borderWarning01 => warning20;
  static Color get interactive01 => BaseColor.navy[50] ?? BaseColor.navy;

  // Icon color token
  static Color get iconActive => BaseColor.navy[50] ?? BaseColor.navy;
  static Color get iconAttention01 => BaseColor.yellow[80] ?? BaseColor.yellow;
  static Color get iconDisabled => BaseColor.gray[40] ?? BaseColor.gray;
  static Color get iconHighlight => highlight50;
  static Color get iconInformation01 => informational20;
  static Color get iconInverse => inverse02;
  static Color get iconPrimary => ui06;
  static Color get iconSecondary => BaseColor.gray[80] ?? BaseColor.gray;
  static Color get iconSubdued => BaseColor.gray[50] ?? BaseColor.gray;
  static Color get iconSuccess => success30;
  static Color get iconWarning01 => warning30;

  // Expressive background color token
  static Color get backgroundElegant01 => BaseColor.brandJadeGreen;
  static Color get backgroundElegant02 => BaseColor.brandCucumber;
  static Color get backgroundEnergetic01 => BaseColor.grape[70] ?? BaseColor.grape;
  static Color get backgroundEnergetic02 => BaseColor.grape[05] ?? BaseColor.grape;
  static Color get backgroundPlayful01 => BaseColor.crimson[50] ?? BaseColor.crimson;
  static Color get backgroundPlayful02 => BaseColor.brandLightPink;
  static Color get backgroundWarm01 => BaseColor.orange[10] ?? BaseColor.orange;
  static Color get backgroundWarm02 => BaseColor.systemOffWhite;
}