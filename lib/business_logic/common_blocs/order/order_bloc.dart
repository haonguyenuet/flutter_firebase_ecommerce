import 'package:e_commerce_app/business_logic/common_blocs/order/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
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
    }
  }

  Stream<OrderState> _mapLoadMyOrdersToState(LoadMyOrders event) async* {
    try {
      var loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      List<Order> orders =
          await _orderRepository.getOrders(loggedFirebaseUser.uid);
      yield MyOrdersLoaded(myOrders: orders);
    } catch (e) {
      yield MyOrdersLoadFailure(e.toString());
    }
  }

  Stream<OrderState> _mapAddOrderToState(AddOrder event) async* {
    try {
      var newOrder =
          event.newOrder.cloneWith(uid: _authRepository.loggedFirebaseUser.uid);
      await _orderRepository.addOrder(newOrder);
    } catch (e) {
      print(e.toString());
    }
  }
}
