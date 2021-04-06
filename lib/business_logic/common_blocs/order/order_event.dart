import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrders extends OrderEvent {
  final User loggedFirebaseUser;

  LoadMyOrders(this.loggedFirebaseUser);

  List<Object> get props => [loggedFirebaseUser];
}

class AddOrder extends OrderEvent {
  final Order newOrder;

  AddOrder(this.newOrder);

  List<Object> get props => [newOrder];
}
