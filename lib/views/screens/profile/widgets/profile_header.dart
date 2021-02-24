import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _loggedUser = UserModel.empty;
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.3,
      decoration: BoxDecoration(
        gradient: mPrimaryGradientColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePic(loggedUser: _loggedUser),
          Text(
            "${_loggedUser.name}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
