import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/presentation/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/presentation/common_blocs/order/bloc.dart';
import 'package:e_commerce_app/presentation/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/payment_fees_widget.dart';
import 'package:e_commerce_app/utils/toast.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:square_in_app_payments/in_app_payments.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:square_in_app_payments/models.dart';
import 'package:uuid/uuid.dart';

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  List<OrderModelItem> listOrderModelItem = [];
  int priceOfGoods = 0;
  int deliveryFee = 0;
  int coupon = 0;
  int priceToBePaid = 0;

  @override
  void initState() {
    CartState cartState = BlocProvider.of<CartBloc>(context).state;
    if (cartState is CartLoaded) {
      listOrderModelItem = cartState.cart
          .map((c) => OrderModelItem.fromCartItemModel(c))
          .toList();
      priceOfGoods = cartState.priceOfGoods;
      deliveryFee = 30000;

      if (priceOfGoods >= 12000000) {
        coupon = 1000000;
      } else if (priceOfGoods >= 5000000) {
        coupon = 500000;
      } else if (priceOfGoods >= 2000000) {
        coupon = 200000;
      }

      priceToBePaid = priceOfGoods + deliveryFee - coupon;
    }

    super.initState();
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(
      'sandbox-sq0idb-otEYIcGuXP406Ql-_yHO7A',
    );
    await InAppPayments.startCardEntryFlow(
      onCardEntryCancel: () {},
      onCardNonceRequestSuccess: (CardDetails result) async {
        await InAppPayments.completeCardEntry(
          onCardEntryComplete: () {
            _addNewOrder(paymentMethod: "Credit card");
          },
        );
      },
      collectPostalCode: false,
    );
  }

  void _addNewOrder({required String paymentMethod}) {
    ProfileState profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoaded) {
      // create new order
      var newOrderModel = OrderModel(
        id: Uuid().v1(),
        uid: profileState.loggedUser.id,
        items: listOrderModelItem,
        createdAt: Timestamp.now(),
        deliveryAddress: profileState.loggedUser.defaultAddress!,
        paymentMethod: paymentMethod,
        priceToBePaid: priceToBePaid,
        priceOfGoods: priceOfGoods,
        deliveryFee: deliveryFee,
        coupon: coupon,
      );
      // Add event add order
      BlocProvider.of<OrderBloc>(context).add(AddOrder(newOrderModel));
      // Clear cart
      BlocProvider.of<CartBloc>(context).add(ClearCart());
      // Show toast: OrderModel successfully
      UtilToast.showMessageForUser(
        context,
        Translate.of(context).translate("order_successfully"),
      );
      // Go to detail order screen
      Navigator.popAndPushNamed(
        context,
        AppRouter.DETAIL_ORDER,
        arguments: newOrderModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildDeliveryAddressModel(),
            PaymentFeesWidget(
              priceOfGoods: priceOfGoods,
              deliveryFee: deliveryFee,
              coupon: coupon,
              priceToBePaid: priceToBePaid,
            ),
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

  _buildDeliveryAddressModel() {
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

  _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: _buildPaymentButton(
              onPressed: () => _addNewOrder(paymentMethod: "Cash"),
              text: "CASH",
              buttonColor: COLOR_CONST.primaryColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: _buildPaymentButton(
              onPressed: _initSquarePayment,
              text: "VISA/MASTER",
              buttonColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _buildPaymentButton({
    required Function() onPressed,
    required String text,
    Color buttonColor = COLOR_CONST.primaryColor,
  }) {
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
