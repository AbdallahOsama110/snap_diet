import 'package:flutter/material.dart';

import '../../../data/models/onboarding_model.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.pageController,
    required this.onboardingList,
    required this.isVisibile,
  });

  final PageController pageController;
  final List<OnboardingModel> onboardingList;
  final bool isVisibile;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Visibility(
        visible: isVisibile,
        child: TextButton(
          onPressed: () {
            pageController.animateToPage(
              onboardingList.length - 1,
              duration: const Duration(milliseconds: 1500),
              curve: Curves.fastLinearToSlowEaseIn,
            );
          },
          child: Text(
            "Skip",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(.22),
                ),
          ),
        ),
      ),
    );
  }
}
