import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProductsBloc
    extends Bloc<RelatedProductsEvent, RelatedProductsState> {
  ProductRepository _productRepository;

  RelatedProductsBloc({
    required ProductRepository productRepository,
  })   : _productRepository = productRepository,
        super(RelatedProductsLoading());

  /// Map from load related products event to states
  @override
  Stream<RelatedProductsState> mapEventToState(
      RelatedProductsEvent event) async* {
    if (event is LoadRelatedProducts) {
      try {
        var products = await _productRepository.getProductsByCategory(
          event.categoryId,
        );
        final relatedProducts =
            products.where((product) => product.id != event.pid).toList();
        yield RelatedProductsLoaded(relatedProducts: relatedProducts);
      } catch (e) {
        yield RelatedProductsLoadFailure(e.toString());
      }
    }
  }
}
