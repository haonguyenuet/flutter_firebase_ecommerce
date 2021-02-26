import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_cart_service.dart';
import 'package:e_commerce_app/business_logic/services/cart_service.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';

class CartRepository {
  final ICartService _cartService = CartService();

  Future<CartResponse> getCartData(String uid) async {
    List<CartItem> cart = await _cartService.getCart(uid) ?? [];
    int totalCartPrice = 0;
    if (cart.isNotEmpty) {
      cart.forEach((cartItem) => totalCartPrice += cartItem.price);
    }
    return CartResponse(cart, formatNumber(totalCartPrice));
  }

  Future<void> removeCartItem(String uid, String pid) async {
    await _cartService.removeCartItem(uid, pid);
  }

  Future<void> clearCart(String uid) async {
    await _cartService.clearCart(uid);
  }

  Future<void> updateCartItem(String uid, CartItem cartItem) async {
    await _cartService.updateCartItem(uid, cartItem);
  }
}

class CartResponse {
  final List<CartItem> cart;
  final String totalCartPrice;

  CartResponse(this.cart, this.totalCartPrice);
}
