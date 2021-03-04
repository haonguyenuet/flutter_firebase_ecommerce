import 'package:e_commerce_app/views/screens/home_page/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Loading
class HomeLoading extends HomeState {}

/// Adready data
class HomeLoaded extends HomeState {
  final HomeResponse homeResponse;

  const HomeLoaded({required this.homeResponse});

  @override
  List<Object?> get props => [homeResponse];

  @override
  String toString() {
    return 'HomeLoaded{response: $homeResponse}';
  }
}

/// Failure
class HomeLoadFailure extends HomeState {
  final String error;

  const HomeLoadFailure(this.error);

  @override
  String toString() {
    return 'HomeLoadFailure{e: $error}';
  }
}
