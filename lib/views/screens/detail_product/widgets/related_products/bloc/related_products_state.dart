import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:equatable/equatable.dart';

abstract class RelatedProductsState extends Equatable {
  const RelatedProductsState();
}

/// When open detail product screen => loading related products state
class RelatedProductsLoading extends RelatedProductsState {
  @override
  List<Object> get props => [];
}

/// When related products was loaded => related products loaded state
class RelatedProductsLoaded extends RelatedProductsState {
  final List<Product> relatedProducts;

  RelatedProductsLoaded({this.relatedProducts});
  @override
  List<Object> get props => [relatedProducts.length];
}

/// When related products wasn't loaded => related products not loaded state
class RelatedProductsNotLoaded extends RelatedProductsState {
  final String error;

  RelatedProductsNotLoaded(this.error);
  @override
  List<Object> get props => [error];
}
