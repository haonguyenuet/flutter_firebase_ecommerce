import 'package:e_commerce_app/business_logic/repositories/detail_product_repo.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RelatedProductsBloc
    extends Bloc<RelatedProductsEvent, RelatedProductsState> {
  DetailProductRepository _detailProductRepository;

  RelatedProductsBloc({
    @required DetailProductRepository detailProductRepository,
  })  : assert(detailProductRepository != null),
        _detailProductRepository = detailProductRepository,
        super(RelatedProductsLoading());

  /// Map from load related products event to states
  @override
  Stream<RelatedProductsState> mapEventToState(
      RelatedProductsEvent event) async* {
    if (event is LoadRelatedProducts) {
      try {
        final relatedProducts =
            await _detailProductRepository.getRelatedProducts(
          event.pid,
          event.categoryId,
        );
        yield RelatedProductsLoaded(relatedProducts: relatedProducts);
      } catch (e) {
        yield RelatedProductsNotLoaded(e);
      }
    }
  }
}
