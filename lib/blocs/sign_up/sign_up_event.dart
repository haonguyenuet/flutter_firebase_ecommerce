import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  List<Object> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged(this.password);

  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class SignUpConfirmedPasswordChanged extends SignUpEvent {
  final String confirmedPassword;

  SignUpConfirmedPasswordChanged(this.confirmedPassword);

  @override
  // TODO: implement props
  List<Object> get props => [confirmedPassword];
}

class SignUpWithCredentials extends SignUpEvent {}
