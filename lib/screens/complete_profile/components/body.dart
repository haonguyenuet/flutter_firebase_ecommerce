import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _loggedUser = context.watch<AuthenticationProvider>().loggedUser;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Complete Profile", style: headingStyle()),
                Text("Hi, ${_loggedUser.email}", textAlign: TextAlign.center),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(loggedUser: _loggedUser),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "You need complete the information to continue",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
