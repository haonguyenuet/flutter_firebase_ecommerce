import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/services/abstract/i_category_service.dart';
import 'package:e_commerce_app/services/category_service.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  ICategoryService _categoryService = CategoryService();
  List<Category> _categories = [];
 

  CategoryProvider() {
    getCategories();
  }

  void getCategories() async {
    _categories = await _categoryService.getCategories();
    notifyListeners();
  }

  List<Category> get categories => _categories;
}
