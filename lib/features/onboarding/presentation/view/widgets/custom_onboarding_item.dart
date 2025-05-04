import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/light_theme.dart';
import '../../../data/models/onboarding_model.dart';
import 'onboarding_text_body.dart';

class CustomOnboardingItem extends StatelessWidget {
  const CustomOnboardingItem({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          Image.asset(onboardingModel.image),
          Spacer(flex: 2),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  onboardingModel.title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorName.primaryColor,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 17),
                OnboardingTextBody(bodyText: onboardingModel.bodyText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
