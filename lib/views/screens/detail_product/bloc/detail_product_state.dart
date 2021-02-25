import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class DetailProductState extends Equatable {
  const DetailProductState();
}

/// When user clicks to add button => adding state
class Adding extends DetailProductState {
  @override
  List<Object> get props => [];
}

/// When cart item was added to cart => add success state
class AddSuccess extends DetailProductState {
  @override
  List<Object> get props => [];
}

/// When cart item wasn't added to cart => add failure state
class AddFailure extends DetailProductState {
  final String error;

  AddFailure(this.error);
  @override
  List<Object> get props => [error];
}
