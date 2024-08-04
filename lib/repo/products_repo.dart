import 'package:dio/dio.dart';
import 'package:ecom_app/data/products.dart';
import 'package:ecom_app/networking/api_endpoints.dart';
import 'package:ecom_app/networking/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsRepo {
  final Ref ref;

  ProductsRepo(this.ref);

  Future<List<Products>> getAllProducts({String? slug}) async {
    Response response;
    try {
      if (slug != null) {
        response = await ref
            .read(dioClientProvider)
            .get('${APIEndpoints.GetProductsByCategoryEndPoint}/$slug');
      } else {
        response = await ref
            .read(dioClientProvider)
            .get(APIEndpoints.GetProductsEndPoint);
      }

      if (response.statusCode == 200) {
        final List<Products> allProductsList = response.data['products']
            .map<Products>((product) => Products.fromJson(product))
            .toList();
        return allProductsList;
      } else {
        return Future.error('failed to fetch products ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Products> getProductFromId(String id) async {
    try {
      final response = await ref
          .read(dioClientProvider)
          .get('${APIEndpoints.GetProductsEndPoint}/$id');
      if (response.statusCode == 200) {
        return Products.fromJson(response.data);
      } else {
        return Future.error('failed to fetch product ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

final productsRepoProvider = Provider<ProductsRepo>((ref) => ProductsRepo(ref));
