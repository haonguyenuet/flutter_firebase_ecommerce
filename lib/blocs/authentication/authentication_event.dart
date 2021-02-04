import 'package:e_commerce_app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;

  AuthenticationUserChanged(this.user);

  List<Object> get props => [user];
}

class AuthenticationLoggedOutRequest extends AuthenticationEvent {}
