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
        SizedBox(height: SizeConfig.screenHeight * 0.01),
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
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
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
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
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
    var authenticationStatus = context.watch<AuthenticationProvider>().status;
    return authenticationStatus == Status.Authenticating
        ? CircularProgressIndicator()
        : DefaultButton(
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

  GestureDetector buildSignInWithGoogle() {
    return GestureDetector(
      onTap: () {
        context.read<AuthenticationProvider>().logInWithGoogle();
      },
      child: Container(
        height: getProportionateScreenHeight(56),
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12)),
        decoration: BoxDecoration(color: Color(0xffF5F6F9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/google-icon.svg"),
            SizedBox(width: 10),
            Text("Sign in with google account"),
          ],
        ),
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
