import 'package:flutter/material.dart';
import '../../../../../core/utils/light_theme.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('SnapDiet'),
        Text(
          "Let's Snap your Meal",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorName.secondaryColor,
              ),
        ),
      ],
    );
  }
}
