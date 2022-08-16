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
import 'package:flutter/widgets.dart';

import 'loading_shape_widget.dart';

/// https://pub.dev/packages/loading_indicator: BallPulse
class LoadingAnimationLinear extends StatefulWidget {
  const LoadingAnimationLinear({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingAnimationLinearState();
  }
}

class _LoadingAnimationLinearState extends State<LoadingAnimationLinear> with TickerProviderStateMixin {
  static const _beginTimes = [
    120,
    240,
    360,
  ];

  final List<AnimationController> _animationController = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];
  final List<CancelableOperation<int>> _delayFeature = [];

  @override
  void initState() {
    super.initState();
    const cubic = Cubic(0.2, 0.68, 0.18, 0.08);
    for (int i = 0; i < 3; i++) {
      _animationController.add(AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
      ));
      _scaleAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.1), weight: 45),
        TweenSequenceItem(tween: Tween(begin: 0.1, end: 1.0), weight: 35),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 20),
      ]).animate(
          CurvedAnimation(parent: _animationController[i], curve: cubic)));
      _opacityAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 45),
        TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 35),
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 20),
      ]).animate(
          CurvedAnimation(parent: _animationController[i], curve: cubic)));

      /// Better solution is welcome!!! Very stupid work solution.
      _delayFeature.add(CancelableOperation.fromFuture(
          Future.delayed(Duration(milliseconds: _beginTimes[i])).then((_) {
            _animationController[i].repeat();
            return 0;
          }))
      );
    }
  }

  @override
  void dispose() {
    for (var f in _delayFeature) {
      f.cancel();
    }
    for (var f in _animationController) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = List<Widget>.filled(3, Container());
    for (int i = 0; i < 3; i++) {
      widgets[i] = FadeTransition(
        opacity: _opacityAnimations[i],
        child: ScaleTransition(
          scale: _scaleAnimations[i],
          child: LoadingShapeWidget(index: i),
        ),
      );
    }

    const firstDotIndex = 0;
    const secondDotIndex = 1;
    const thirdDotIndex = 2;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: widgets[firstDotIndex]),
        const SizedBox(width: 2),
        Expanded(child: widgets[secondDotIndex]),
        const SizedBox(width: 2),
        Expanded(child: widgets[thirdDotIndex]),
      ],
    );
  }
}