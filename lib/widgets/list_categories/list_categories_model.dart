
import 'package:discounts_ge_front/domain/api_clients/api_client.dart';
import 'package:discounts_ge_front/domain/entity/categories.dart';
import 'package:flutter/material.dart';

class ListCategoriesModel extends ChangeNotifier {

  final apiClient = ApiClient();

  var _categories = <Categories>[];
  List<Categories> get categories => _categories;

  Future<void> reloadCategories() async{
    _categories = await apiClient.getCategories();
    notifyListeners();
  }

}

class ListCategoriesModelProvider extends InheritedNotifier {
  final ListCategoriesModel model;

  const ListCategoriesModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ListCategoriesModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListCategoriesModelProvider>();
  }

  static ListCategoriesModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListCategoriesModelProvider>()
        ?.widget;
    return widget is ListCategoriesModelProvider ? widget : null;
  }

}