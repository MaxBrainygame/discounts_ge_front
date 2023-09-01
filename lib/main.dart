import 'dart:core';
import 'package:discounts_ge_front/widgets/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs,));
}

// Future<List<Shops>?> _updateData(url) async{
//   var response = await http.get(url);
//   if (response.statusCode == 200) {
//     final jsonResponse = jsonDecode(response.body) as List<dynamic>;
//     final shops = jsonResponse.map((e) => Shops.fromJson(e as Map<String, dynamic>)).toList();
//     return shops;
//   } else {
//     print('Request failed with status: ${response.statusCode}.');
//     return null;
//   }
// }

