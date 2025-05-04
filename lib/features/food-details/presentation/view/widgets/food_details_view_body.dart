import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/models/food_model.dart';
import '../../view-model/food-detail-cubit/food_detail_cubit.dart';
import 'food_info_section.dart';
import 'recipe_section.dart';

class FoodDetailsViewBody extends StatelessWidget {
  const FoodDetailsViewBody({
    super.key,
    required this.foodItem,
    required this.cubit,
  });

  final FoodModel foodItem;
  final FoodDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            FoodInfoSection(foodItem: foodItem),
            SizedBox(height: 4.h),
            RecipeSection(cubit: cubit, foodItem: foodItem),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
