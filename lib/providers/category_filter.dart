import 'package:e_commerce_app/models/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryFilterProvider with ChangeNotifier {
  Category _currentCategory;
  String _orderSort;

  CategoryFilterProvider(this._currentCategory)
      : assert(_currentCategory != null);

  setFilter({
    Category currentCategory,
    String orderSort,
  }) {
    _currentCategory = currentCategory ?? this._currentCategory;
    _orderSort = orderSort ?? this._orderSort;
    notifyListeners();
  }

  // getter
  Category get currentCategory => _currentCategory;
  String get orderSort => _orderSort;
}
