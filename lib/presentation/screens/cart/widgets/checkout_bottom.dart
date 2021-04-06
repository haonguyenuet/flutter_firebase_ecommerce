import 'package:e_commerce_app/business_logic/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/cart/widgets/payment_bottom_sheet.dart';
import 'package:e_commerce_app/utils/dialog.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutBottom extends StatelessWidget {
  const CheckoutBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -0.5),
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (preState, currState) => currState is CartLoaded,
          builder: (context, state) {
            if (state is CartLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalPrice(context, state),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildCheckoutButton(context, state),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildCheckoutButton(BuildContext context, CartLoaded state) {
    return DefaultButton(
      child: Text(
        Translate.of(context).translate("check_out"),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (state.cart.length > 0) {
          _openPaymentBottomSheet(context);
        } else {
          UtilDialog.showInformation(
            context,
            content: Translate.of(context).translate("your_cart_is_empty"),
          );
        }
      },
    );
  }

  _buildTotalPrice(BuildContext context, CartLoaded state) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: SizeConfig.defaultSize * 4,
          width: SizeConfig.defaultSize * 4,
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(ICON_CONST.RECEIPT),
        ),
        SizedBox(width: SizeConfig.defaultSize * 1.5),
        Text.rich(
          TextSpan(
            style: FONT_CONST.BOLD_DEFAULT_18,
            children: [
              TextSpan(text: Translate.of(context).translate("total") + ":\n"),
              TextSpan(
                text: "${state.priceOfGoods.toPrice()}",
                style: FONT_CONST.BOLD_PRIMARY_20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _openPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) => PaymentBottomSheet(),
    );
  }
}
