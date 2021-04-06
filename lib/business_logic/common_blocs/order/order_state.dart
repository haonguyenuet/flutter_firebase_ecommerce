import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

/// MyOrders loading
class MyOrdersLoading extends OrderState {}

/// MyOrders was loaded
class MyOrdersLoaded extends OrderState {
  final List<Order> myOrders;

  MyOrdersLoaded({required this.myOrders});

  @override
  List<Object> get props => [myOrders];
}

/// MyOrders wasn't loaded
class MyOrdersLoadFailure extends OrderState {
  final String error;

  MyOrdersLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
