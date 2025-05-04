import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/light_theme.dart';

class OnboardingTextBody extends StatelessWidget {
  const OnboardingTextBody({
    super.key,
    required this.bodyText,
  });

  final String bodyText;

  @override
  Widget build(BuildContext context) {
    String fullText = bodyText;
    String specialWord = "SnapDiet";
    int index = fullText.indexOf(specialWord);

    return ConditionalBuilder(
      condition: index != -1,
      builder: (context) => RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorName.secondaryColor,
              ),
          children: [
            TextSpan(
              text: fullText.substring(0, index),
            ),
            TextSpan(
              text: specialWord,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: fullText.substring(index + specialWord.length),
            ),
          ],
        ),
        maxLines: 4,
      ),
      fallback: (context) => Text(
        fullText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorName.secondaryColor,
            ),
        maxLines: 4,
      ),
    );
  }
}
