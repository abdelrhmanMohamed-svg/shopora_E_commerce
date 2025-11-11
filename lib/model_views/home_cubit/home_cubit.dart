import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/home_carosel_item_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/favorites_services.dart';
import 'package:shopora_e_commerce/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeServices = HomeServicesImpl();
  final _favoriteServices = FavoritesServiceImple();
  final _authServices = AuthServiceImpl();

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final products = await _homeServices.fetchHomeProducts();
      final announcements = await _homeServices.fetchHomeAnnouncements();
      final favorites = await _favoriteServices.getFavoriteProducts(
        _authServices.getCuurentUser()!.uid,
      );
      final finalProducts = products.map((product) {
        final isFavorite = favorites.any((item) => item.id == product.id);
        return product.copyWith(isFavorite: isFavorite);
      }).toList();

      emit(HomeLoaded(products: finalProducts, announcements: announcements));
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

  Future<void> setFavorites(ProductItemModel product) async {
    emit(FavoritesLoading(product.id));
    try {
      final cuurentUser = _authServices.getCuurentUser();
      final favorites = await _favoriteServices.getFavoriteProducts(
        cuurentUser!.uid,
      );
      final isFavorite = favorites.any((item) => item.id == product.id);
      if (isFavorite) {
        await _favoriteServices.removeProductFromFavorites(
          product.id,
          cuurentUser.uid,
        );
      } else {
        await _favoriteServices.addProductToFavorites(product, cuurentUser.uid);
      }
      emit(FvaoritesLoaded(!isFavorite, product.id));
    } catch (e) {
      emit(FavoritesError(e.toString(), product.id));
    }
  }
}
