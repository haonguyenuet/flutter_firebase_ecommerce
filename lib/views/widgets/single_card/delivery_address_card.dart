import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/constants/constants.dart';
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
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
            bottom: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_city_rounded,
                  size: 20,
                  color: mPrimaryColor,
                ),
                SizedBox(width: 10),
                Text(
                  "Delivery Address",
                  style: FONT_CONST.MEDIUM_DEFAULT_16,
                ),
                Spacer(),
                if (deliveryAddress.isDefault)
                  Text("[Default]", style: FONT_CONST.REGULAR_PRIMARY),
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
      ),
    );
  }
}
