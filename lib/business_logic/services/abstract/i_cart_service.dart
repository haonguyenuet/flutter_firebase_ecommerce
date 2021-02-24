import 'package:e_commerce_app/business_logic/entities/cart_item.dart';

abstract class ICartService {
// Get all cart items
  Future<List<CartItem>> getCart();

  // Add item
  Future<void> addCartItem(CartItem newItem);

  // Remove item
  Future<void> removeCartItem(String pid);

  // Clear cart
  Future<void> clearCart();

  // Update quantity
  Future<void> updateCartItem(CartItem cartItem);
}
