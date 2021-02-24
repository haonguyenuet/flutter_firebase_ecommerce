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
    try {
      return await productCollection.get().then((snapshot) => snapshot.docs
          .map((doc) => Product.fromMap(doc.id, doc.data()))
          .toList());
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// Get products by category
  @override
  Future<List<Product>> getProductsByCategory(Category category) async {
    return await productCollection
        .where("categoryId", isEqualTo: category.cid)
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

  /// Update product rating
  Future<void> updateProductRatingById(String pid, double rating) async {
    return await productCollection
        .doc(pid)
        .update({"rating": rating}).catchError((error) => print(error));
  }
}
