import 'package:ecom_app/providers/cart_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreem extends ConsumerWidget {
  const CartScreem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartProviders);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                'cart screen',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ),
        body: cartNotifier.isEmpty
            ? const Center(
                child: Text('cart is Empty'),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cartNotifier.length,
                itemBuilder: (context, index) {
                  final product = cartNotifier[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        product.images!.first,
                        width: 75,
                        fit: BoxFit.fitWidth,
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                product.title!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                          SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.description!),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Text(product.price.toString()),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(cartProviders.notifier)
                                    .removeProductsFromCart(product);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ],
                  );
                },
              ));
  }
}
