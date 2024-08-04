import 'package:ecom_app/data/category.dart';
import 'package:ecom_app/networking/api_endpoints.dart';
import 'package:ecom_app/networking/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRepo {
  final Ref ref;
  CategoryRepo(this.ref);

  Future<List<CategoryModel>> getAllCategories({String? slug}) async {
    try {
      // ignore: non_constant_identifier_names
      final Response = await ref
          .read(dioClientProvider)
          .get(APIEndpoints.GetAllCategoriesEndPoint);
      if (Response.statusCode == 200) {
        final List<CategoryModel> categoryList = Response.data
            .map<CategoryModel>((category) => CategoryModel.fromJson(category))
            .toList();
        return categoryList;
      } else {
        return Future.error('Unable to fetch Categories');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

// ignore: non_constant_identifier_names
final CategoryRepoProvider = Provider<CategoryRepo>((ref) => CategoryRepo(ref));
