import 'package:e_commerce_app/business_logic/entities/category.dart';

abstract class ICategoryService {
// Get all cart items
  Future<List<Category>> getCategories();
}
