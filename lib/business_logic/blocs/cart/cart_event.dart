import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// When open cart screen -> load cart event
class LoadCart extends CartEvent {
  final User loggedFirebaseUser;

  LoadCart(this.loggedFirebaseUser);

  List<Object?> get props => [loggedFirebaseUser];
}

/// When user clicks to a clear cart => clear cart event
class ClearCart extends CartEvent {}

/// Cart was cleared
class CartUpdated extends CartEvent {
  final List<CartItem> cart;

  CartUpdated(this.cart);

  @override
  List<Object> get props => [cart];
}

/// When user clicks to add button => add cart item event
class AddCartItem extends CartEvent {
  final CartItem cartItem;

  AddCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

/// When user swipes to remove cart item => remove cart item event
class RemoveCartItem extends CartEvent {
  final String? pid;

  RemoveCartItem(this.pid);

  @override
  List<Object?> get props => [pid];
}

/// When user clicks to change quantity => update cart event
class UpdateCartItem extends CartEvent {
  final CartItem cartItem;

  UpdateCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem.cid];
}
