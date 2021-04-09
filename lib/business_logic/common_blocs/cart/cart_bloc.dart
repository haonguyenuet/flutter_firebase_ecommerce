import 'dart:async';

import 'package:e_commerce_app/business_logic/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/app_repository.dart';
import 'package:e_commerce_app/business_logic/repository/auth_repository/auth_repo.dart';
import 'package:e_commerce_app/business_logic/repository/cart_repository/cart_repo.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AuthRepository _authRepository = AppRepository.authRepository;
  final CartRepository _cartRepository = AppRepository.cartRepository;
  final ProductRepository _productRepository = AppRepository.productRepository;
  late User _loggedFirebaseUser;
  StreamSubscription? _cartStreamSub;

  CartBloc() : super(CartLoading());

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
      _cartStreamSub?.cancel();
      _loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      _cartStreamSub = _cartRepository
          .cartStream(_loggedFirebaseUser.uid)
          .listen((cart) => add(CartUpdated(cart)));
    } catch (e) {
      yield CartLoadFailure(e.toString());
    }
  }

  Stream<CartState> _mapAddCartItemToState(AddCartItem event) async* {
    try {
      await _cartRepository.addCartItem(
          _loggedFirebaseUser.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapRemoveCartItemToState(RemoveCartItem event) async* {
    try {
      await _cartRepository.removeCartItem(
        _loggedFirebaseUser.uid,
        event.cartItem,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapUpdateCartItemToState(UpdateCartItem event) async* {
    try {
      await _cartRepository.updateCartItem(
        _loggedFirebaseUser.uid,
        event.cartItem,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapClearCartToState() async* {
    try {
      await _cartRepository.clearCart(_loggedFirebaseUser.uid);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapCartUpdatedToState(CartUpdated event) async* {
    yield CartLoading();

    var updatedCart = event.updatedCart;
    var priceOfGoods = 0;
    for (var i = 0; i < updatedCart.length; i++) {
      priceOfGoods += updatedCart[i].price;
      // Get product by id that is provided from cart item
      try {
        var productInfo =
            await _productRepository.getProductById(updatedCart[i].productId);
        updatedCart[i] = updatedCart[i].cloneWith(productInfo: productInfo);
      } catch (e) {
        yield CartLoadFailure(e.toString());
      }
    }

    yield CartLoaded(
      cart: updatedCart,
      priceOfGoods: priceOfGoods,
    );
  }

  @override
  Future<void> close() {
    _cartStreamSub?.cancel();
    return super.close();
  }
}