import 'package:discounts_ge_front/domain/api_clients/api_client.dart';
import 'package:discounts_ge_front/domain/entity/categories.dart';
import 'package:discounts_ge_front/domain/entity/shop.dart';
import 'package:flutter/cupertino.dart';

class ListShopsModel extends ChangeNotifier {

  final apiClient = ApiClient();

  var _shops = <Shop>[];
  List<Shop> get shops => _shops;

  Future<void> reloadShops(Categories category) async{
    _shops = await apiClient.getShops(category);
    notifyListeners();
  }

}

class ListShopsModelProvider extends InheritedNotifier {
  final ListShopsModel model;

  const ListShopsModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ListShopsModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListShopsModelProvider>();
  }

  static ListShopsModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListShopsModelProvider>()
        ?.widget;
    return widget is ListShopsModelProvider ? widget : null;
  }

}