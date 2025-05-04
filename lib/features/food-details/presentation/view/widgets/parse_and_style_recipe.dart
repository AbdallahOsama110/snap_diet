import 'package:flutter/material.dart';
import '../../../../../core/utils/light_theme.dart';

TextSpan parseAndStyleRecipe(BuildContext context, String recipe) {
  final lines = recipe.split('\n');

  return TextSpan(
    children: lines.map((line) {
      final isLabel = RegExp(
        r'^(Ingredients:|Instructions:)',
        caseSensitive: false,
      );
      if (isLabel.hasMatch(line)) {
        return TextSpan(
          text: '$line\n',
          style: TextStyle(
            height: 2,
            fontWeight: FontWeight.bold,
            color: ColorName.primaryColor,
          ),
        );
      } else {
        return TextSpan(text: '$line\n');
      }
    }).toList(),
    style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ColorName.secondaryColor,
        ),
  );
}
