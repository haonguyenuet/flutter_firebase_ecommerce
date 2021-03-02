import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_event.dart';

import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      bool isLoggedIn = _authRepository.isLoggedIn();

      //For display splash screen
      await Future.delayed(Duration(seconds: 3));

      if (isLoggedIn) {
        // Get current user
        final loggedFirebaseUser = _authRepository.currentFirebaseUser;
        yield Authenticated(loggedFirebaseUser);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(_authRepository.currentFirebaseUser);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authRepository.logOut();
  }
}
