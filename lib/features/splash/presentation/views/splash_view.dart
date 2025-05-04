import 'package:flutter/material.dart';

import '../../../../core/utils/light_theme.dart';
import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key, required this.nextScreen});
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primaryColor,
      body: SplashViewBody(nextScreen: nextScreen),
    );
  }
}
