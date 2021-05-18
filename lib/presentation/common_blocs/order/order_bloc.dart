import 'package:e_commerce_app/presentation/common_blocs/order/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository _orderRepository = AppRepository.orderRepository;
  AuthRepository _authRepository = AppRepository.authRepository;
  OrderBloc() : super(MyOrdersLoading());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is LoadMyOrders) {
      yield* _mapLoadMyOrdersToState(event);
    } else if (event is AddOrder) {
      yield* _mapAddOrderToState(event);
    } else if (event is RemoveOrder) {
      yield* _mapRemoveOrderToState(event);
    }
  }

  Stream<OrderState> _mapLoadMyOrdersToState(
      LoadMyOrders event) async* {
    try {
      var loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      List<OrderModel> orders =
          await _orderRepository.fetchOrders(loggedFirebaseUser.uid);

      // Classify orders
      List<OrderModel> deliveringOrders = [];
      List<OrderModel> deliveredOrders = [];

      orders.forEach((order) {
        if (order.isDelivering) {
          deliveringOrders.add(order);
        } else {
          deliveredOrders.add(order);
        }
      });
      yield MyOrdersLoaded(
        deliveringOrders: deliveringOrders,
        deliveredOrders: deliveredOrders,
      );
    } catch (e) {
      yield MyOrdersLoadFailure(e.toString());
    }
  }

  Stream<OrderState> _mapAddOrderToState(AddOrder event) async* {
    try {
      var newOrderModel = event.newOrderModel
          .cloneWith(uid: _authRepository.loggedFirebaseUser.uid);
      await _orderRepository.addOrderModel(newOrderModel);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<OrderState> _mapRemoveOrderToState(
      RemoveOrder event) async* {
    try {
      await _orderRepository.removeOrderModel(event.order);
      add(LoadMyOrders());
    } catch (e) {
      print(e.toString());
    }
  }
}
