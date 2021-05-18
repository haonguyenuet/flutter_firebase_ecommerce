import 'package:e_commerce_app/presentation/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/delivery_address_card.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delivery_address_bottom_sheet.dart';

class DeliveryAddressModelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate("delivery_address")),
      ),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Loading();
            }
            if (state is ProfileLoaded) {
              var addressList = state.loggedUser.addresses;
              return addressList.isNotEmpty
                  ? _buildContent(addressList)
                  : _buildNoAddress(context);
            }
            if (state is ProfileLoadFailure) {
              return Center(child: Text("Load Failure"));
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openDeliveryBottomSheet(context),
        label: Text(
          Translate.of(context).translate("add_new_address"),
          style: FONT_CONST.BOLD_WHITE_16,
        ),
        icon: Icon(Icons.add),
        backgroundColor: COLOR_CONST.primaryColor,
      ),
    );
  }

  _buildContent(List<DeliveryAddressModel> addressList) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        return DeliveryAddressCard(
          deliveryAddress: addressList[index],
          onPressed: () => _openDeliveryBottomSheet(
            context,
            deliveryAddress: addressList[index],
          ),
        );
      },
    );
  }

  _buildNoAddress(BuildContext context) {
    return Center(
      child: Image.asset(IMAGE_CONST.ADD_ADDRESS),
    );
  }

  _openDeliveryBottomSheet(BuildContext context,
      {DeliveryAddressModel? deliveryAddress}) {
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
      builder: (BuildContext context) {
        return DeliveryAddressModelBottomSheet(
            deliveryAddress: deliveryAddress);
      },
    );
  }
}
