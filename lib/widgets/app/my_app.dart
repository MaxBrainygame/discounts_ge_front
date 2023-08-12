import 'package:discounts_ge_front/widgets/app/splash.dart';
import 'package:discounts_ge_front/widgets/list_products/list_products.dart';
import 'package:discounts_ge_front/widgets/list_promotions/list_promotions.dart';
import 'package:discounts_ge_front/widgets/list_shops/list_shops.dart';
import 'package:flutter/material.dart';

String gilroyFontFamily = "Gilroy";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff4e4590),
            // secondary: const Color(0xff4e4590), // Your accent color
          ),

          fontFamily: gilroyFontFamily 
        ),
        home: const SplashScreen(),
        routes: {
          '/promotions': (context) => const ListPromotions(),
          '/goods': (context) => const ListProducts(),
          '/shops': (context) => const ListShops(),
        });
  }
}
