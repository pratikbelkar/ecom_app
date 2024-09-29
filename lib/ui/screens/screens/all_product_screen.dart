import 'package:ecom_app/providers/category_provider.dart';
import 'package:ecom_app/providers/products_providers.dart';
import 'package:ecom_app/providers/selected_categeory.dart';
import 'package:ecom_app/providers/theme_provider.dart';
import 'package:ecom_app/ui/screens/screens/cart_screem.dart';
import 'package:ecom_app/ui/screens/screens/products_detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductScreen extends ConsumerWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: non_constant_identifier_names
    final ProductsNotifier = ref.watch(productsProvider);
    // ignore: non_constant_identifier_names
    final categoryNotifier = ref.watch(categoryProvider);
    final selectedNotifier = ref.watch(selectedCategeoryProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 50),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: Text(
                    'All Product',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.light_mode)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartScreem()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryNotifier.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref
                            .read(selectedCategeoryProvider.notifier)
                            .setSelectedCategeory(
                                categoryNotifier[index].name!);
                        ref
                            .read(productsProvider.notifier)
                            .getAllProducts(slug: categoryNotifier[index].name);
                      },
                      child: Center(
                        child: Card(
                          borderOnForeground: false,
                          color:
                              categoryNotifier[index].name == selectedNotifier
                                  ? Colors.blue
                                  : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(categoryNotifier[index].name!,
                                style: TextStyle(
                                    color: categoryNotifier[index].name ==
                                            selectedNotifier
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            ProductsNotifier.isLoading
                ? const Center(child: LinearProgressIndicator())
                : ProductsNotifier.allProducts.isEmpty
                    ? const Text('No Product Found')
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: ProductsNotifier.allProducts.length,
                          itemBuilder: (context, index) {
                            final product = ProductsNotifier.allProducts[index];
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ProductsDetailedScreen(
                                          id: product.id.toString(),
                                        )));
                              },
                              leading: Image.network(
                                product.images!.first,
                                width: 75,
                                fit: BoxFit.fitWidth,
                              ),
                              title: Text(
                                product.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                product.description!,
                              ),
                              trailing: Text(
                                product.price.toString(),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ));
  }
}
