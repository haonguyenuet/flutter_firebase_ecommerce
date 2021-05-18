import 'package:e_commerce_app/data/models/models.dart';

abstract class CartRepository {
  /// Cart stream
  /// [uid] is user id
  /// Created by NDH
  Stream<List<CartItemModel>> fetchCart(String uid);

  /// Add item
  /// [uid] is user id
  /// [newItem] is data of new cart item
  /// Created by NDH
  Future<void> addCartItemModel(String uid, CartItemModel newItem);

  /// Remove item
  /// [uid] is user id
  /// [cartItem] is data of cart item
  /// Created by NDH
  Future<void> removeCartItemModel(String uid, CartItemModel cartItem);

  /// Clear cart
  /// [uid] is user id
  /// Created by NDH
  Future<void> clearCart(String uid);

  /// Update quantity
  /// [uid] is user id
  /// [cartItem] is updated data of cart item
  /// Created by NDH
  Future<void> updateCartItemModel(String uid, CartItemModel cartItem);
}
