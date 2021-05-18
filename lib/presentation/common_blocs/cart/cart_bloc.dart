import 'dart:async';

import 'package:e_commerce_app/presentation/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/data/repository/app_repository.dart';
import 'package:e_commerce_app/data/repository/auth_repository/auth_repo.dart';
import 'package:e_commerce_app/data/repository/cart_repository/cart_repo.dart';
import 'package:e_commerce_app/data/repository/product_repository/product_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AuthRepository _authRepository = AppRepository.authRepository;
  final CartRepository _cartRepository = AppRepository.cartRepository;
  final ProductRepository _productRepository = AppRepository.productRepository;
  late User _loggedFirebaseUser;
  StreamSubscription? _fetchCartSub;

  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState(event);
    } else if (event is AddCartItemModel) {
      yield* _mapAddCartItemModelToState(event);
    } else if (event is RemoveCartItemModel) {
      yield* _mapRemoveCartItemModelToState(event);
    } else if (event is UpdateCartItemModel) {
      yield* _mapUpdateCartItemModelToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    } else if (event is CartUpdated) {
      yield* _mapCartUpdatedToState(event);
    }
  }

  Stream<CartState> _mapLoadCartToState(LoadCart event) async* {
    try {
      _fetchCartSub?.cancel();
      _loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      _fetchCartSub = _cartRepository
          .fetchCart(_loggedFirebaseUser.uid)
          .listen((cart) => add(CartUpdated(cart)));
    } catch (e) {
      yield CartLoadFailure(e.toString());
    }
  }

  Stream<CartState> _mapAddCartItemModelToState(AddCartItemModel event) async* {
    try {
      await _cartRepository.addCartItemModel(
          _loggedFirebaseUser.uid, event.cartItem);
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapRemoveCartItemModelToState(
      RemoveCartItemModel event) async* {
    try {
      await _cartRepository.removeCartItemModel(
        _loggedFirebaseUser.uid,
        event.cartItem,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<CartState> _mapUpdateCartItemModelToState(
      UpdateCartItemModel event) async* {
    try {
      await _cartRepository.updateCartItemModel(
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
    _fetchCartSub?.cancel();
    return super.close();
  }
}
