import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/widgets/default_button.dart';
import 'package:flutter/material.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    final LoginSuccessArgument arguments =
        ModalRoute.of(context).settings.arguments;
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
                  Image.asset(
                    "assets/images/success.png",
                    height: SizeConfig.screenHeight * 0.5,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),

                  /// Hello user
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: mSecondaryColor,
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: "Hello, "),
                        TextSpan(
                            text: "${arguments.currUser.name} !",
                            style: TextStyle(color: mPrimaryColor))
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),

                  /// Back to home button
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.6,
                    child: DefaultButton(
                      child: Text("Back to home"),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouter.LOGIN_SUCCESS,
                          (_) => false,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginSuccessArgument {
  final UserModel currUser;

  LoginSuccessArgument({@required this.currUser});
}
