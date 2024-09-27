import 'package:ecom_app/data/theme/styles.dart';
import 'package:ecom_app/providers/theme_provider.dart';
import 'package:ecom_app/repo/hiveRepo.dart';
import 'package:ecom_app/ui/screens/screens/Splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HivRrepo().registerHiveAdapter();

  runApp(ProviderScope(child: Ecomapp()));
}

class Ecomapp extends StatelessWidget {
  const Ecomapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final themeNotifier = ref.watch(themeProvider);

      return MaterialApp(
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: Styles.themeData(themeNotifier, context),
        home: const SplashScreen(),
      );
    });
  }
}
