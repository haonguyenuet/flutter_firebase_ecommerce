import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// When open cart screen -> load cart event
class LoadCart extends CartEvent {}

/// When user clicks to a clear cart => clear cart event
class ClearCart extends CartEvent {}

/// Cart was cleared
class CartUpdated extends CartEvent {
  final List<CartItem> updatedCart;

  CartUpdated(this.updatedCart);

  @override
  List<Object> get props => [updatedCart];
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
  final CartItem cartItem;

  RemoveCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

/// When user clicks to change quantity => update cart event
class UpdateCartItem extends CartEvent {
  final CartItem cartItem;

  UpdateCartItem(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}
