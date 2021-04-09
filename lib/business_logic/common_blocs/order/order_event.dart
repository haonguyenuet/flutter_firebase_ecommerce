import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrders extends OrderEvent {}

class AddOrder extends OrderEvent {
  final Order newOrder;

  AddOrder(this.newOrder);

  List<Object> get props => [newOrder];
}

class RemoveOrder extends OrderEvent {
  final Order order;

  RemoveOrder(this.order);

  List<Object> get props => [order];
}
