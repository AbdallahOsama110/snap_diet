import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/models/food_model.dart';
import '../../../../core/utils/light_theme.dart';
import '../../../../core/utils/toast_message.dart';

class FoodDetailsView extends StatelessWidget {
  const FoodDetailsView({super.key, required this.foodItem});
  final FoodModel foodItem;
  @override
  Widget build(BuildContext context) {
    void _copyInviteCode() {
      final formattedText = foodItem.recipe.replaceAll(r'\n', '\n');
      try {
        Clipboard.setData(ClipboardData(text: formattedText));
        toastMessage(context,
            msg: 'recipe copied to clipboard', type: ToastType.other);
      } catch (e) {
        toastMessage(context, msg: 'can\'t copy!', type: ToastType.error);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Food Details"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Text(foodItem.name,
                  style: Theme.of(context).textTheme.titleLarge),
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
              SizedBox(height: 4.h),
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
                    onPressed: _copyInviteCode,
                    icon: Icon(Icons.copy),
                    label: Text("copy"),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                foodItem.recipe,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorName.secondaryColor,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
