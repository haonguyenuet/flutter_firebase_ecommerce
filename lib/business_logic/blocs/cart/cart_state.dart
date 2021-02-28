import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
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
  final CartResponse cartResponse;

  CartLoaded(this.cartResponse);

  @override
  List<Object> get props => [cartResponse];
}

/// Cart wasn't loaded
class CartLoadFailure extends CartState {
  final String error;

  CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}