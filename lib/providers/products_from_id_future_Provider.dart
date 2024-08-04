import 'package:ecom_app/data/products.dart';

import 'package:ecom_app/repo/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productFromIdFutureProvider =
    FutureProvider.family<Products, String>((ref, id) async {
  return await ref.read(productsRepoProvider).getProductFromId(id);
});
