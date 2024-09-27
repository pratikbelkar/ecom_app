import 'package:ecom_app/data/products.dart';
import 'package:ecom_app/providers/cart_providers.dart';
import 'package:ecom_app/repo/hiveRepo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreem extends ConsumerStatefulWidget {
  const CartScreem({super.key});
  @override
  ConsumerState<CartScreem> createState() => _CartScreemState();
}

class _CartScreemState extends ConsumerState<CartScreem> {
  final List<Products> productslist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      await ref.read(hiveProvider).getProductsFromList().then(
            (value) => setState(
              () {
                productslist.addAll(value);
              },
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              'cart screen',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        body: productslist.isEmpty
            ? const Center(
                child: Text('cart is Empty'),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: productslist.length,
                itemBuilder: (context, index) {
                  final product = productslist[index];
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
                                style: const TextStyle(
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
                              onPressed: () async {
                                try {
                                  await ref
                                      .read(hiveProvider)
                                      .removeProductsFromList(product.id!)
                                      .then((value) {
                                    setState(() {
                                      setState(() {
                                        productslist.remove(product);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'products  removed from cart'),
                                        ),
                                      );
                                    });
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'failed to remove products')));
                                }
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
