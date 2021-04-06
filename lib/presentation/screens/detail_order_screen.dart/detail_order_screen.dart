import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/payment_fees_widget.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class DetailOrderScreen extends StatelessWidget {
  final Order order;

  const DetailOrderScreen({Key? key, required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: Text(Translate.of(context).translate("detail_order"))),
      body: SafeArea(
        child: ListView(
          children: [
            _buildListOrderItems(),
            PaymentFeesWidget(
              priceOfGoods: order.priceOfGoods,
              deliveryFee: order.deliveryFee,
              coupon: order.coupon,
              priceToBePaid: order.priceToBePaid,
            ),
            DeliveryAddressCard(
              deliveryAddress: order.deliveryAddress,
              showDefautTick: false,
            ),
            CustomCardWidget(
              child: TextRow(
                title: Translate.of(context).translate("payment_method"),
                content: order.paymentMethod,
                isSpaceBetween: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListOrderItems() {
    return CustomCardWidget(
      child: Column(
        children: List.generate(order.items.length, (index) {
          return CustomListTile(
            leading: ShimmerImage(imageUrl: order.items[index].productImage),
            subTitle: Text(
              "x ${order.items[index].quantity}",
              style: FONT_CONST.REGULAR_DEFAULT_16,
            ),
            title: order.items[index].productName,
            trailing: Text(
              "${order.items[index].productPrice.toPrice()}",
              style: FONT_CONST.REGULAR_DEFAULT_18,
            ),
            bottomBorder: false,
          );
        }),
      ),
    );
  }
}
