import 'dart:async';

import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  User _loggedUser;
  StreamSubscription _cartSubscription;

  CartBloc({@required CartRepository cartRepository})
      : assert(cartRepository != null),
        _cartRepository = cartRepository,
        super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState(event);
    } else if (event is AddCartItem) {
      yield* _mapAddCartItemToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemToState(event);
    } else if (event is UpdateCartItem) {
      yield* _mapUpdateCartItemToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    } else if (event is CartUpdated) {
      yield* _mapCartUpdatedToState(event);
    }
  }

  Stream<CartState> _mapLoadCartToState(LoadCart event) async* {
    try {
      _loggedUser = event.loggedFirebaseUser;
      _cartSubscription?.cancel();
      _cartSubscription = _cartRepository.cartStream(_loggedUser.uid).listen(
            (cart) => add(CartUpdated(cart)),
          );
    } catch (e) {
      yield CartLoadFailure(e);
    }
  }

  Stream<CartState> _mapAddCartItemToState(AddCartItem event) async* {
    try {
      await _cartRepository.addCartItem(_loggedUser.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapRemoveCartItemToState(RemoveCartItem event) async* {
    try {
      await _cartRepository.removeCartItem(_loggedUser.uid, event.pid);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapUpdateCartItemToState(UpdateCartItem event) async* {
    try {
      await _cartRepository.updateCartItem(_loggedUser.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapClearCartToState() async* {
    try {
      await _cartRepository.clearCart(_loggedUser.uid);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapCartUpdatedToState(CartUpdated event) async* {
    var sum = 0;
    event.cart.forEach((c) => sum += c.price);
    yield CartLoaded(CartResponse(
      cart: event.cart,
      totalCartPrice: formatNumber(sum),
    ));
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _loggedUser = null;
    return super.close();
  }
}

class CartResponse {
  final List<CartItem> cart;
  final String totalCartPrice;

  CartResponse({this.cart, this.totalCartPrice});
}
