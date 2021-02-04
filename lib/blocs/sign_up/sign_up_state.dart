import 'package:e_commerce_app/models/confirmed_password.dart';
import 'package:e_commerce_app/models/email.dart';
import 'package:e_commerce_app/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  // Clone a sign in state with params
  SignUpState cloneWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [email, password, confirmedPassword, status];
}
