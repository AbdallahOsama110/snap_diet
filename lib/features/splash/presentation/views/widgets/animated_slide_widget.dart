import 'package:flutter/material.dart';

class AnimatedSlideWidget extends StatelessWidget {
  const AnimatedSlideWidget({
    super.key,
    required this.animation,
    required this.widget,
  });

  final Animation<Offset> animation;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return SlideTransition(
          position: animation,
          child: widget,
        );
      },
    );
  }
}
