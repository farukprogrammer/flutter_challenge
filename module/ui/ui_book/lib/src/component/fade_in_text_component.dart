import 'package:base_component/base_component.dart';
import 'package:flutter/material.dart';

class FadeInTextComponent extends StatefulWidget {
  final String text;
  final double width;
  final int maxLines;
  final TextStyle style;

  const FadeInTextComponent(
    this.text, {
    Key? key,
    this.width = 240,
    this.maxLines = 3,
    required this.style,
  }) : super(key: key);

  @override
  State<FadeInTextComponent> createState() => _FadeInTextComponentState();
}

class _FadeInTextComponentState extends State<FadeInTextComponent>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimation();
    _runAnimation();
  }

  void prepareAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
  }

  void _runAnimation() {
    animationController.forward();
  }

  @override
  void didUpdateWidget(FadeInTextComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizedBox(
        width: widget.width,
        child: TextComponent(
          widget.text,
          style: widget.style,
          maxLines: widget.maxLines,
        ),
      ),
    );
  }
}
