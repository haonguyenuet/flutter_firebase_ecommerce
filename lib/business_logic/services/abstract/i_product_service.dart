import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';

abstract class IProductService {
  // get all products
  Future<List<Product>> getProducts();

  // get products by category
  Future<List<Product>> getProductsByCategory(Category category);

  // get product by Id
  Future<Product> getProductById(String pid);

  // Update product rating
  Future<void> updateProductRatingById(String pid, double rating);
}
