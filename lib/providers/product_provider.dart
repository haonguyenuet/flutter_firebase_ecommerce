import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/services/abstract/i_product_service.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  IProductService _productService = ProductService();
  List<Product> _products = [];
  List<Product> _productsByCategory = [];
  Category _filterCategory = Category.all;

  /// Constructor
  /// Created by NDH
  ProductProvider() {
    getProducts();
  }

  /// Get all products
  /// Created by NDH
  void getProducts() async {
    _products = await _productService.getProducts() ?? [];
    notifyListeners();
  }

  /// Get products by category, defalut is get all products
  /// Created by NDH
  void getProductsByCategory({Category filterCategory = Category.all}) async {
    // set filter category
    _filterCategory = filterCategory;
    if (_filterCategory == Category.all) {
      _productsByCategory = await _productService.getProducts() ?? [];
    } else {
      _productsByCategory =
          await _productService.getProductsByCategory(_filterCategory) ?? [];
    }
    notifyListeners();
  }

  /// Get product by id
  /// Created by NDH
  Future<Product> getProductById(String id) async {
    return await _productService.getProductById(id);
  }

  /// Update product rating
  /// Created by NDH
  void updateProductRatingById(String pid, double rating) async {
    await _productService.updateProductRatingById(pid, rating);
    notifyListeners();
  }

  /// Getter
  /// Created by NDH
  Category get filterCategory => _filterCategory;
  List<Product> get products => _products;
  List<Product> get productsByCategory => _productsByCategory;
  int getLength() => _products.length;
}
