import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/services/abstract/i_cart_service.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cart = [];
  ICartService _cartService;

  void setId(userId) {
    _cartService = CartService(uid: userId);
  }

  // Get all cart items
  void getCart() async {
    _cart = await _cartService.getCart() ?? [];
    notifyListeners();
  }

  // Add item
  void addItem(CartItem newItem) async {
    await _cartService.addCartItem(newItem);
    this.getCart();
  }

  // Remove item
  void removeItem(String pid) async {
    await _cartService.removeCartItem(pid);
    this.getCart();
  }

  // Clear cart
  void clearCart() async {
    await _cartService.clearCart();
    this.getCart();
  }

  // Update quantity and price of cart item
  void updateCartItem(CartItem cartItem) async {
    await _cartService.updateCartItem(cartItem);
    this.getCart();
  }

  // Get price of cart
  int getPrice() {
    int totalPrice = 0;
    _cart.forEach((cartItem) {
      totalPrice += cartItem.price;
    });
    return totalPrice;
  }

  int get number0fItems => _cart.length;
  List<CartItem> get cart => _cart;
}
