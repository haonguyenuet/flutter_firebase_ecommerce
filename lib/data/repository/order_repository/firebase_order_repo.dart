import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/order_repository/order_repo.dart';

/// cart is collection in each user
class FirebaseOrderRepository implements OrderRepository {
  var orderCollection = FirebaseFirestore.instance.collection("orders");

  /// Get all cart items
  Future<List<OrderModel>> fetchOrders(String uid) async {
    return orderCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data()!;
              return OrderModel.fromMap(data);
            }).toList());
  }

  @override
  Future<void> addOrderModel(OrderModel newOrderModel) async {
    await orderCollection.doc(newOrderModel.id).set(newOrderModel.toMap());
  }

  @override
  Future<void> removeOrderModel(OrderModel order) async {
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
