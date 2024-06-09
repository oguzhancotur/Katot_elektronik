import 'dart:io';

import 'package:katot_elektronik/models/stock_tracking_model.dart';

abstract class StocktrackingEvent {}

class GetCategoriesEvent extends StocktrackingEvent {}

class AddCategoriesEvent extends StocktrackingEvent {
  final StockTrackingModel categoryModel;
  final File imageFile;
  AddCategoriesEvent({
    required this.categoryModel,
    required this.imageFile,
  });
}

class DeleteCategoryEvent extends StocktrackingEvent {
  final String categoryId;
  DeleteCategoryEvent({
    required this.categoryId,
  });
  List<Object> get props => [categoryId];
}

class ResetEvent extends StocktrackingEvent {}
