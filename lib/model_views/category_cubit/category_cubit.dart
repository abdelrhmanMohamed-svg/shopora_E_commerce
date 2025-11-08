import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/category_item_mode.dart';
import 'package:shopora_e_commerce/services/category_services.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  final _categoryServices = CategoryServicesImpl();
  Future<void> fetchCategories() async {
    emit(CategoryLoading());

    try {
      final categories = await _categoryServices.fetchCategories();
      emit(CategoryLoaded(category: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
