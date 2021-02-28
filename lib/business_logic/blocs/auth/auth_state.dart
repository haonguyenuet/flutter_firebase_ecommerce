import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserModel loggedUser;

  const Authenticated(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];

  @override
  String toString() {
    return 'Authenticated{email: ${loggedUser.email}}';
  }
}

class Unauthenticated extends AuthenticationState {}
