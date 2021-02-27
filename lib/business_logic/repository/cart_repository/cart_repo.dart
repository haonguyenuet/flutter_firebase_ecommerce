import 'package:e_commerce_app/business_logic/entities/cart_item.dart';

abstract class CartRepository {
  // Get all cart items
  Stream<List<CartItem>> cartStream(String uid);

  // Add item
  Future<void> addCartItem(String uid, CartItem newItem);

  // Remove item
  Future<void> removeCartItem(String uid, String pid);

  // Clear cart
  Future<void> clearCart(String uid);

  // Update quantity
  Future<void> updateCartItem(String uid, CartItem cartItem);
}
