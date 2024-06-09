import 'package:katot_elektronik/models/category_model.dart';

abstract class StocktrackingState {}

final class StocktrackingInitial extends StocktrackingState {}

final class StocktrackingLoading extends StocktrackingState {}

final class StocktrackingLoaded extends StocktrackingState {
  List<CategoryModel> category;

  StocktrackingLoaded({required this.category});
}

final class StocktrackingError extends StocktrackingState {}
