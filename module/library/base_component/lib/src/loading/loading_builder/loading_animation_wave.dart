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

import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'loading_shape_widget.dart';

/// https://pub.dev/packages/loading_indicator: BallPulseSync
class LoadingAnimationWave extends StatefulWidget {
  const LoadingAnimationWave({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingAnimationWaveState();
}

class _LoadingAnimationWaveState extends State<LoadingAnimationWave>
    with TickerProviderStateMixin {
  static const _beginTimes = [70, 140, 210];

  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _animations = [];
  final List<CancelableOperation<int>> _delayFeatures = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _animationControllers.add(AnimationController(
          vsync: this, duration: const Duration(milliseconds: 600)));

      _animations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 2.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 2.0, end: -2.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -2.0, end: 0.0), weight: 1),
      ]).animate(CurvedAnimation(
          parent: _animationControllers[i], curve: Curves.easeInOut)));

      _delayFeatures.add(CancelableOperation.fromFuture(
          Future.delayed(Duration(milliseconds: _beginTimes[i])).then((t) {
            _animationControllers[i].repeat();
            return 0;
          })));
    }
  }

  @override
  void dispose() {
    for (var f in _delayFeatures) {
      f.cancel();
    }
    for (var f in _animationControllers) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      final circleSize = (constraint.maxWidth - 4) / 3;
      final deltaY = (constraint.maxHeight / 2 - circleSize) / 2;

      List<Widget> widgets = List.filled(5, Container());
      for (int i = 0; i < 5; i++) {
        if (i.isEven) {
          widgets[i] = Expanded(
            child: AnimatedBuilder(
              animation: _animationControllers[i ~/ 2],
              builder: (_, child) {
                return Transform.translate(
                  offset: Offset(0, _animations[i ~/ 2].value * deltaY),
                  child: child,
                );
              },
              child: LoadingShapeWidget(index: i),
            ),
          );
        } else {
          widgets[i] = const SizedBox(width: 2);
        }
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets,
      );
    });
  }
}
