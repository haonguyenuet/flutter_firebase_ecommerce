import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_dialog.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/views/screens/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

import 'package:e_commerce_app/views/screens/login/widgets/facebook_login_btn.dart';
import 'package:e_commerce_app/views/screens/login/widgets/google_login_btn.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isShowPassword = false;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          _authenticationBloc.add(LoggedIn());
        }

        /// Failure
        if (state.isFailure) {
          MyDialog.showInformation(context, content: state.message);
        }

        /// Logging
        if (state.isSubmitting) {
          showProcessing(context, state.message);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login to your account',
                      style: TextStyle(
                        color: mPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildTextFieldUsername(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildTextFieldPassword(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot password ?'),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildButtonLogin(state),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildTextOr(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildSocialLogin(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildNoAccountText(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build content
  _buildTextFieldUsername() {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        _loginBloc.add(EmailChanged(email: value));
      },
      validator: (_) {
        return !_loginBloc.state.isEmailValid ? 'Invalid Email' : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  _buildTextFieldPassword() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (value) {
        _loginBloc.add(PasswordChanged(password: value));
      },
      validator: (_) {
        return !_loginBloc.state.isPasswordValid ? 'Invalid Password' : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !_isShowPassword,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: _isShowPassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isShowPassword = !_isShowPassword;
            });
          },
        ),
      ),
    );
  }

  _buildButtonLogin(LoginState state) {
    return DefaultButton(
      child: Text('Login'.toUpperCase(), style: mPrimaryFontStyle),
      onPressed: () {
        if (isLoginButtonEnabled()) {
          _loginBloc.add(LoginWithCredential(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        }
      },
    );
  }

  _buildTextOr() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Divider(color: Colors.black26),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Text('Or'),
            ),
          ),
        )
      ],
    );
  }

  _buildSocialLogin() {
    return Container(
      height: 60,
      child: Row(
        children: <Widget>[
          GoogleLoginButton(),
          SizedBox(width: 20),
          FacebookLoginButton(),
        ],
      ),
    );
  }

  _buildNoAccountText() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Don\'t have an account ?'),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.INITIALIZE_INFO,
            ),
            child: Text(
              'Register',
              style: TextStyle(color: mPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  bool isLoginButtonEnabled() {
    return _loginBloc.state.isFormValid &&
        !_loginBloc.state.isSubmitting &&
        isPopulated;
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
}
