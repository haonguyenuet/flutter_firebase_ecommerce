import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/app_repository.dart';

import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/register/register/bloc.dart';
import 'package:e_commerce_app/utils/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository = AppRepository.authRepository;

  RegisterBloc() : super(RegisterState.empty());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) =>
            event is EmailChanged ||
            event is PasswordChanged ||
            event is ConfirmPasswordChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream = events.where((event) =>
        event is! EmailChanged &&
        event is! PasswordChanged &&
        event is! ConfirmPasswordChanged);
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

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
      isEmailValid: UtilValidators.isValidEmail(email),
    );
  }

  /// Map from password changed event => states
  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    var isPasswordValid = UtilValidators.isValidPassword(password);

    yield state.update(isPasswordValid: isPasswordValid);
  }

  /// Map from confirmed password changed event => states
  Stream<RegisterState> _mapConfirmPasswordChangedToState(
    String password,
    String confirmPassword,
  ) async* {
    var isConfirmPasswordValid =
        UtilValidators.isValidPassword(confirmPassword);
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
      await _authRepository.signUp(newUser, password);

      bool isLoggedIn = _authRepository.isLoggedIn();
      if (isLoggedIn) {
        yield RegisterState.success();
      } else {
        final message = _authRepository.authException;
        yield RegisterState.failure(message);
      }
    } catch (e) {
      yield RegisterState.failure("Register Failure");
    }
  }
}
