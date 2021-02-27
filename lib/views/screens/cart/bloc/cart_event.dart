import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

/// When open cart screen -> load cart event
class LoadCart extends CartEvent {}

/// When user clicks to a clear cart => clear cart event
class ClearCart extends CartEvent {}

/// When user swipes to remove cart item => remove cart item event
class RemoveCartItem extends CartEvent {
  final String pid;

  RemoveCartItem(this.pid);

  @override
  List<Object> get props => [pid];
}

/// When user clicks to change quantity => update cart event
class UpdateCartItem extends CartEvent {
  final CartItem cartItem;

  UpdateCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem.cid];
}

/// Cart was cleared
class CartChanged extends CartEvent {
  final List<CartItem> cart;

  CartChanged(this.cart);

  @override
  List<Object> get props => [cart];
}
