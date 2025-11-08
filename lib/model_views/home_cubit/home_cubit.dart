import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/home_carosel_item_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeServices = HomeServicesImpl();
  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final products = await _homeServices.fetchHomeProducts();
      final announcements = await _homeServices.fetchHomeAnnouncements();
      emit(HomeLoaded(products: products, announcements: announcements));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }

    // Future.delayed(Duration(seconds: 1), () {
    //   emit(
    //     HomeLoaded(
    //       products: dummyProducts,
    //       carouselItems: dummyHomeCarouselItems,
    //     ),
    //   );
    // });
  }
}
