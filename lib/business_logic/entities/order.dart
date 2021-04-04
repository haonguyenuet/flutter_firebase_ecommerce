import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String uid;
  final Timestamp createdDate;
  final Timestamp receivedDate;
  final String paymentMethod;
  final int price;
  final List<OrderItem> items;

  Order({
    required this.uid,
    required this.createdDate,
    required this.receivedDate,
    required this.items,
    required this.paymentMethod,
    required this.price,
  });
}

class OrderItem {
  final String productId;

  final String productName;

  final int productPrice;

  final String productImage;

  final int quantity;

  /// Constructor
  OrderItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });

  /// Json data from server turns into model data
  static OrderItem fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data["productId"],
      productImage: data["productImage"],
      productName: data["productName"],
      productPrice: data["productPrice"],
      quantity: data["quantity"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "productId": this.productId,
      "productName": this.productName,
      "productImage": this.productImage,
      "productPrice": this.productPrice,
      "quantity": this.quantity,
    };
  }
}
