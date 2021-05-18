import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class OrderModelCard extends StatelessWidget {
  final OrderModel order;

  const OrderModelCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.DETAIL_ORDER,
          arguments: order,
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Delivery status
                Text.rich(
                  TextSpan(
                    style: FONT_CONST.REGULAR_DEFAULT_16,
                    children: [
                      TextSpan(
                        text: order.isDelivering
                            ? Translate.of(context).translate("be_delivering")
                            : Translate.of(context).translate("delivered"),
                        style: FONT_CONST.BOLD_PRIMARY_16,
                      ),
                      if (!order.isDelivering)
                        TextSpan(
                          text:
                              " (${UtilFormatter.formatTimeStamp(order.receivedDate)})",
                        ),
                    ],
                  ),
                ),

                // Price to be paid and payment method
                TextRow(
                    title: Translate.of(context).translate("total"),
                    content:
                        "${order.priceToBePaid.toPrice()} (${order.paymentMethod})"),

                // Number of items
                TextRow(
                  title: Translate.of(context).translate("quantity"),
                  content:
                      "${order.items.length} ${Translate.of(context).translate("item")}",
                ),

                // Created at
                TextRow(
                  title: Translate.of(context).translate("created_at"),
                  content: UtilFormatter.formatTimeStamp(order.createdAt),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
