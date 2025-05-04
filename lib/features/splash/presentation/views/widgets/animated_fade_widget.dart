import 'package:flutter/material.dart';

class AnimatedFadeWidget extends StatelessWidget {
  const AnimatedFadeWidget({
    super.key,
    required this.animation,
    required this.widget,
  });

  final Animation<double> animation;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return FadeTransition(opacity: animation, child: widget);
        });
  }
}
