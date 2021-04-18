import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data/repository/app_repository.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = AppRepository.authRepository;

  LoginBloc() : super(LoginState.empty());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is EmailChanged || event is PasswordChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream = events
        .where((event) => event is! EmailChanged && event is! PasswordChanged);
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
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
    yield state.update(isEmailValid: UtilValidators.isValidEmail(email));
  }

  /// Map from  password changed event => states
  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
        isPasswordValid: UtilValidators.isValidPassword(password));
  }

  /// Map from login event => states
  Stream<LoginState> _mapLoginWithCredentialToState(
      String email, String password) async* {
    try {
      yield LoginState.logging();

      await _authRepository.logInWithEmailAndPassword(email, password);
      bool isLoggedIn = _authRepository.isLoggedIn();
      if (isLoggedIn) {
        yield LoginState.success();
      } else {
        final message = _authRepository.authException;
        yield LoginState.failure(message);
      }
    } catch (e) {
      yield LoginState.failure("Login Failure");
    }
  }
}
