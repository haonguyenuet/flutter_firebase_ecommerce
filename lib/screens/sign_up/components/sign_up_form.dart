import 'package:e_commerce_app/common/validate_function.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // init states
  String email = "";
  String password = "";
  String confirmedPassword = "";
  String emailError;
  String passwordError;
  String confirmedPasswordError;
  bool isShowPassword = false;
  bool isShowConfirmedPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildEmailInput(),
        SizedBox(height: SizeConfig.screenHeight * 0.025),
        buildPasswordInput(),
        SizedBox(height: SizeConfig.screenHeight * 0.025),
        buildConfirmedPasswordInput(),
        SizedBox(height: SizeConfig.screenHeight * 0.025),
        buildSignUpButton(),
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

  TextField buildConfirmedPasswordInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          confirmedPassword = value;
          confirmedPasswordError = validateConfirmedPassword(password, value);
        });
      },
      obscureText: isShowConfirmedPassword ? false : true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your password",
        errorText: confirmedPasswordError,
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        suffixIcon: IconButton(
          icon: isShowConfirmedPassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              isShowConfirmedPassword = !isShowConfirmedPassword;
            });
          },
        ),
      ),
    );
  }

  Widget buildSignUpButton() {
    var authenticationStatus = context.watch<AuthenticationProvider>().status;
    return authenticationStatus == Status.Authenticating
        ? CircularProgressIndicator()
        : DefaultButton(
            text: "Sign Up",
            handleOnPress: () async {
              if (isValidated()) {
                var result = await context
                    .read<AuthenticationProvider>()
                    .signUp(email: email, password: password);
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

  /// Inputs is validated or not
  bool isValidated() {
    return emailError == null &&
        passwordError == null &&
        confirmedPasswordError == null &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmedPassword.isNotEmpty;
  }
}
