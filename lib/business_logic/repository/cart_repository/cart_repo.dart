import 'package:e_commerce_app/business_logic/entities/entites.dart';

abstract class CartRepository {
  /// Cart stream
  /// [uid] is user id
  /// Created by NDH
  Stream<List<CartItem>> cartStream(String uid);

  /// Add item
  /// [uid] is user id
  /// [newItem] is data of new cart item
  /// Created by NDH
  Future<void> addCartItem(String uid, CartItem newItem);

  /// Remove item
  /// [uid] is user id
  /// [cartItem] is data of cart item
  /// Created by NDH
  Future<void> removeCartItem(String uid, CartItem cartItem);

  /// Clear cart
  /// [uid] is user id
  /// Created by NDH
  Future<void> clearCart(String uid);

  /// Update quantity
  /// [uid] is user id
  /// [cartItem] is updated data of cart item
  /// Created by NDH
  Future<void> updateCartItem(String uid, CartItem cartItem);
}
