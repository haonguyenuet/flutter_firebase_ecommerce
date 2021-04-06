import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class PaymentFeesWidget extends StatelessWidget {
  final int priceOfGoods;
  final int deliveryFee;
  final int coupon;
  final int priceToBePaid;

  const PaymentFeesWidget({
    Key? key,
    required this.priceOfGoods,
    required this.deliveryFee,
    required this.coupon,
    required this.priceToBePaid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextRow(
            title: Translate.of(context).translate("total"),
            content: priceToBePaid.toPrice(),
            isSpaceBetween: true,
          ),
          TextRow(
            title: Translate.of(context).translate("price_of_goods"),
            content: priceOfGoods.toPrice(),
          ),
          TextRow(
            title: Translate.of(context).translate("delivery_fee"),
            content: deliveryFee.toPrice(),
          ),
          TextRow(
            title: Translate.of(context).translate("coupon"),
            content: coupon.toPrice(),
          ),
        ],
      ),
    );
  }
}
