import 'package:e_commerce_app/business_logic/entities/entites.dart';

abstract class OrderRepository {
  /// Get all orders
  /// [uid] is user id
  /// Created by NDH
  Future<List<Order>> getOrders(String uid);

  /// Add item
  /// [newOrder] is data of new order
  /// Created by NDH
  Future<void> addOrder(Order newOrder);
}
