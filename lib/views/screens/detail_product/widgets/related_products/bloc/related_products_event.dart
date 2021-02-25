import 'package:equatable/equatable.dart';

abstract class RelatedProductsEvent extends Equatable {
  const RelatedProductsEvent();
}

/// When user clicks to a specific product => load related products
class LoadRelatedProducts extends RelatedProductsEvent {
  final String pid;
  final String categoryId;

  LoadRelatedProducts(this.pid, this.categoryId);
  @override
  // TODO: implement props
  List<Object> get props => [pid, categoryId];
}
