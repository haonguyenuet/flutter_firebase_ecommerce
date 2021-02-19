import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:meta/meta.dart';

import 'abstract/i_cart_service.dart';

// cart is collection in each user
class CartService extends ICartService {
  // Logged user id
  String uid;
  var userCollection = FirebaseFirestore.instance.collection("users");

  // Constructor
  CartService({@required this.uid});

  // Get all cart items
  Future<List<CartItem>> getCart() async {
    return await userCollection.doc(uid).collection("cart").get().then(
        (snapshot) => snapshot.docs
            .map((doc) => CartItem.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Add item
  Future<void> addCartItem(CartItem newItem) async {
    var userRef = userCollection.doc(uid);
    await userRef.collection("cart").doc(newItem.pid).get().then((doc) async {
      if (doc.exists) {
        // old data + new data
        var quantity = doc.data()["quantity"] + newItem.quantity;
        var price = doc.data()["price"] + newItem.price;
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

  // Remove item
  Future<void> removeCartItem(String pid) async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .doc(pid)
        .delete()
        .catchError((error) => print(error));
  }

  // Clear cart
  Future<void> clearCart() async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }).catchError((error) => print(error));
  }

  // Update quantity
  Future<void> updateCartItem(CartItem cartItem) async {
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
