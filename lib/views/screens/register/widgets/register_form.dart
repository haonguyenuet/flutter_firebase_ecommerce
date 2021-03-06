import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/views/screens/register/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class RegisterForm extends StatefulWidget {
  final UserModel? intialUser;

  const RegisterForm({Key? key, this.intialUser}) : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late AuthenticationBloc _authenticationBloc;
  late RegisterBloc _registerBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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

        /// Registering
        if (state.isSubmitting) {
          MyDialog.showWating(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Register with email and password',
                      style: FONT_CONST.BOLD_PRIMARY_18,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildEmailInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildPasswordInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildConfirmPasswordInput(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildButtonRegister(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildHaveAccountText(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build content
  _buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        _registerBloc.add(EmailChanged(email: value));
      },
      validator: (_) {
        return !_registerBloc.state.isEmailValid ? 'Invalid Email' : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email',
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  _buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (value) {
        _registerBloc.add(PasswordChanged(password: value));
      },
      validator: (_) {
        return !_registerBloc.state.isPasswordValid ? 'Invalid Password' : null;
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

  _buildConfirmPasswordInput() {
    return TextFormField(
      controller: _confirmPasswordController,
      onChanged: (value) {
        _registerBloc.add(ConfirmPasswordChanged(
          password: _passwordController.text,
          confirmPassword: value,
        ));
      },
      validator: (_) {
        return !_registerBloc.state.isConfirmPasswordValid
            ? 'Don\'t match password'
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !_isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: 'Confirmed password',
        suffixIcon: IconButton(
          icon: _isShowConfirmPassword
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isShowConfirmPassword = !_isShowConfirmPassword;
            });
          },
        ),
      ),
    );
  }

  _buildButtonRegister() {
    return DefaultButton(
      child: Text(
        'Register'.toUpperCase(),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (isRegisterButtonEnabled()) {
          UserModel newUser = widget.intialUser!.cloneWith(
            email: _emailController.text,
          );
          _registerBloc.add(
            Submitted(
              newUser: newUser,
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            ),
          );
        }
      },
    );
  }

  _buildHaveAccountText() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Already have an account! '),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
              (_) => false,
            ),
            child: Text(
              'Sign in',
              style: FONT_CONST.REGULAR_PRIMARY,
            ),
          ),
        ],
      ),
    );
  }

  bool isRegisterButtonEnabled() {
    return _registerBloc.state.isFormValid &&
        !_registerBloc.state.isSubmitting &&
        isPopulated;
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;
}
