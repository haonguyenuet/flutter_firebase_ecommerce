import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("transactions");

  // products
  Stream<List<Product>> getProducts() {
    return productCollection.snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Product.fromDoc(doc)).toList(),
        );
  }

  // users
  Future setUserData(User user) async {
    Map<String, dynamic> userData = {
      "id": user.uid,
      "email": user.email ?? "Unknown",
      "name": user.displayName ?? "Unknown",
      "avatar": user.photoURL ?? "Unknown",
    };
    return await userCollection.doc(user.uid).set(userData);
  }

  // Future setCartData(String userId, Cart cart) async {
  //   CollectionReference cartCollection = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userId)
  //       .collection("cart");
  //   List<CartItem> cartItems = cart.cartItems;
  // }
}
