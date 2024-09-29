import 'package:ecom_app/providers/category_provider.dart';
import 'package:ecom_app/providers/products_providers.dart';
import 'package:ecom_app/ui/screens/screens/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(productsProvider.notifier).getAllProducts().then((value) {
        ref.read(categoryProvider.notifier).getAllCategories().then((value) {});

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AllProductScreen()),
            (route) => false);
      });
    });
    // DioClient().get(APIEndpoints.GetProductsEndPoint);
    // Future.delayed(const Duration(seconds: 1), () {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (_) => const AllProductScreen()),
    //       (route) => false);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/ecom.jpg', fit: BoxFit.fitWidth),
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
