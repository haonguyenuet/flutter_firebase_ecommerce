import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/services/abstract/i_category_service.dart';

/// Cart is collection in each user
class CategoryService extends ICategoryService {
  @override
  Future<List<Category>> getCategories() async {
    return await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Category.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((err) => print(err));
  }
}
