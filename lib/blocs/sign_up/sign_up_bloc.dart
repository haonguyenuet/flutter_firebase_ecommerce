import 'package:e_commerce_app/blocs/sign_up/sign_up_event.dart';
import 'package:e_commerce_app/blocs/sign_up/sign_up_state.dart';
import 'package:e_commerce_app/models/confirmed_password.dart';
import 'package:e_commerce_app/models/email.dart';
import 'package:e_commerce_app/models/password.dart';
import 'package:e_commerce_app/services/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationRepository;

  // AuthenticationBloc Constructor
  SignUpBloc({@required AuthenticationService authenticationRepository})
      : assert(AuthenticationService != null),
        _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent signUpEvent) async* {
    if (signUpEvent is SignUpEmailChanged) {
      final email = Email.dirty(value: signUpEvent.email);
      yield state.cloneWith(
        email: email,
        status:
            Formz.validate([email, state.password, state.confirmedPassword]),
      );
    } else if (signUpEvent is SignUpPasswordChanged) {
      final password = Password.dirty(
        value: signUpEvent.password,
      );
      yield state.cloneWith(
        password: password,
        status:
            Formz.validate([state.email, password, state.confirmedPassword]),
      );
    } else if (signUpEvent is SignUpConfirmedPasswordChanged) {
      final confirmedPassword = ConfirmedPassword.dirty(
        password: state.password.value,
        value: signUpEvent.confirmedPassword,
      );
      yield state.cloneWith(
        confirmedPassword: confirmedPassword,
        status:
            Formz.validate([state.email, state.password, confirmedPassword]),
      );
    } else if (signUpEvent is SignUpWithCredentials) {
      // If email or password that is invalid, do nothing
      if (state.status.isInvalid) return;
      // else
      yield (state.cloneWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        yield (state.cloneWith(status: FormzStatus.submissionSuccess));
      } on Exception {
        yield (state.cloneWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
