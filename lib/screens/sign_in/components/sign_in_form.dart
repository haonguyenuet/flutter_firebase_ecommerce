import 'package:e_commerce_app/common/validate_function.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // init states
  String email = "";
  String password = "";
  String emailError;
  String passwordError;
  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildEmailInput(),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        buildPasswordInput(),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: Text(
              "Forgot password?",
              style: TextStyle(color: mSecondaryColor, fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        buildSignInButton(),
        SizedBox(height: SizeConfig.screenHeight * 0.015),
        buildSignInWithGoogle(),
      ],
    );
  }

  TextField buildEmailInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          email = value;
          emailError = validateEmail(value);
        });
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Email",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your email",
        errorText: emailError,
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        border: outlineInputBorder(),
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  TextField buildPasswordInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          password = value;
          passwordError = validatePassword(value);
        });
      },
      obscureText: isShowPassword ? false : true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your password",
        errorText: passwordError,
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        border: outlineInputBorder(),
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return DefaultButton(
      text: "Sign In",
      handleOnPress: () async {
        if (isValidated()) {
          var result = await context
              .read<AuthenticationProvider>()
              .logInWithEmailAndPassword(
                email: email,
                password: password,
              );
          if (result.isSuccess == false) {
            print("hello");
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('${result.message}')),
              );
          }
        }
      },
    );
  }

  Container buildSignInWithGoogle() {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 10,
            color: Color(0xff4285f4).withOpacity(0.32),
          ),
        ],
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Color(0xff4285f4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: getProportionateScreenHeight(36),
              height: getProportionateScreenHeight(36),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: SvgPicture.asset("assets/icons/google-icon.svg"),
            ),
            SizedBox(width: 10),
            Text(
              "Continue with google".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        onPressed: () =>
            context.read<AuthenticationProvider>().logInWithGoogle(),
      ),
    );
  }

  /// Inputs is validated or not
  bool isValidated() {
    return emailError == null &&
        passwordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty;
  }
}
