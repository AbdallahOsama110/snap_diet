import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'parse_and_style_recipe.dart';
import '../../../../../core/models/food_model.dart';
import '../../view-model/food-detail-cubit/food_detail_cubit.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({super.key, required this.cubit, required this.foodItem});

  final FoodDetailCubit cubit;
  final FoodModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(
              FontAwesomeIcons.basketShopping,
              size: 18,
              color: Colors.black.withValues(alpha: .8),
            ),
            Text("Recipe", style: Theme.of(context).textTheme.bodyMedium),
            Spacer(),
            TextButton.icon(
              onPressed: () =>
                  cubit.copyRecipe(context, recipe: foodItem.recipe),
              icon: Icon(Icons.copy),
              label: Text("copy"),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Text.rich(parseAndStyleRecipe(context, foodItem.recipe)),
      ],
    );
  }
}
