import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'animated_fade_widget.dart';
import 'animated_slide_widget.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key, required this.nextScreen});
  final Widget nextScreen;

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController fadeAnimationController;
  late AnimationController vAnimationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> vSlideAnimation;

  @override
  void initState() {
    super.initState();
    initFadeAnimation();
    initVSlidingAnimation();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() {
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => widget.nextScreen)));
  }

  void initVSlidingAnimation() {
    vAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    vSlideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(vAnimationController);
    vAnimationController.forward();
  }

  Future<void> initFadeAnimation() async {
    fadeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fadeAnimation =
        CurvedAnimation(parent: fadeAnimationController, curve: Curves.ease);
    fadeAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    fadeAnimationController.dispose();
    vAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFadeWidget(
            animation: fadeAnimation,
            widget: Image.asset(
              "assets/images/logo_w.png",
              width: 25.w,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSlideWidget(
            animation: vSlideAnimation,
            widget: Column(
              children: [
                Text(
                  'SnapDiet',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 25.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Snap to Track',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade300,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
