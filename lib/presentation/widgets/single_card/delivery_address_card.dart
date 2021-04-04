import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';

class DeliveryAddressCard extends StatelessWidget {
  final DeliveryAddress deliveryAddress;
  final Function()? onPressed;

  const DeliveryAddressCard({
    Key? key,
    required this.deliveryAddress,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onPressed: onPressed,
      title: "${deliveryAddress.receiverName} | ${deliveryAddress.phoneNumber}",
      subTitle: Text(
        deliveryAddress.detailAddress,
        style: FONT_CONST.REGULAR_DEFAULT_18,
      ),
      leading: Text(
        "Ship to",
        style: FONT_CONST.BOLD_PRIMARY_18,
      ),
      trailing: _buildDefaultText(context),
    );
  }

  _buildDefaultText(BuildContext context) {
    return deliveryAddress.isDefault
        ? Text(
            "[" + Translate.of(context).translate("default") + "]",
            style: FONT_CONST.REGULAR_PRIMARY,
          )
        : Container();
  }
}
