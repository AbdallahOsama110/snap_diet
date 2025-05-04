import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../history/presentation/view-model/history-cubit/history_cubit.dart';
import '../../../../core/models/food_model.dart';
import '../../../../core/utils/light_theme.dart';
import '../../../../core/utils/toast_message.dart';
import '../../../home/presentation/view_model/home_cubit/home_cubit.dart';
import '../view-model/food-detail-cubit/food_detail_cubit.dart';

class FoodDetailsView extends StatelessWidget {
  const FoodDetailsView({super.key, required this.foodItem});
  final FoodModel foodItem;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodDetailCubit(),
      child: BlocConsumer<FoodDetailCubit, FoodDetailState>(
        listener: (context, state) async {
          var homeCubit = HomeCubit.get(context);
          if (state is DeleteFoodSuccess) {
            toastMessage(context,
                msg: 'Food deleted successfully', type: ToastType.success);
            await HistoryCubit.get(context).getHistory();
            if (context.mounted) Navigator.pop(context);
            if (homeCubit.foodItem != null) {
              if (homeCubit.foodItem!.id == foodItem.id) {
                homeCubit.isFoodExist = false;
              }
            }
          }
        },
        builder: (context, state) {
          var cubit = FoodDetailCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Food Details"),
              actions: [
                IconButton(
                  onPressed: () => cubit.deleteFood(context, id: foodItem.id),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        Text(
                          "Recipe",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Spacer(),
                        TextButton.icon(
                          onPressed: () => cubit.copyInviteCode(context,
                              recipe: foodItem.recipe),
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
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
