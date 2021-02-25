import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_product_service.dart';

class ProductService extends IProductService {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

  /// Get all products
  @override
  Future<List<Product>> getProducts() async {
    return await productCollection
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((error) => print(error));
  }

  /// Get products by category
  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    return await productCollection
        .where("categoryId", isEqualTo: categoryId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((error) => print(error));
  }

  /// Get product by Id
  @override
  Future<Product> getProductById(String pid) async {
    return await productCollection
        .doc(pid)
        .get()
        .then((doc) => Product.fromMap(doc.id, doc.data()))
        .catchError((error) => print(error));
  }

  @override

  /// Update product rating
  Future<void> updateProductRatingById(String pid, double rating) async {
    return await productCollection
        .doc(pid)
        .update({"rating": rating}).catchError((error) => print(error));
  }
}
