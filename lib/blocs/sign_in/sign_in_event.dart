import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  List<Object> get props => [];
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  SignInEmailChanged(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged(this.password);

  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class SignInWithCredentials extends SignInEvent {}

class SignInWithGoogle extends SignInEvent {}
