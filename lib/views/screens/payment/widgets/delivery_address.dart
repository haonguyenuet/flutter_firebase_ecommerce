import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black12, width: 1),
            bottom: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              var user = state.loggedUser;
              return user.address!.length > 1
                  ? _buildInfo(user)
                  : _buildWarning(context);
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildInfo(UserModel user) {
    return Column(
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          "${user.name} | ${user.phoneNumber}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(user.address![0]),
      ],
    );
  }

  _buildWarning(BuildContext context) {
    return Column(
      children: [
        Text("You have no address, need at least a address to payment"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.ADD_DELIVERY_ADDRESS);
          },
          style: TextButton.styleFrom(backgroundColor: mPrimaryColor),
          child: Text("Add new address", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
