import 'package:flutter/material.dart';

import '../color/color_token.dart';
import 'loading_builder/loading_animation_linear.dart';
import 'loading_builder/loading_animation_wave.dart';
import 'loading_builder/loading_decorate.dart';

enum BaseLoadingStyle { linear, wave }

class LoadingComponent extends StatelessWidget {
  final BaseLoadingStyle style;
  final Color? color;

  static const keyLoadingLinear = "loading-linear";
  static const keyLoadingWave = "loading-wave";

  /// Loading animation, source: https://pub.dev/packages/loading_indicator
  /// * [style] Loading animation style option: [wave, linear]
  /// * [color] Loading color
  const LoadingComponent({
    Key? key,
    this.style = BaseLoadingStyle.linear,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingDecorateContext(
      decorateData: LoadingDecorateData(
          indicator: style, colors: [color ?? ColorToken.backgroundMedium]),
      child: SizedBox(
        height: 32,
        width: 32,
        child: _loadingIndicator(),
      ),
    );
  }

  Widget _loadingIndicator() {
    switch (style) {
      case BaseLoadingStyle.linear:
        return const LoadingAnimationLinear(
            key: Key(LoadingComponent.keyLoadingLinear));
      case BaseLoadingStyle.wave:
        return const LoadingAnimationWave(
            key: Key(LoadingComponent.keyLoadingWave));
      default:
        throw Exception("no related indicator type:$style");
    }
  }
}
