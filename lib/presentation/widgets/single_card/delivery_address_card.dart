import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
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
    return CustomCardWidget(
      onTap: onPressed,
      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
      margin: EdgeInsets.only(
        bottom: SizeConfig.defaultSize * 1.5,
        left: SizeConfig.defaultSize,
        right: SizeConfig.defaultSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_city_rounded,
                size: SizeConfig.defaultSize * 2,
                color: COLOR_CONST.primaryColor,
              ),
              SizedBox(width: SizeConfig.defaultSize),
              Text(
                Translate.of(context).translate("delivery_address"),
                style: FONT_CONST.MEDIUM_DEFAULT_16,
              ),
              Spacer(),
              _defaultText(context),
            ],
          ),
          Text(
            "${deliveryAddress.receiverName} | ${deliveryAddress.phoneNumber}",
            style: FONT_CONST.REGULAR_DEFAULT_16,
          ),
          Text(
            deliveryAddress.detailAddress,
            style: FONT_CONST.REGULAR_DEFAULT_16,
          ),
        ],
      ),
    );
  }

  _defaultText(BuildContext context) {
    return deliveryAddress.isDefault
        ? Text(
            "[" + Translate.of(context).translate("default") + "]",
            style: FONT_CONST.REGULAR_PRIMARY,
          )
        : Container();
  }
}
