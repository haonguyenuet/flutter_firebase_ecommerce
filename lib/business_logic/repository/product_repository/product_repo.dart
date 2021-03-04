import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';

abstract class ProductRepository {
  /// Get all products
  /// Created by NDH
  Future<List<Product>> getProducts();

  /// Get all products
  /// Created by NDH
  Future<List<Product>> getPopularProducts();

  /// Get products by category
  /// [categoryId] is id of category
  /// Created by NDH
  Future<List<Product>> getProductsByCategory(String categoryId);

  /// Get product by Id
  /// [pid] is product id
  /// Created by NDH
  Future<Product> getProductById(String pid);

  /// Update product rating
  /// [pid] is product id
  /// [rating] is updated rating
  /// Created by NDH
  Future<void> updateProductRatingById(String pid, double rating);

  /// Get all categories
  /// Created by NDH
  Future<List<Category>> getCategories();
}
