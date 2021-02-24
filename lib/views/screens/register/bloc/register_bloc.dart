import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';

import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/utils/validator.dart';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_event.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.empty());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
        event.password,
        event.confirmPassword,
      );
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.newUser,
        event.password,
        event.confirmPassword,
      );
    }
  }

  /// Map from email changed event => states
  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  /// Map from password changed event => states
  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    var isPasswordValid = Validators.isValidPassword(password);

    yield state.update(isPasswordValid: isPasswordValid);
  }

  /// Map from confirmed password changed event => states
  Stream<RegisterState> _mapConfirmPasswordChangedToState(
    String password,
    String confirmPassword,
  ) async* {
    var isConfirmPasswordValid = Validators.isValidPassword(confirmPassword);
    var isMatched = true;

    if (password.isNotEmpty) {
      isMatched = password == confirmPassword;
    }

    yield state.update(
      isConfirmPasswordValid: isConfirmPasswordValid && isMatched,
    );
  }

  /// Map from submit event => states
  Stream<RegisterState> _mapFormSubmittedToState(
    UserModel newUser,
    String password,
    String confirmPassword,
  ) async* {
    try {
      yield RegisterState.loading();
      await _userRepository.signUp(newUser, password);
      if (_userRepository.isLoggedIn()) {
        yield RegisterState.success();
      } else {
        final message = _userRepository.authException ?? "Login Failure";
        yield RegisterState.failure(message);
      }
    } catch (_) {
      yield RegisterState.failure("Register Failure");
    }
  }
}
