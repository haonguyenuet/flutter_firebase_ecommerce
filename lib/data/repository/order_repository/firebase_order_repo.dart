import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/entities/entites.dart';
import 'package:e_commerce_app/data/repository/order_repository/order_repo.dart';

/// cart is collection in each user
class FirebaseOrderRepository implements OrderRepository {
  var orderCollection = FirebaseFirestore.instance.collection("orders");

  /// Get all cart items
  Future<List<Order>> getOrders(String uid) async {
    return orderCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data()!;
              return Order.fromMap(data);
            }).toList());
  }

  @override
  Future<void> addOrder(Order newOrder) async {
    await orderCollection.doc(newOrder.id).set(newOrder.toMap());
  }

  @override
  Future<void> removeOrder(Order order) async {
    await orderCollection.doc(order.id).delete();
  }

  ///Singleton factory
  static final FirebaseOrderRepository _instance =
      FirebaseOrderRepository._internal();

  factory FirebaseOrderRepository() {
    return _instance;
  }

  FirebaseOrderRepository._internal();
}
