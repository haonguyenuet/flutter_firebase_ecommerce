import 'package:e_commerce_app/views/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_event.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_bloc.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_event.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_state.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  AuthenticationBloc _authenticationBloc;
  RegisterBloc _registerBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
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
          _authenticationBloc.add(LoggedIn());
        }

        /// Failure
        if (state.isFailure) {
          _showFailureDialog(state.message);
        }

        /// Logging
        if (state.isSubmitting) {
          _showRegistering(state.message);
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
                      'Register with your information',
                      style: TextStyle(
                        color: mPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _buildEmailInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildPasswordInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildConfirmPasswordInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildNameInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildAddressInput(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  _buildPhoneNumberInput(),
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

  /// Build content
  _buildNameInput() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Name',
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  /// Build content
  _buildAddressInput() {
    return TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Address',
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }

  /// Build content
  _buildPhoneNumberInput() {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: 'Phone number',
        suffixIcon: Icon(Icons.phone_callback),
      ),
    );
  }

  _buildButtonRegister() {
    return DefaultButton(
      child: Text(
        'Register'.toUpperCase(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: () {
        if (isRegisterButtonEnabled()) {
          UserModel newUser = UserModel(
            email: _emailController.text,
            name: _nameController.text,
            address: _addressController.text,
            phoneNumber: _phoneNumberController.text,
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
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRouter.LOGIN),
            child: Text(
              'Sign in',
              style: TextStyle(color: mPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog(String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Login Failure",
          style: TextStyle(color: mPrimaryColor),
        ),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _showRegistering(String content) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(content),
              CircularProgressIndicator(),
            ],
          ),
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
      _confirmPasswordController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _addressController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;
}
