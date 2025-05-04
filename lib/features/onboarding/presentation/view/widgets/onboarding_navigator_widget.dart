import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../data/models/onboarding_model.dart';
import '../../view_model/onboarding_cubit/onboarding_cubit.dart';
import 'getstarted_button.dart';
import 'indicator_widget.dart';
import 'next_button.dart';

class OnboardingNavigatorWidget extends StatelessWidget {
  const OnboardingNavigatorWidget({
    super.key,
    required this.pageController,
    required this.onboardingList,
    required this.onboardingCubit,
    required this.condition,
  });

  final PageController pageController;
  final List<OnboardingModel> onboardingList;
  final OnboardingCubit onboardingCubit;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IndicatorWidget(
            pageController: pageController,
            onboardingList: onboardingList,
          ),
          ConditionalBuilder(
            condition: condition,
            builder: (context) =>
                GetstartedButton(onboardingCubit: onboardingCubit),
            fallback: (context) => NextButton(pageController: pageController),
          ),
        ],
      ),
    );
  }
}
