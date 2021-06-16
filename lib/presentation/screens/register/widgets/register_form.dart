import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/presentation/screens/register/register/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/presentation/common_blocs/auth/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
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
  late RegisterBloc registerBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  bool isRegisterButtonEnabled() {
    return registerBloc.state.isFormValid &&
        !registerBloc.state.isSubmitting &&
        isPopulated;
  }

  void onRegister() {
    if (isRegisterButtonEnabled()) {
      UserModel newUser = widget.intialUser!.cloneWith(
        email: emailController.text,
      );
      registerBloc.add(
        Submitted(
          newUser: newUser,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        ),
      );
    }
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
          return Container(
            margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding,
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
      controller: emailController,
      onChanged: (value) {
        registerBloc.add(EmailChanged(email: value));
      },
      validator: (_) {
        return !registerBloc.state.isEmailValid
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
      controller: passwordController,
      onChanged: (value) {
        registerBloc.add(PasswordChanged(password: value));
      },
      validator: (_) {
        return !registerBloc.state.isPasswordValid
            ? Translate.of(context).translate('invalid_password')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !isShowPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('password'),
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          onPressed: () {
            setState(() {
              isShowPassword = !isShowPassword;
            });
          },
        ),
      ),
    );
  }

  _buildConfirmPasswordInput() {
    return TextFormField(
      controller: confirmPasswordController,
      onChanged: (value) {
        registerBloc.add(ConfirmPasswordChanged(
          password: passwordController.text,
          confirmPassword: value,
        ));
      },
      validator: (_) {
        return !registerBloc.state.isConfirmPasswordValid
            ? Translate.of(context).translate('don\'t_match_password')
            : null;
      },
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('confirm_password'),
        suffixIcon: IconButton(
          icon: isShowConfirmPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          onPressed: () {
            setState(() {
              isShowConfirmPassword = !isShowConfirmPassword;
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
      onPressed: onRegister,
      backgroundColor: isRegisterButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }
}
