import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:e_commerce_app/screens/profile/components/profile_menu_button.dart';
import 'package:e_commerce_app/screens/profile/components/profile_pict.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenuButton(
            text: "My Information",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenuButton(
            text: "My Cart",
            icon: "assets/icons/Cart Icon.svg",
            press: () {},
          ),
          ProfileMenuButton(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              context.read<AuthenticationProvider>().logOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthenticationWrapper.routeName,
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
