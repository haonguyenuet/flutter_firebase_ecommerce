import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login Success"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildSuccessImage(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildGreeting(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  _buildBackHomeButton(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSuccessImage() {
    return Image.asset(
      "assets/images/success.png",
      height: SizeConfig.screenHeight * 0.5,
    );
  }

  _buildBackHomeButton(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.6,
      child: DefaultButton(
        child: Text("Back to home", style: mPrimaryFontStyle),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.HOME,
            (_) => false,
          );
        },
      ),
    );
  }

  _buildGreeting() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          var loggedUser = state.loggedUser;
          return Text.rich(
            TextSpan(
              style: TextStyle(
                color: mSecondaryColor,
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: "Hello, "),
                TextSpan(
                  text: "${loggedUser.name}",
                  style: TextStyle(color: mPrimaryColor),
                )
              ],
            ),
          );
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }
}
