import 'package:e_commerce_app/business_logic/blocs/user/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrUserLoading extends UserState {}

class CurrUserLoaded extends UserState {
  final UserResponse userResponse;

  CurrUserLoaded(this.userResponse);

  @override
  String toString() {
    return "{CurrUserLoaded: userResponse:${this.userResponse}}";
  }
}

class CurrUserLoadFailure extends UserState {
  final String error;

  CurrUserLoadFailure(this.error);

  @override
  String toString() {
    return "{CurrUserLoadFailure: error:${this.error}}";
  }
}
