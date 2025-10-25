import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopora_e_commerce/model/add_to_cart_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  int quantity = 1;
  ProductSize? size;

  void loadProductDetails(String productId) {
    emit(ProductDetailsLoading());
    final selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    if (selectedIndex != -1) {
      emit(ProductDetailsLoaded(dummyProducts[selectedIndex]));
    } else {
      emit(ProductDetailsError("Product not found"));
    }
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

  void addToCart(String productId) {
    emit(AddingToCart());
    Future.delayed(Duration(seconds: 2), () {
      final newItem = AddToCartModel(
        product: dummyProducts.firstWhere((item) => item.id == productId),
        productId: productId,
        quantity: quantity,
        size: size!,
      );
      dummyCartItems.add(newItem);
      debugPrint(dummyCartItems.length.toString());
      emit(CartAdded(productId));
    });
  }
}
