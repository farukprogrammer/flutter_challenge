import 'package:flutter/material.dart';

import '../color/color_token.dart';

class PullToRefresh extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  const PullToRefresh({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorToken.brand01,
      displacement: 16,
      backgroundColor: ColorToken.theBackground,
      strokeWidth: 2,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
