import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/models/food_model.dart';
import '../../../../../core/utils/light_theme.dart';

class FoodInfoSection extends StatelessWidget {
  const FoodInfoSection({
    super.key,
    required this.foodItem,
  });

  final FoodModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          foodItem.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ColorName.primaryColor,
              ),
        ),
        SizedBox(height: 1.h),
        Row(
          spacing: 5,
          children: [
            Icon(FontAwesomeIcons.fire, size: 16),
            Text(
              "${foodItem.calories} kcal",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorName.secondaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
