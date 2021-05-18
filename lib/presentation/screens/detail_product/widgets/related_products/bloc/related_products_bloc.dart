import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/related_products/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProductsBloc
    extends Bloc<RelatedProductsEvent, RelatedProductsState> {
  ProductRepository _productRepository = AppRepository.productRepository;

  RelatedProductsBloc() : super(RelatedProductsLoading());

  /// Map from load related products event to states
  @override
  Stream<RelatedProductsState> mapEventToState(
      RelatedProductsEvent event) async* {
    if (event is LoadRelatedProducts) {
      yield* _mapLoadRelatedProductsToState(event);
    } else if (event is OnSeeAll) {
      yield* _mapOnSeeAllToState(event);
    }
  }

  Stream<RelatedProductsState> _mapLoadRelatedProductsToState(
      LoadRelatedProducts event) async* {
    try {
      var products = await _productRepository.fetchProductsByCategory(
        event.product.categoryId,
      );
      final relatedProducts =
          products.where((product) => product.id != event.product.id).toList();
      yield RelatedProductsLoaded(relatedProducts);
    } catch (e) {
      yield RelatedProductsLoadFailure(e.toString());
    }
  }

  Stream<RelatedProductsState> _mapOnSeeAllToState(OnSeeAll event) async* {
    try {
      var category = await _productRepository.getCategoryById(event.categoryId);
      yield GoToCategoriesScreen(category);
    } catch (e) {}
  }
}
