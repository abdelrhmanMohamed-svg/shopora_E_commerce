import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/home_carosel_item_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void loadHomeData() {
    emit(HomeLoading());
    Future.delayed(Duration(seconds: 1), () { 
      emit(
        HomeLoaded(
          products: dummyProducts,
          carouselItems: dummyHomeCarouselItems,
        ),
      );
    });
  }
}
