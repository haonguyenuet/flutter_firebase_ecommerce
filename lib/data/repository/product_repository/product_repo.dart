import 'package:e_commerce_app/data/models/models.dart';

abstract class ProductRepository {
  /// Get all products
  /// Created by NDH
  Future<List<Product>> fetchProducts();

  /// Get popular products
  /// Created by NDH
  Future<List<Product>> fetchPopularProducts();

  /// Get discount products
  /// Created by NDH
  Future<List<Product>> fetchDiscountProducts();

  /// Get products by category
  /// [categoryId] is id of category
  /// Created by NDH
  Future<List<Product>> fetchProductsByCategory(String? categoryId);

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
  Future<List<CategoryModel>> getCategories();

  /// Get category by id
  /// Created by NDH
  Future<CategoryModel> getCategoryById(String caregoryId);
}
