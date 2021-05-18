import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/models/models.dart';
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

  RelatedProductsLoaded(this.relatedProducts);
  @override
  List<Object> get props => [relatedProducts];
}

/// When related products wasn't loaded => related products not loaded state
class RelatedProductsLoadFailure extends RelatedProductsState {
  final String error;

  RelatedProductsLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}

class GoToCategoriesScreen extends RelatedProductsState {
  final CategoryModel category;

  GoToCategoriesScreen(this.category);
  @override
  List<Object> get props => [category];
}
