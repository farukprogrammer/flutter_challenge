import 'package:flutter/widgets.dart';

class CornerToken extends BorderRadius {
  final Radius radius;

  const CornerToken._(this.radius) : super.all(radius);

  static const CornerToken radius4 = CornerToken._(Radius.elliptical(4, 4));

  static const CornerToken radius8 = CornerToken._(Radius.elliptical(8, 8));

  static const CornerToken radius16 = CornerToken._(Radius.elliptical(16, 16));

  static const CornerToken radiusCircle = CornerToken._(Radius.circular(100));
}