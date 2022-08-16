import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../color/color_token.dart';

class SeparatorLineComponent extends StatelessWidget {
  final LineStyle style;
  final Color? color;
  final double length;
  final Axis orientation;
  static const double height = 1;

  const SeparatorLineComponent({
    Key? key,
    this.style = LineStyle.line,
    this.color,
    this.length = double.infinity,
    this.orientation = Axis.horizontal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final separatorColor = color ?? ColorToken.borderSubtle;
    return CustomPaint(
      painter: _LinePainter(style, separatorColor, height, orientation),
      size: _getSize()
    );
  }

  Size _getSize() {
    if (orientation == Axis.horizontal) {
      return Size(length, height);
    }
    return Size(height, length);
  }
}

class LineStyle {
  final double dashWidth;
  final double dashGap;

  const LineStyle(this.dashWidth, this.dashGap);

  static const LineStyle line = LineStyle(0, 0);
  static const LineStyle dashedLine = LineStyle(5, 5);
}

class _LinePainter extends CustomPainter {
  final LineStyle lineStyle;
  final Color color;
  final double lineHeight;
  final Axis orientation;

  const _LinePainter(this.lineStyle, this.color, this.lineHeight, this.orientation);

  @override
  void paint(Canvas canvas, Size size) {
    final double dashWidth = lineStyle.dashWidth, dashGap = lineStyle.dashGap;
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineHeight;
    if (orientation == Axis.horizontal) {
      if (lineStyle.dashWidth == 0) {
        // line without gap
        canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
      } else {
        // line with gap (dashed line)
        double startX = 0;
        while (startX < size.width) {
          canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
          startX += dashWidth + dashGap;
        }
      }
    } else {
      if (lineStyle.dashWidth == 0) {
        // line without gap
        canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
      } else {
        // line with gap (dashed line)
        double startY = 0;
        while (startY < size.height) {
          canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
          startY += dashWidth + dashGap;
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}