import 'package:e_commerce_app/views/screens/payment/widgets/delivery_address.dart';
import 'package:e_commerce_app/views/screens/payment/widgets/delivery_unit.dart';
import 'package:e_commerce_app/views/screens/payment/widgets/list_items.dart';
import 'package:e_commerce_app/views/screens/payment/widgets/order_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: SafeArea(
        child: Column(
          children: [
            DeliveryAddressWidget(),
            DeliveryUnit(),
            Expanded(child: ListItems()),
          ],
        ),
      ),
      bottomNavigationBar: OrderBottomNavBar(),
    );
  }
}
