import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';

abstract class RelatedProductsEvent extends Equatable {
  const RelatedProductsEvent();
}

/// When user clicks to a specific product => load related products
class LoadRelatedProducts extends RelatedProductsEvent {
  final Product product;

  LoadRelatedProducts(this.product);

  @override
  List<Object> get props => [product];
}
