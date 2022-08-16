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

import 'package:flutter/material.dart';

import '../loading_component.dart';

/// Information about a piece of animation (e.g., color).
@immutable
class LoadingDecorateData {
  final Color? backgroundColor;
  final BaseLoadingStyle indicator;

  static const double _kDefaultStrokeWidth = 2;

  /// It will promise at least one value in the collection.
  final List<Color> colors;
  final double? _strokeWidth;

  /// Applicable to which has cut edge of the shape
  final Color? pathBackgroundColor;

  const LoadingDecorateData({
    required this.indicator,
    required this.colors,
    this.backgroundColor,
    double? strokeWidth,
    this.pathBackgroundColor,
  })  : _strokeWidth = strokeWidth,
        assert(colors.length > 0);

  double get strokeWidth => _strokeWidth ?? _kDefaultStrokeWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadingDecorateData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          indicator == other.indicator &&
          colors == other.colors &&
          strokeWidth == other.strokeWidth;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      indicator.hashCode ^
      colors.hashCode ^
      strokeWidth.hashCode;

  @override
  String toString() {
    return 'DecorateData{backgroundColor: $backgroundColor, indicator: $indicator, colors: $colors, strokeWidth: $strokeWidth}';
  }
}

class LoadingDecorateContext extends InheritedWidget {
  final LoadingDecorateData decorateData;

  const LoadingDecorateContext({
    Key? key,
    required this.decorateData,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(LoadingDecorateContext oldWidget) =>
      oldWidget.decorateData == decorateData;

  static LoadingDecorateContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
