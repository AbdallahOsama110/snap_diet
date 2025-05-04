import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/models/food_model.dart';
import '../../../../../core/utils/food_database_service.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial()){
    getHistory();
  }

  static HistoryCubit get(context) => BlocProvider.of(context);
List<FoodModel> foodHistory = [];

  Future<void> getHistory() async {
    final db = FoodDatabaseService.instance;
    try {
      emit(GetFoodHistoryLoading());
      foodHistory = await db.getFoodHistory();
      emit(GetFoodHistorySuccess());
    } catch (e) {
      log("Error loading food history: $e");
      emit(GetFoodHistoryError("Error loading food history: $e"));
    }
  }

  void sortHistoryOnDate() {
    foodHistory.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    emit(SortFoodHistory());
  }

  void sortHistoryOnCalories() {
    foodHistory.sort((a, b) => b.calories.compareTo(a.calories));
    emit(SortFoodHistory());
  }
}
