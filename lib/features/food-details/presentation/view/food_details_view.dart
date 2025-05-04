import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/food_details_view_body.dart';
import '../../../history/presentation/view-model/history-cubit/history_cubit.dart';
import '../../../../core/models/food_model.dart';
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
            body: FoodDetailsViewBody(foodItem: foodItem, cubit: cubit),
          );
        },
      ),
    );
  }
}
