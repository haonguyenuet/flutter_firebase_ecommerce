import 'package:e_commerce_app/business_logic/blocs/user/bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/user/user_event.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _userRepository;
  CartRepository _cartRepository;

  UserBloc({
    @required UserRepository userRepository,
    @required CartRepository cartRepository,
  })  : assert(userRepository != null),
        assert(cartRepository != null),
        super(null);

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is LoadCurrentUser) {
      yield* _mapLoadCurrentUserToState();
    }
  }

  Stream<UserState> _mapLoadCurrentUserToState() async* {
    yield CurrUserLoading();
    try {
      var currentUser = _userRepository.currentUser;
      var cartLenght = await _cartRepository.getCartLength(currentUser.id);
      yield CurrUserLoaded(
        UserResponse(
          currentUser: currentUser,
          cartLength: cartLenght,
        ),
      );
    } catch (e) {
      print(e);
      yield CurrUserLoadFailure(e.toString());
    }
  }
}

class UserResponse {
  final UserModel currentUser;
  final int cartLength;

  UserResponse({this.currentUser, this.cartLength});
}
