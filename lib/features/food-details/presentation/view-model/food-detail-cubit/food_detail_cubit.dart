import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/utils/food_database_service.dart';
import '../../../../../core/utils/light_theme.dart';
import '../../../../../core/utils/toast_message.dart';
part 'food_detail_state.dart';

class FoodDetailCubit extends Cubit<FoodDetailState> {
  FoodDetailCubit() : super(FoodDetailInitial());

  static FoodDetailCubit get(context) => BlocProvider.of(context);

  void copyInviteCode(BuildContext context, {required String recipe}) {
    final formattedText = recipe.replaceAll(r'\n', '\n');
    try {
      Clipboard.setData(ClipboardData(text: formattedText));
      toastMessage(context,
          msg: 'recipe copied to clipboard', type: ToastType.other);
    } catch (e) {
      toastMessage(context, msg: 'can\'t copy!', type: ToastType.error);
    }
  }

  void deleteFood(BuildContext context, {required int id}) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Food'),
          content: Text(
            'Do you want to delete this Meal? This action cannot be undone.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: ColorName.secondaryColor,
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      emit(DeleteFoodLoading());
      try {
        final db = FoodDatabaseService.instance;
        await db.deleteFoodItem(id);
        emit(DeleteFoodSuccess());
      } catch (e) {
        emit(DeleteFoodError(e.toString()));
      }
    }
  }
}
