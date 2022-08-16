import 'package:flutter/material.dart';

import '../color/color_token.dart';

class LoadingPlaceholderComponent extends StatelessWidget {
  final PlaceholderType placeholderType;
  final PlaceholderStyle? style;
  final double width;
  final double height;
  final BorderRadius? radius;
  final int lines;
  final Axis orientation;

  const LoadingPlaceholderComponent.circle({
    required double size,
    Key? key,
    this.style
  }) : placeholderType = PlaceholderType.circle,
      radius = null,
      width = size,
      height = size,
      lines = 0,
      orientation = Axis.horizontal,
      super(key: key);

  const LoadingPlaceholderComponent.rectangle({
    required this.width,
    required this.height,
    Key? key,
    this.style,
    this.radius
  }) : placeholderType = PlaceholderType.rectangle,
      lines = 0,
      orientation = Axis.horizontal,
      super(key: key);



  @override
  Widget build(BuildContext context) {
    final placeholderStyle = style ?? PlaceholderStyle.primary;

    switch (placeholderType) {
      case PlaceholderType.circle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: placeholderStyle.color
          )
        );
      case PlaceholderType.rectangle:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: placeholderStyle.color,
            borderRadius: radius
          )
        );
    }
  }
}

class PlaceholderStyle {
  final Color color;

  const PlaceholderStyle(this.color);

  static final primary = PlaceholderStyle(ColorToken.backgroundSubtle);
  static final secondary = PlaceholderStyle(ColorToken.backgroundLow);
}

enum PlaceholderType {
  circle,
  rectangle,
}