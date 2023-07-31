

import 'package:discounts_ge_front/domain/api_clients/api_client.dart';
import 'package:discounts_ge_front/domain/entity/product.dart';
import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:flutter/material.dart';

class ListProductsModel extends ChangeNotifier {

  final apiClient = ApiClient();

  var _products = <Product>[];
  List<Product> get products => _products;

  Future<void> reloadProducts(Promotion promotion) async{
    _products = await apiClient.getProducts(promotion);
    notifyListeners();
  }

}

class ListProductsModelProvider extends InheritedNotifier {
  final ListProductsModel model;

  const ListProductsModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ListProductsModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListProductsModelProvider>();
  }

  static ListProductsModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListProductsModelProvider>()
        ?.widget;
    return widget is ListProductsModelProvider ? widget : null;
  }

}