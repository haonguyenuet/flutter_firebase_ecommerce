import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';

abstract class IProductService {
  // get all products
  Future<List<Product>> getProducts();

  // get products by category
  Future<List<Product>> getProductsByCategory({Category category});

  // get product by Id
  Future<Product> getProductById(String pid);

  // Update product rating
  Future<void> updateProductRatingById(String pid, double rating);
}
