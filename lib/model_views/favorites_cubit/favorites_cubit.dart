import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/favorites_services.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  final _favoriteServices = FavoritesServiceImple();
  final _authServices = AuthServiceImpl();

  Future<void> fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      final cuurentUser = _authServices.getCuurentUser();

      final favorites = await _favoriteServices.getFavoriteProducts(
        cuurentUser!.uid,
      );
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(RemoveFavoriteLoading(productId));
    try {
      final cuurentUser = _authServices.getCuurentUser();
      await _favoriteServices.removeProductFromFavorites(
        productId,
        cuurentUser!.uid,
      );
      emit(RemoveFavoriteSucsess(productId));
      final favorites = await _favoriteServices.getFavoriteProducts(
        cuurentUser.uid,
      );
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(RemoveFavoriteError(e.toString(), productId));
    }
  }
}
