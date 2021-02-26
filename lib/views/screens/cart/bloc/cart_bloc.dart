import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/user_repo.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
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
      var cart = await _cartRepository.getCart(currUser.id);
      var sum = 0;
      cart.forEach((c) => sum += c.price);

      yield CartLoaded(CartResponse(
        cart: cart,
        totalCartPrice: formatNumber(sum),
      ));
    } catch (e) {
      yield CartLoadFailure(e);
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

class CartResponse {
  final List<CartItem> cart;
  final String totalCartPrice;

  CartResponse({this.cart, this.totalCartPrice});
}
