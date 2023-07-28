
import 'package:discounts_ge_front/domain/api_clients/api_client.dart';
import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:flutter/material.dart';

class ListPromotionModel extends ChangeNotifier {

  final apiClient = ApiClient();

  var _promotions = <Promotion>[];
  List<Promotion> get promotions => _promotions;

  Future<void> reloadPromotions(String shopHost) async{
    _promotions = await apiClient.getPromotions(shopHost);
    notifyListeners();
  }

}

class ListPromotionModelProvider extends InheritedNotifier {
  final ListPromotionModel model;

  const ListPromotionModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ListPromotionModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListPromotionModelProvider>();
  }

  static ListPromotionModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListPromotionModelProvider>()
        ?.widget;
    return widget is ListPromotionModelProvider ? widget : null;
  }

}