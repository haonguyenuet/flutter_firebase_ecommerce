import 'package:e_commerce_app/data/entities/delivery_address.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatelessWidget {
  final DeliveryAddress deliveryAddress;
  final Function()? onPressed;
  final bool showDefautTick;

  const DeliveryAddressCard({
    Key? key,
    required this.deliveryAddress,
    this.onPressed,
    this.showDefautTick = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translate.of(context).translate("delivery_address"),
                  style: FONT_CONST.BOLD_PRIMARY_18,
                ),
                TextRow(
                  title: Translate.of(context).translate("name"),
                  content: deliveryAddress.receiverName,
                ),
                TextRow(
                  title: Translate.of(context).translate("phone_number"),
                  content: deliveryAddress.phoneNumber,
                ),
                TextRow(
                  title: Translate.of(context).translate("detail_address"),
                  content: deliveryAddress.detailAddress,
                ),
              ],
            ),
          ),
          _buildDefaultText(context),
        ],
      ),
    );
  }

  _buildDefaultText(BuildContext context) {
    return deliveryAddress.isDefault && showDefautTick
        ? Text(
            "[" + Translate.of(context).translate("default") + "]",
            style: FONT_CONST.REGULAR_PRIMARY,
          )
        : Container();
  }
}
