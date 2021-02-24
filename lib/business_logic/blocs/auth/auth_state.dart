import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserModel userModel;

  const Authenticated(this.userModel);

  @override
  List<Object> get props => [userModel];

  @override
  String toString() {
    return 'Authenticated{email: ${userModel.email}}';
  }
}

class Unauthenticated extends AuthenticationState {}
