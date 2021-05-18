import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/product_repository/product_repo.dart';

class FirebaseProductRepository implements ProductRepository {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

  /// Get all products
  /// Created by NDH
  @override
  Future<List<Product>> fetchProducts() async {
    return await productCollection
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()!))
            .toList())
        .catchError((error) {});
  }

  /// Get popular product by soldQuantity
  /// Created by NDH
  @override
  Future<List<Product>> fetchPopularProducts() async {
    return await productCollection
        .orderBy("soldQuantity", descending: true)
        .limit(10)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()!))
            .toList())
        .catchError((error) {});
  }

  /// Get discount product by percentOff
  /// Created by NDH
  @override
  Future<List<Product>> fetchDiscountProducts() async {
    return await productCollection
        .orderBy("percentOff", descending: true)
        .where("percentOff", isGreaterThan: 0)
        .limit(10)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()!))
            .toList())
        .catchError((error) {});
  }

  /// Get products by category
  /// [categoryId] is id of category
  /// Created by NDH
  @override
  Future<List<Product>> fetchProductsByCategory(String? categoryId) async {
    return await productCollection
        .where("categoryId", isEqualTo: categoryId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Product.fromMap(doc.id, doc.data()!))
            .toList())
        .catchError((error) {});
  }

  /// Get product by Id
  /// [pid] is product id
  /// Created by NDH
  @override
  Future<Product> getProductById(String? pid) async {
    return await productCollection
        .doc(pid)
        .get()
        .then((doc) => Product.fromMap(doc.id, doc.data()!))
        .catchError((error) {});
  }

  @override

  /// Update product rating
  /// [pid] is product id
  /// [rating] is updated rating
  /// Created by NDH
  Future<void> updateProductRatingById(String pid, double rating) async {
    return await productCollection
        .doc(pid)
        .update({"rating": rating}).catchError((error) {});
  }

  /// Get all categories
  /// Created by NDH
  @override
  Future<List<CategoryModel>> getCategories() async {
    return await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => CategoryModel.fromMap(doc.id, doc.data()!))
            .toList())
        .catchError((err) {});
  }

  /// Get category by id
  /// Created by NDH
  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    return await FirebaseFirestore.instance
        .collection("categories")
        .doc(categoryId)
        .get()
        .then((doc) => CategoryModel.fromMap(doc.id, doc.data()!))
        .catchError((err) {});
  }

  ///Singleton factory
  static final FirebaseProductRepository _instance =
      FirebaseProductRepository._internal();

  factory FirebaseProductRepository() {
    return _instance;
  }

  FirebaseProductRepository._internal();
}
