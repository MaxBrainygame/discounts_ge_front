
import 'package:discounts_ge_front/generated/l10n.dart';
import 'package:discounts_ge_front/widgets/app/locale_provider.dart';
import 'package:discounts_ge_front/widgets/app/splash.dart';
import 'package:discounts_ge_front/widgets/list_categories/list_categories.dart';
import 'package:discounts_ge_front/widgets/list_products/list_products.dart';
import 'package:discounts_ge_front/widgets/list_promotions/list_promotions.dart';
import 'package:discounts_ge_front/widgets/list_shops/list_shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String gilroyFontFamily = "Gilroy";

class MyApp extends StatelessWidget {
  final SharedPreferences _prefs;

  const MyApp({Key? key, required SharedPreferences prefs}) : _prefs = prefs, super(key: key);


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(_prefs),
      child: Consumer<LocaleProvider>(
        builder: (context, localeModel, child) => MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff4e4590),
              // secondary: const Color(0xff4e4590), // Your accent color
            ),
            fontFamily: gilroyFontFamily),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: localeModel.getLocale(),
        supportedLocales: S.delegate.supportedLocales,
        home: const SplashScreen(),
        routes: {
          '/promotions': (context) => const ListPromotions(),
          '/goods': (context) => const ListProducts(),
          '/shops': (context) => const ListShops(),
          '/categories': (context) => const ListCategories(),
        }),
      ),
    );

    // return 
  }
}
