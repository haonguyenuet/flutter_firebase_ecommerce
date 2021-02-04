import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:e_commerce_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';

class CustomerBottomNav extends StatelessWidget {
  const CustomerBottomNav({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.15, 0.4),
            color: Colors.black,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color: selectedMenu == MenuState.home
                    ? mPrimaryColor
                    : mSecondaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: selectedMenu == MenuState.profile
                    ? mPrimaryColor
                    : mSecondaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Log out.svg",
                color: mSecondaryColor,
              ),
              onPressed: () {
                context.read<AuthenticationService>().logOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AuthenticaitonWrapper.routeName,
                  (_) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
