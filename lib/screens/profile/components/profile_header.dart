import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import 'profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _loggedUser = context.watch<AuthenticationProvider>().loggedUser;
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
