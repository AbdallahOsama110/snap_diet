import 'package:flutter/material.dart';
import '../../view_model/onboarding_cubit/onboarding_cubit.dart';

class GetstartedButton extends StatelessWidget {
  const GetstartedButton({
    super.key,
    required this.onboardingCubit,
  });

  final OnboardingCubit onboardingCubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async => await onboardingCubit.getStarted(context),
      child: Text('let’s go'),
    );
  }
}
