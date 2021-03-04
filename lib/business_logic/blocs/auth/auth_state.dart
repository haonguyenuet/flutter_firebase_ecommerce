import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final User loggedFirebaseUser;

  const Authenticated(this.loggedFirebaseUser);

  @override
  List<Object?> get props => [loggedFirebaseUser];

  @override
  String toString() {
    return 'Authenticated{email: ${loggedFirebaseUser.email}}';
  }
}

class Unauthenticated extends AuthenticationState {}
