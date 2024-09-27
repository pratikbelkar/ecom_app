import 'dart:developer';

import 'package:ecom_app/data/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HivRrepo {
  final String Productbox = 'productbox';
  void registerHiveAdapter() {
    Hive.registerAdapter(ProductsAdapter());
  }

  Future addProductsToList(Products products) async {
    try {
      final productBox = await Hive.openBox<Products>(Productbox);
      if (productBox.isOpen) {
        log('box is open');
        if (productBox.containsKey(products.id)) {
          throw Exception('products aldredy added in cart');
        }
        productBox.put(products.id, products);
      } else {
        return Future.error('failed to open a box');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Products>> getProductsFromList() async {
    final productBox = await Hive.openBox<Products>(Productbox);
    return productBox.values.toList();
  }

  removeProductsFromList(productid) async {
    final productBox = await Hive.openBox<Products>(Productbox);
    return productBox.delete(productid);
  }
}

final hiveProvider = Provider((ref) => HivRrepo());
