import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';

/// cart is collection in each user
class FirebaseCartRepository implements CartRepository {
  var userCollection = FirebaseFirestore.instance.collection("users");

  /// Get all cart items
  Stream<List<CartItem>>? cartStream(String uid) {
    try {
      return userCollection.doc(uid).collection("cart").snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => CartItem.fromMap(doc.id, doc.data()!))
              .toList());
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// Add item
  /// Created by NDH
  Future<void> addCartItem(String uid, CartItem newItem) async {
    var userRef = userCollection.doc(uid);
    await userRef.collection("cart").doc(newItem.pid).get().then((doc) async {
      if (doc.exists) {
        // old data + new data
        var quantity = doc.data()!["quantity"] + newItem.quantity;
        var price = doc.data()!["price"] + newItem.price;
        // update
        await doc.reference.update({"quantity": quantity, "price": price});
      } else {
        // add new
        await doc.reference.set(newItem.toMap());
        print("success");
      }
    }).catchError((error) {
      print(error);
    });
  }

  /// Remove item
  /// Created by NDH
  Future<void> removeCartItem(String uid, String? cid) async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .doc(cid)
        .delete()
        .catchError((error) => print(error));
  }

  /// Clear cart
  /// Created by NDH
  Future<void> clearCart(String uid) async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }).catchError((error) {});
  }

  /// Update quantity of cart item
  /// Created by NDH
  Future<void> updateCartItem(String uid, CartItem cartItem) async {
    var userRef = userCollection.doc(uid);
    await userRef.collection("cart").doc(cartItem.pid).get().then((doc) async {
      if (doc.exists) {
        // old quantity + new quantity
        var quantity = cartItem.quantity;
        var price = cartItem.price;
        // update
        await doc.reference.update({"quantity": quantity, "price": price});
      }
    }).catchError((error) {
      print(error);
    });
  }
}
