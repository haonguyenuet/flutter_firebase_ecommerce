import 'package:e_commerce_app/business_logic/repositories/detail_product_repo.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductRepository _detailProductRepository;
  UserRepository _userRepository;

  DetailProductBloc({
    @required DetailProductRepository detailProductRepository,
    @required UserRepository userRepository,
  })  : assert(detailProductRepository != null),
        assert(userRepository != null),
        _detailProductRepository = detailProductRepository,
        _userRepository = userRepository,
        super(null);

  @override
  Stream<DetailProductState> mapEventToState(DetailProductEvent event) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    }
  }

  /// Map from add to cart event to states
  Stream<DetailProductState> _mapAddToCartToState(AddToCart event) async* {
    try {
      var currentUser = _userRepository.currentUser;
      await _detailProductRepository.addToCart(currentUser.id, event.cartItem);
      yield Adding();
      //for loading screen
      await Future.delayed(Duration(seconds: 1));
      yield AddSuccess();
    } catch (e) {
      yield AddFailure(e);
    }
  }
}
