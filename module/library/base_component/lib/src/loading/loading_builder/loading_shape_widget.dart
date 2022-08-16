/*!
    @copyright
        Copyright [2019] [TinoGuo]
    @copydetails
        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.
 */

import 'package:flutter/widgets.dart';

import 'loading_decorate.dart';

/// Wrapper class for basic shape.
class LoadingShapeWidget extends StatelessWidget {
  final double? data;

  static const double _kMinIndicatorSize = 36.0;

  /// The index of shape in the widget.
  final int index;

  const LoadingShapeWidget({
    Key? key,
    this.data,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadingDecorateData decorateData = LoadingDecorateContext.of(context)!.decorateData;
    final color = decorateData.colors[index % decorateData.colors.length];

    return Container(
      constraints: const BoxConstraints(
        minWidth: _kMinIndicatorSize,
        minHeight: _kMinIndicatorSize,
      ),
      child: CustomPaint(
        painter: _ShapePainter(
          color,
          data,
          decorateData.strokeWidth,
          pathColor: decorateData.pathBackgroundColor,
        ),
      ),
    );
  }
}

class _ShapePainter extends CustomPainter {
  final Color color;
  final Paint _paint;
  final double? data;
  final double strokeWidth;
  final Color? pathColor;

  _ShapePainter(
      this.color,
      this.data,
      this.strokeWidth, {
        this.pathColor,
      })  : _paint = Paint()..isAntiAlias = true,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.shortestSide / 2,
      _paint,
    );
  }

  @override
  bool shouldRepaint(_ShapePainter oldDelegate) =>
      color != oldDelegate.color ||
          data != oldDelegate.data ||
          strokeWidth != oldDelegate.strokeWidth ||
          pathColor != oldDelegate.pathColor;
}