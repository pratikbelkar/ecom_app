import 'package:ecom_app/data/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProviders extends StateNotifier<List<Products>> {
  CartProviders() : super([]);

  void addProductToCart(Products products) {
    state = [...state, products];
  }

  void removeProductsFromCart(Products products) {
    state = state.where((element) => element.id != products.id).toList();
  }
}

final cartProviders = StateNotifierProvider<CartProviders, List<Products>>(
    (ref) => CartProviders());
