import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

/// Cart item model
class CartItemModel extends Equatable {
  /// Cart item id
  final String id;

  /// Product Id
  final String productId;

  /// Product quantity in the cart
  final int quantity;

  /// Product price * quantity
  final int price;

  /// Product info, only use in client side
  final Product? productInfo;

  /// Constructor
  CartItemModel({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    this.productInfo,
  });

  /// Json data from server turns into model data
  static CartItemModel fromMap(Map<String, dynamic> data) {
    return CartItemModel(
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
  CartItemModel cloneWith({
    id,
    productId,
    productInfo,
    price,
    quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productInfo: productInfo ?? this.productInfo,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, quantity, price, productId];
}
