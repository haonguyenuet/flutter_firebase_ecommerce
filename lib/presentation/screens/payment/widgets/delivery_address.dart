import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/delivery_address_card.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          var defaultAddress = state.loggedUser.defaultAddress;
          return defaultAddress == null
              ? _buildWarning(context)
              : DeliveryAddressCard(
                  deliveryAddress: defaultAddress,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.DELIVERY_ADDRESS,
                  ),
                );
        }
        if (state is ProfileLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }

  _buildWarning(BuildContext context) {
    return Column(
      children: [
        Text(Translate.of(context).translate("no_address")),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.DELIVERY_ADDRESS);
          },
          style:
              TextButton.styleFrom(backgroundColor: COLOR_CONST.primaryColor),
          child: Text(
            Translate.of(context).translate("add_new_address"),
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
