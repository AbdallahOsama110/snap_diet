import 'package:flutter/material.dart';


Future initVSlidingAnimation({required AnimationController animationController,required Animation animation,required TickerProvider vsync}) async{
   animationController = AnimationController(
    vsync: vsync, duration: const Duration(milliseconds: 1500));
        animation = Tween<Offset>(begin: const Offset(0, 3), end: Offset.zero)
    .animate(animationController);
        animationController.forward();
  }

  Future initFadeAnimation({required AnimationController animationController,required Animation animation,required TickerProvider vsync}) async{
    animationController =
        AnimationController(vsync: vsync, duration: const Duration(seconds: 3));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.ease);
        animationController.forward();
  }