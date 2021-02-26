import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/user_repo.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  CartRepository _cartRepository;
  UserRepository _userRepository;

  DetailProductBloc({
    @required CartRepository cartRepository,
    @required UserRepository userRepository,
  })  : assert(cartRepository != null),
        assert(userRepository != null),
        _cartRepository = cartRepository,
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
      yield Adding();
      var currentUser = _userRepository.currentUser;
      await _cartRepository.addCartItem(currentUser.id, event.cartItem);
      yield AddSuccess();
    } catch (e) {
      yield AddFailure(e);
    }
  }
}
