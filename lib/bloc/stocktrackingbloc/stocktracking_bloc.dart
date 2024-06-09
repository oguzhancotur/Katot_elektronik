import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_event.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_state.dart';
import 'package:katot_elektronik/repository/firebase_repo.dart';

class StocktrackingBloc extends Bloc<StocktrackingEvent, StocktrackingState> {
  FirestoreRepo firestoreRepo;
  StocktrackingBloc({required this.firestoreRepo})
      : super(StocktrackingInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(StocktrackingLoading());
      try {
        final categoryList = await firestoreRepo.getCategories();
        emit(StocktrackingLoaded(category: categoryList));
      } catch (e) {
        emit(StocktrackingError());
      }
    });

    on<AddCategoriesEvent>((event, emit) async {
      try {
        await firestoreRepo.addCategory(event.categoryModel, event.imageFile);
        emit(StocktrackingInitial());
      } catch (e) {
        print(e);
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(StocktrackingLoading());
      try {
        await firestoreRepo.deleteCategory(event.categoryId);
        emit(StocktrackingInitial());
      } catch (e) {
        emit(StocktrackingError());
      }
    });

    on<ResetEvent>((event, emit) async {
      emit(StocktrackingInitial());
    });
  }
}
