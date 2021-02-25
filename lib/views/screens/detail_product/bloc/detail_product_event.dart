import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();
}

/// When user clicks to a add to cart button
class AddToCart extends DetailProductEvent {
  final CartItem cartItem;

  AddToCart(this.cartItem);

  @override
  // TODO: implement props
  List<Object> get props => [cartItem];
}
