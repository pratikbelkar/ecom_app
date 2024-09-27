import 'package:ecom_app/data/products.dart';
import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/providers/products_from_id_future_Provider.dart';
import 'package:ecom_app/repo/hiveRepo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsDetailedScreen extends ConsumerWidget {
  const ProductsDetailedScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Products> productsData =
        ref.watch(productFromIdFutureProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products detail Page '),
      ),
      body: Center(
        child: productsData.when(data: (Products) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Products.images!.first!,
                height: 200,
              ),
              Text(
                Products.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(Products.description!),
              ),
              Text(Products.price.toString()),
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(hiveProvider)
                      .addProductsToList(Products)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('products added in cart sucessfully')));
                  }).catchError((e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$e')));
                  });
                },
                child: const Text('Add to cart'),
              ),
            ],
          );
        }, error: (err, stk) {
          return Center(
            child: Text(err.toString()),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
