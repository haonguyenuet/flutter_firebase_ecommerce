import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/presentation/screens/register/register/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/common_blocs/auth/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';

class RegisterForm extends StatefulWidget {
  final UserModel? intialUser;

  const RegisterForm({Key? key, this.intialUser}) : super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late RegisterBloc _registerBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          UtilDialog.hideWaiting(context);
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }

        /// Failure
        if (state.isFailure) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: state.message);
        }

        /// Registering
        if (state.isSubmitting) {
          UtilDialog.showWaiting(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return CustomCardWidget(
            margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 1.5,
              vertical: SizeConfig.defaultSize * 3,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  _buildEmailInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildPasswordInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildConfirmPasswordInput(),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildButtonRegister(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
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
        return !_registerBloc.state.isEmailValid
            ? Translate.of(context).translate('invalid_email')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('email'),
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
        return !_registerBloc.state.isPasswordValid
            ? Translate.of(context).translate('invalid_password')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !_isShowPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('password'),
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
            ? Translate.of(context).translate('don\'t_match_password')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !_isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('confirm_password'),
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
        Translate.of(context).translate('register').toUpperCase(),
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
          Text(Translate.of(context).translate('already_have_an_account')),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
              (_) => false,
            ),
            child: Text(
              Translate.of(context).translate('login'),
              style: FONT_CONST.BOLD_PRIMARY_16,
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
