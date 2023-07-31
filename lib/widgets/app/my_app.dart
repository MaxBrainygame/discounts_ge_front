import 'package:discounts_ge_front/widgets/app/splash.dart';
import 'package:discounts_ge_front/widgets/list_products/list_products.dart';
import 'package:discounts_ge_front/widgets/list_promotions/list_promotions.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: {
        '/promotions':(context) => const ListPromotions(),
        '/goods':(context) => const ListProducts(), 
      },
    );
  }
}