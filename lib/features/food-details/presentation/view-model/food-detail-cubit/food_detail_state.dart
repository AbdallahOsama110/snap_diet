part of 'food_detail_cubit.dart';

abstract class FoodDetailState {}

final class FoodDetailInitial extends FoodDetailState {}

class DeleteFoodLoading extends FoodDetailState {}
class DeleteFoodSuccess extends FoodDetailState {}
class DeleteFoodError extends FoodDetailState {
  final String error;
  DeleteFoodError(this.error);
}
