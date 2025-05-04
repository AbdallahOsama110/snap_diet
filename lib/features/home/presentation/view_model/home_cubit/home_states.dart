part of 'home_cubit.dart';

class HomeStates {}

class HomeInitial extends HomeStates {}

class PickImageLoading extends HomeStates {}

class PickImageSuccess extends HomeStates {}

class PickImageError extends HomeStates {
  final String error;
  PickImageError(this.error);
}

class FoodClassifierModelLoaded extends HomeStates {}
class FoodClassifierError extends HomeStates {
  final String error;
  FoodClassifierError(this.error);
}

class FoodClassifierLoading extends HomeStates {}
class FoodClassifierSuccess extends HomeStates {}

class CheckFoodExistenceSuccess extends HomeStates {}
class CheckFoodExistenceError extends HomeStates {}

class SaveFoodLoading extends HomeStates {}
class SaveFoodSuccess extends HomeStates {}
class SaveFoodError extends HomeStates {
  final String error;
  SaveFoodError(this.error);
}

class PageChanged extends HomeStates {
  final int newIndex;
  PageChanged(this.newIndex);
}