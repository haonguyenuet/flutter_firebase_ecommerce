import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/abstract/i_product_service.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  IProductService _productService = ProductService();
  List<Product> _products = [];
  List<Product> _productsByCategory = [];

  ProductProvider() {
    getProducts();
  }

  // Get all products
  void getProducts() async {
    _products = await _productService.getProducts() ?? [];
    notifyListeners();
  }

  // Get products by category
  void getProductsByCategory(Category category) async {
    _productsByCategory =
        await _productService.getProductsByCategory(category: category) ?? [];
    notifyListeners();
  }

  // Get product by id
  Future<Product> getProductById(String id) async {
    return await _productService.getProductById(id);
  }

  // Update product rating
  void updateProductRatingById(String pid, double rating) async {
    await _productService.updateProductRatingById(pid, rating);
    notifyListeners();
  }

  List<Product> get products => _products;
  List<Product> get productsByCategory => _productsByCategory;
  int getLength() => _products.length;
}
