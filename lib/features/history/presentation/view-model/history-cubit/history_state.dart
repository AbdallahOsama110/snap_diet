part of 'history_cubit.dart';

abstract class HistoryState {}

final class HistoryInitial extends HistoryState {}

class GetFoodHistoryLoading extends HistoryState {}
class GetFoodHistorySuccess extends HistoryState {}
class GetFoodHistoryError extends HistoryState {
  final String error;
  GetFoodHistoryError(this.error);
}

class SortFoodHistory extends HistoryState {}