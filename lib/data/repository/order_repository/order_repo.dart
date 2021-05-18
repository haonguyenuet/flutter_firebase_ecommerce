import 'package:e_commerce_app/data/models/models.dart';

abstract class OrderRepository {
  /// Get all orders
  /// [uid] is user id
  /// Created by NDH
  Future<List<OrderModel>> fetchOrders(String uid);

  /// Add item
  /// [newOrderModel] is data of new order
  /// Created by NDH
  Future<void> addOrderModel(OrderModel newOrderModel);

  /// Add item
  /// [newOrderModel] is data of new order
  /// Created by NDH
  Future<void> removeOrderModel(OrderModel order);
}
