import 'package:e_commerce_app/blocs/sign_in/sign_in_event.dart';
import 'package:e_commerce_app/blocs/sign_in/sign_in_state.dart';
import 'package:e_commerce_app/models/email.dart';
import 'package:e_commerce_app/models/password.dart';
import 'package:e_commerce_app/services/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationService _authenticationRepository;

  // AuthenticationBloc Constructor
  SignInBloc({@required AuthenticationService authenticationRepository})
      : assert(AuthenticationService != null),
        _authenticationRepository = authenticationRepository,
        super(const SignInState());

  @override
  Stream<SignInState> mapEventToState(SignInEvent signInEvent) async* {
    if (signInEvent is SignInEmailChanged) {
      final email = Email.dirty(value: signInEvent.email);
      yield state.cloneWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (signInEvent is SignInPasswordChanged) {
      final password = Password.dirty(value: signInEvent.password);
      yield state.cloneWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (signInEvent is SignInWithCredentials) {
      // If email or password that is invalid, do nothing
      if (state.status.isInvalid) return;
      // else
      yield (state.cloneWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        yield (state.cloneWith(status: FormzStatus.submissionSuccess));
      } on Exception {
        yield (state.cloneWith(status: FormzStatus.submissionFailure));
      }
    } else if (signInEvent is SignInWithGoogle) {
      // If email or password that is invalid, do nothing
      if (state.status.isInvalid) return;
      // else
      yield (state.cloneWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logInWithGoogle();
        yield (state.cloneWith(status: FormzStatus.submissionSuccess));
      } on Exception {
        yield (state.cloneWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
