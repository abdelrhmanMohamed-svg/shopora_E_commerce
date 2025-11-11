import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/services/auth_service.dart';
import 'package:shopora_e_commerce/services/favorites_services.dart';
import 'package:shopora_e_commerce/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  int quantity = 1;
  ProductSize? size;
  final _productDetailsServices = ProductDetailsServicesImpl();
  final _authServices = AuthServiceImpl();
  final _favoriteServices = FavoritesServiceImple();

  Future<void> fetchProductDetails(String productId) async {
    emit(ProductDetailsLoading());

    try {
      final currentUser = _authServices.getCuurentUser();

      final favorites = await _favoriteServices.getFavoriteProducts(
        currentUser!.uid,
      );

      final product = await _productDetailsServices.fetchProductDetails(
        productId,
      );
      final isFavorite = favorites.any((element) => element.id == productId);
      final finalProduct = product.copyWith(isFavorite: isFavorite);

      emit(ProductDetailsLoaded(finalProduct));
    } catch (e) {
      emit(ProductDetailsError("Product not found"));
    }

    // final selectedIndex = dummyProducts.indexWhere(
    //   (item) => item.id == productId,
    // );
    // if (selectedIndex != -1) {
    //   emit(ProductDetailsLoaded(dummyProducts[selectedIndex]));
    // } else {
    //   emit(ProductDetailsError("Product not found"));
    // }
  }

  void incrementCounter(String productId) {
    // final selectedIndex = dummyProducts.indexWhere(
    //   (item) => item.id == productId,
    // );
    // dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
    //   quantity: dummyProducts[selectedIndex].quantity + 1,
    // );
    quantity++;
    emit(CounterUpdated(value: quantity));
  }

  void decrementCounter(String productId) {
    // final selectedIndex = dummyProducts.indexWhere(
    //   (item) => item.id == productId,
    // );
    // final currentQuantity = dummyProducts[selectedIndex].quantity;
    if (quantity > 1) {
      // dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      //   quantity: currentQuantity - 1,
      // );
      quantity--;
      emit(CounterUpdated(value: quantity));
    }
  }

  void selectSize(ProductSize size) {
    this.size = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId) async {
    emit(AddingToCart());
    try {
      final product = await _productDetailsServices.fetchProductDetails(
        productId,
      );
      final cuurentUser = _authServices.getCuurentUser();
      final newItem = AddToCartModel(
        product: product,
        productId: productId,
        quantity: quantity,
        size: size!,
      );
      await _productDetailsServices.addToCart(newItem, cuurentUser!.uid);
      emit(CartAdded(productId));
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }

    // Future.delayed(Duration(seconds: 2), () {
    //   final newItem = AddToCartModel(
    //     product: dummyProducts.firstWhere((item) => item.id == productId),
    //     productId: productId,
    //     quantity: quantity,
    //     size: size!,
    //   );
    //   dummyCartItems.add(newItem);
    //   debugPrint(dummyCartItems.length.toString());
    //   emit(CartAdded(productId));
    // }
    // );
  }

  Future<void> setFavorites(ProductItemModel product) async {
    emit(FavoritesLoading());
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
      emit(FvaoritesLoaded(!isFavorite));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
