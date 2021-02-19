import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  // init states
  final _formKey = GlobalKey<FormState>();
  List<String> _errors = [];
  String _email = "";

  void addError({String error}) {
    if (!_errors.contains(error)) {
      setState(() {
        _errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (_errors.contains(error)) {
      setState(() {
        _errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          DefaultButton(
            text: "Continue",
            handleOnPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // return sign in screen
                Navigator.pushNamed(context, SplashScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) {
        setState(() {
          _email = newValue;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: mEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: mInvalidEmailError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: mEmailNullError);
          return "";
        } else if (value.isNotEmpty && !emailValidatorRegExp.hasMatch(value)) {
          addError(error: mInvalidEmailError);
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Email",
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        hintText: "Enter your email",
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        suffixIcon: Icon(Icons.email),
      ),
    );
  }
}
