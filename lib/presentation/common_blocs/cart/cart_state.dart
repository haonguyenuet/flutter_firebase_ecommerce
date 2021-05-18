import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

/// Cart loading
class CartLoading extends CartState {}

/// Cart was loaded
class CartLoaded extends CartState {
  final List<CartItemModel> cart;
  final int priceOfGoods;

  CartLoaded({
    required this.cart,
    required this.priceOfGoods,
  });

  @override
  List<Object> get props => [cart, priceOfGoods];
}

/// Cart wasn't loaded
class CartLoadFailure extends CartState {
  final String error;

  CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
