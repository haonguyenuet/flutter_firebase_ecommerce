import 'package:equatable/equatable.dart';

/// Cart item model
class CartItem extends Equatable {
  /// Cart item id
  final String id;

  /// Product id
  final String productId;

  /// Product quantity in the cart
  final int quantity;

  /// Product price * quantity
  final int price;

  /// Checkout or not ?
  final bool? isActive;

  /// Constructor
  CartItem(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      this.isActive});

  /// Json data from server turns into model data
  static CartItem fromMap(Map<String, dynamic> data) {
    return CartItem(
      id: data["id"] ?? "",
      productId: data["productId"],
      price: data["price"],
      quantity: data["quantity"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "productId": this.productId,
      "price": this.price,
      "quantity": this.quantity,
    };
  }

  /// Clone and update
  CartItem cloneWith({
    id,
    productId,
    price,
    quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, quantity, price, productId];
}
