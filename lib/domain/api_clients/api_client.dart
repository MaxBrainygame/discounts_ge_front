import 'dart:io';
import 'dart:convert';

import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:discounts_ge_front/domain/entity/shop.dart';

class ApiClient {

  final client = HttpClient();

  Future<List<Shop>> getShops() async {

    final json = await get('http://10.0.2.2:8080/stores') as List<dynamic>;
    // final json = await get('http://65.0.125.153:8080/offers') as List<dynamic>;
    final shops = json.map((dynamic e) => Shop.fromJson(e as Map<String, dynamic>)).toList();

    return shops;

  }

  Future<List<Promotion>> getPromotions(String shopHost) async {

    final json = await get('http://10.0.2.2:8080/promotions?store=$shopHost') as List<dynamic>;
    // final json = await get('http://65.0.125.153:8080/offers') as List<dynamic>;
    final promotions = json.map((dynamic e) => Promotion.fromJson(e as Map<String, dynamic>)).toList();

    return promotions;

  }

  Future<dynamic> get(String ulr) async {

    final url = Uri.parse(ulr);
    final request = await client.getUrl(url);
    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString);
    return json;

  }

  }
  
