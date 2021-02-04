import 'package:e_commerce_app/models/email.dart';
import 'package:e_commerce_app/models/password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class SignInState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  // Clone a sign in state with params
  SignInState cloneWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [email, password, status];
}
