import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/user_repo.dart';
import 'package:e_commerce_app/utils/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is EmailChanged || event is PasswordChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream = events
        .where((event) => event is! EmailChanged && event is! PasswordChanged);
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredential) {
      yield* _mapLoginWithCredentialToState(event.email, event.password);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
  }

  /// Map from email changed event => states
  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  /// Map from  password changed event => states
  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  /// Map from login event => states
  Stream<LoginState> _mapLoginWithCredentialToState(
      String email, String password) async* {
    try {
      yield LoginState.logging();

      await _userRepository.logInWithEmailAndPassword(email, password);
      bool isLoggedIn = await _userRepository.isLoggedIn();
      if (isLoggedIn) {
        yield LoginState.success();
      } else {
        final message = _userRepository.authException ?? "Login Failure";
        yield LoginState.failure(message);
      }
    } catch (e) {
      yield LoginState.failure("Login Failure");
    }
  }
}
