import 'package:ecom_app/data/category.dart';
import 'package:ecom_app/repo/catagory_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends StateNotifier<List<CategoryModel>> {
  CategoryProvider(this.ref) : super([]);
  final Ref ref;

  Future getAllCategories() async {
    ref.read(CategoryRepoProvider).getAllCategories().then((value) {
      state = value;
    });
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<CategoryModel>>(
        (ref) => CategoryProvider(ref));
