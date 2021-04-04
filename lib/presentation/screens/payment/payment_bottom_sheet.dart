import 'package:e_commerce_app/business_logic/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:square_in_app_payments/in_app_payments.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:square_in_app_payments/models.dart';

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final int deliveryFee = 30000;

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(
      'sandbox-sq0idb-otEYIcGuXP406Ql-_yHO7A',
    );
    await InAppPayments.startCardEntryFlow(
      onCardEntryCancel: _cardEntryCancel,
      onCardNonceRequestSuccess: _cardNonceRequestSuccess,
      collectPostalCode: false,
    );
  }

  void _cardEntryCancel() {}

  void _cardNonceRequestSuccess(CardDetails result) async {
    await InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete,
    );
  }

  void _cardEntryComplete() {
    Navigator.pushNamed(context, AppRouter.PAYMENT_SUCCESS);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildDeliveryAddress(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildTotalPrice(context),
            SizedBox(height: SizeConfig.defaultSize * 4),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        Translate.of(context).translate('payment'),
        style: FONT_CONST.BOLD_DEFAULT_20,
      ),
    );
  }

  _buildDeliveryAddress() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          var defaultAddress = state.loggedUser.defaultAddress;
          return defaultAddress != null
              ? DeliveryAddressCard(
                  deliveryAddress: defaultAddress,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.DELIVERY_ADDRESS,
                  ),
                )
              : Column(
                  children: [
                    Text(Translate.of(context).translate("no_address")),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouter.DELIVERY_ADDRESS);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: COLOR_CONST.primaryColor),
                      child: Text(
                        Translate.of(context).translate("add_new_address"),
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
        }
        if (state is ProfileLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }

  _buildTotalPrice(BuildContext context) {
    CartState state = BlocProvider.of<CartBloc>(context).state;
    if (state is CartLoaded) {
      String totalPriceOfGoods = formatNumber(state.totalCartPrice);
      String totalDeliveryFee = formatNumber(deliveryFee);
      String totalPrice = formatNumber(state.totalCartPrice + deliveryFee);

      return CustomListTile(
        title: "$totalPrice₫",
        leading: Text(
          Translate.of(context).translate("total"),
          style: FONT_CONST.BOLD_PRIMARY_18,
        ),
        subTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translate.of(context).translate("total_price") +
                  ": $totalPriceOfGoods₫",
              style: FONT_CONST.REGULAR_DEFAULT_18,
            ),
            Text(
              Translate.of(context).translate("total_delivery_fee") +
                  ": $totalDeliveryFee₫",
              style: FONT_CONST.REGULAR_DEFAULT_18,
            ),
          ],
        ),
      );
    }
  }

  _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: PaymentButton(
            onPressed: () {
              UtilDialog.showConfirmation(
                context,
                content: Text("Are you sure about that?"),
              );
            },
            text: "Ship COD",
            buttonColor: COLOR_CONST.primaryColor,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: PaymentButton(
            onPressed: _initSquarePayment,
            text: "Online",
            buttonColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

class PaymentButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? buttonColor;

  const PaymentButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 3),
          color: buttonColor,
        ),
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        child: Text(
          text,
          style: FONT_CONST.BOLD_WHITE_18,
        ),
      ),
    );
  }
}
