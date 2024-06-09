import 'package:katot_elektronik/models/stock_tracking_model.dart';

abstract class StocktrackingState {}

final class StocktrackingInitial extends StocktrackingState {}

final class StocktrackingLoading extends StocktrackingState {}

final class StocktrackingLoaded extends StocktrackingState {
  List<StockTrackingModel> stock;

  StocktrackingLoaded({required this.stock});
}

final class StocktrackingError extends StocktrackingState {}
