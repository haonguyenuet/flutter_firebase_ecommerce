import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_dialog.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/presentation/screens/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/facebook_login_btn.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/google_login_btn.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late AuthenticationBloc _authenticationBloc;
  late LoginBloc _loginBloc;

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
          Navigator.pop(context);
          _authenticationBloc.add(LoggedIn());
        }

        /// Failure
        if (state.isFailure) {
          Navigator.pop(context);
          MyDialog.showInformation(context, content: state.message);
        }

        /// Logging
        if (state.isSubmitting) {
          MyDialog.showWating(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 1.5,
              vertical: SizeConfig.defaultSize * 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login to your account',
                      style: FONT_CONST.BOLD_PRIMARY_18,
                    ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildTextFieldUsername(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildTextFieldPassword(),
                  SizedBox(height: SizeConfig.defaultSize),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot password ?'),
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildButtonLogin(state),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildTextOr(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildSocialLogin(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
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
      child: Text(
        'Login'.toUpperCase(),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
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
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize,
                vertical: 0,
              ),
              child: Text('Or'),
            ),
          ),
        )
      ],
    );
  }

  _buildSocialLogin() {
    return Container(
      height: SizeConfig.defaultSize * 6,
      child: Row(
        children: <Widget>[
          GoogleLoginButton(),
          SizedBox(width: SizeConfig.defaultSize * 2),
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
              style: FONT_CONST.REGULAR_PRIMARY,
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
