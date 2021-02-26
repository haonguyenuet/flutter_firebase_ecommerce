import 'package:e_commerce_app/business_logic/repositories/cart_repo.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/views/screens/cart/bloc/cart_event.dart';
import 'package:e_commerce_app/views/screens/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  final UserRepository _userRepository;

  CartBloc({
    @required CartRepository cartRepository,
    @required UserRepository userRepository,
  })  : assert(cartRepository != null),
        assert(userRepository != null),
        _cartRepository = cartRepository,
        _userRepository = userRepository,
        super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState();
    } else if (event is RefreshCart) {
      yield CartLoading();
      yield* _mapLoadCartToState();
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemToState(event);
    } else if (event is UpdateCartItem) {
      yield* _mapUpdateCartItemToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    }
  }

  Stream<CartState> _mapLoadCartToState() async* {
    try {
      var currUser = _userRepository.currentUser;
      var cartResponse = await _cartRepository.getCartData(currUser.id);
      yield CartLoaded(cartResponse);
    } catch (e) {
      yield CartNotLoaded(e);
    }
  }

  Stream<CartState> _mapRemoveCartItemToState(RemoveCartItem event) async* {
    try {
      var currUser = _userRepository.currentUser;
      await _cartRepository.removeCartItem(currUser.id, event.pid);
      yield CartChanged();
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapUpdateCartItemToState(UpdateCartItem event) async* {
    try {
      var currUser = _userRepository.currentUser;
      await _cartRepository.updateCartItem(currUser.id, event.cartItem);
      yield CartChanged();
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapClearCartToState() async* {
    try {
      var currUser = _userRepository.currentUser;
      await _cartRepository.clearCart(currUser.id);
      yield CartChanged();
    } catch (e) {
      print(e);
    }
  }
}
