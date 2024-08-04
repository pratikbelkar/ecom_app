import 'package:ecom_app/data/products.dart';
import 'package:ecom_app/repo/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsController {
  final bool isLoading;
  final List<Products> allProducts;
  final bool? isError;
  final bool? errorMessage;

  ProductsController(
      {required this.isLoading,
      required this.allProducts,
      this.isError,
      this.errorMessage});

  ProductsController copyWith({
    bool? isLoading,
    List<Products>? allProducts,
    bool? isError,
    bool? errorMessage,
  }) {
    return ProductsController(
        isLoading: isLoading ?? this.isLoading,
        allProducts: allProducts ?? this.allProducts,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class ProductsProvider extends StateNotifier<ProductsController> {
  ProductsProvider(this.ref)
      : super(ProductsController(isLoading: true, allProducts: []));
  final Ref ref;

  Future getAllProducts({String? slug}) async {
    state = state.copyWith(isLoading: true);

    if (slug != null) {}

    final data =
        await ref.read(productsRepoProvider).getAllProducts(slug: slug);
    state = state.copyWith(
        allProducts: data,
        isLoading: false,
        isError: false,
        errorMessage: null);
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProvider, ProductsController>((ref) {
  return ProductsProvider(ref);
});
