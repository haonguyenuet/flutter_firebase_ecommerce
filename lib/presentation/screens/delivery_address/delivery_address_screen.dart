import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/delivery_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delivery_address_bottom_sheet.dart';

class DeliveryAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Address")),
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
        onPressed: () => _openModalBottomSheet(context),
        label: Text('Add new address'),
        icon: Icon(Icons.add),
        backgroundColor: mPrimaryColor,
      ),
    );
  }

  _buildContent(List<DeliveryAddress> addressList) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        return DeliveryAddressCard(
          deliveryAddress: addressList[index],
          onPressed: () => _openModalBottomSheet(
            context,
            deliveryAddress: addressList[index],
          ),
        );
      },
    );
  }

  _buildNoAddress(BuildContext context) {
    return Center(
      child: Column(
        children: [Image.asset("assets/images/add_address.jpg")],
      ),
    );
  }

  _openModalBottomSheet(BuildContext context,
      {DeliveryAddress? deliveryAddress}) {
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
        return DeliveryAddressBottomSheet(deliveryAddress: deliveryAddress);
      },
    );
  }
}
