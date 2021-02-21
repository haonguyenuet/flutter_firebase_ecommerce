import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

/// Cart item model
class CartItem {
  /// Cart item id
  final String cid;

  /// Product id
  final String pid;

  /// Product quantity in the cart
  final int quantity;

  /// Product price
  final int price;

  /// Checkout or not ?
  bool isActive;

  /// Constructor
  CartItem({
    @required this.cid,
    @required this.pid,
    @required this.price,
    @required this.quantity,
  });

  /// Json data from server turns into model data
  static CartItem fromMap(String id, Map<String, dynamic> data) {
    return CartItem(
      cid: id,
      pid: data["pid"],
      price: data["price"],
      quantity: data["quantity"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    Map<String, dynamic> cartItemData = {
      "cid": this.cid,
      "pid": this.pid,
      "price": this.price,
      "quantity": this.quantity,
    };
    return cartItemData;
  }

  /// Clone and update
  CartItem cloneWith({
    cid,
    pid,
    price,
    quantity,
  }) {
    return CartItem(
      cid: cid ?? this.cid,
      pid: pid ?? this.pid,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
