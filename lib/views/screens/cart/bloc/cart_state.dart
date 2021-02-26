import 'package:e_commerce_app/business_logic/repositories/cart_repo.dart';
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
class CartNotLoaded extends CartState {
  final String error;

  CartNotLoaded(this.error);

  @override
  List<Object> get props => [error];
}

/// Cart was cleared
class CartChanged extends CartState {}

