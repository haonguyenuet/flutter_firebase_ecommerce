import 'package:e_commerce_app/models/category.dart';

abstract class ICategoryService {
// Get all cart items
  Future<List<Category>> getCategories();
}
