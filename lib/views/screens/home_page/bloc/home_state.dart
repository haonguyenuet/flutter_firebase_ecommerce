import 'package:e_commerce_app/business_logic/repositories/home_repo.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

/// Loading
class HomeLoading extends HomeState {}

/// Adready data
class HomeLoaded extends HomeState {
  final HomeResponse homeResponse;

  const HomeLoaded({this.homeResponse});

  @override
  List<Object> get props => [homeResponse];

  @override
  String toString() {
    return 'HomeLoaded{response: $homeResponse}';
  }
}

/// Failure
class HomeNotLoaded extends HomeState {
  final String error;

  const HomeNotLoaded(this.error);

  @override
  String toString() {
    return 'HomeNotLoaded{e: $error}';
  }
}
