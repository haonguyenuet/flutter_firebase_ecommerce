import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class CartItem {
  final String pid;
  final Product product;
  final int numberOfItems;

  CartItem({
    @required this.pid,
    @required this.product,
    @required this.numberOfItems,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  // get cart items
  Map<String, CartItem> get getCart => _cartItems;

  // Add item
  void addItem(CartItem newItem) {
    if (_cartItems.containsKey(newItem.pid)) {
      _cartItems.update(
        newItem.pid,
        (existingItem) => CartItem(
          pid: newItem.pid,
          product: newItem.product,
          numberOfItems: existingItem.numberOfItems + newItem.numberOfItems,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        newItem.pid,
        () => CartItem(
          pid: newItem.pid,
          product: newItem.product,
          numberOfItems: newItem.numberOfItems,
        ),
      );
    }
    notifyListeners();
  }

  // Remove item
  void removeItem(String pid) {
    _cartItems.remove(pid);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // get price of cart
  int getPrice() {
    int totalPrice = 0;
    _cartItems.forEach((key, cartItem) {
      totalPrice += cartItem.product.price * cartItem.numberOfItems;
    });
    return totalPrice;
  }
}
