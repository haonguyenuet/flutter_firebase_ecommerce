import 'package:equatable/equatable.dart';

abstract class DetailProductState extends Equatable {
  const DetailProductState();
}

/// Cart item is adding to cart => Adding state
class Adding extends DetailProductState {
  @override
  List<Object> get props => [];
}

/// Cart item was added to cart => Add success state
class AddSuccess extends DetailProductState {
  @override
  List<Object> get props => [];
}

/// Cart item wasn't added to cart => Add failure state
class AddFailure extends DetailProductState {
  final String error;

  AddFailure(this.error);
  @override
  List<Object> get props => [error];
}
