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

  /// Get all cart items
  /// Created by NDH
  void getCart() async {
    _cart = await _cartService.getCart() ?? [];
    notifyListeners();
  }

  /// Add new item [cartItem]
  /// Created by NDH
  void addItem(CartItem cartItem) async {
    await _cartService.addCartItem(cartItem);
    this.getCart();
  }

  /// Remove item by id [cid]
  /// Created by NDH
  void removeItem(String cid) async {
    await _cartService.removeCartItem(cid);
    this.getCart();
  }

  /// Clear cart
  /// Created by NDH
  void clearCart() async {
    await _cartService.clearCart();
    this.getCart();
  }

  /// Update quantity and price of cart item
  /// Created by NDH
  void updateCartItem(CartItem cartItem) async {
    await _cartService.updateCartItem(cartItem);
    this.getCart();
  }

  /// Get total price of cart
  /// Created by NDH
  int getPrice() {
    int totalPrice = 0;
    _cart.forEach((cartItem) {
      totalPrice += cartItem.price;
    });
    return totalPrice;
  }

  /// Getter
  /// Created by NDH
  int get number0fItems => _cart.length;
  List<CartItem> get cart => _cart;
}
