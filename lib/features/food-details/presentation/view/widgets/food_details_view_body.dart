import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/models/food_model.dart';
import '../../../../../core/utils/light_theme.dart';
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: foodItem.id,
            child: Image.file(
              File(foodItem.imagePath ?? ''),
              height: 20.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: ColorName.primaryColor);
              },
            ),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodInfoSection(foodItem: foodItem),
                SizedBox(height: 4.h),
                RecipeSection(cubit: cubit, foodItem: foodItem),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
