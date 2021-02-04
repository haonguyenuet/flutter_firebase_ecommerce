import 'package:e_commerce_app/blocs/sign_in/sign_in_bloc.dart';
import 'package:e_commerce_app/blocs/sign_in/sign_in_event.dart';
import 'package:e_commerce_app/blocs/sign_in/sign_in_state.dart';
import 'package:e_commerce_app/components/custom_suffix_icon.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // init states
  bool _isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, signInState) {
        if (signInState.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Column(
        children: [
          _EmailInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          _PasswordInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Row(
            children: [
              Checkbox(
                value: _isRememberMe,
                onChanged: (value) {
                  setState(() {
                    _isRememberMe = value;
                  });
                },
              ),
              Text(
                "Remember me",
                style: TextStyle(color: mSecondaryColor),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                },
                child: Text(
                  "Forgot password",
                  style: TextStyle(
                    color: mSecondaryColor,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          _SignInButton(),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          _SignInWithGoogle(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (preState, currState) => preState.email != currState.email,
        builder: (context, signInState) {
          return TextField(
            onChanged: (email) => BlocProvider.of<SignInBloc>(context)
                .add(SignInEmailChanged(email)),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              hintText: "Enter your email",
              errorText: signInState.email.invalid ? "Invalid email" : null,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.email_outlined),
            ),
          );
        });
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  // init states
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (preState, currState) =>
          preState.password != currState.password,
      builder: (context, signInState) {
        return TextField(
          onChanged: (password) => BlocProvider.of<SignInBloc>(context)
              .add(SignInPasswordChanged(password)),
          obscureText: isShowPassword ? false : true,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            hintText: "Enter your password",
            errorText: signInState.password.invalid ? "Invalid password" : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
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
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (preState, currState) => preState.status != currState.status,
      builder: (context, signInState) {
        return signInState.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : DefaultButton(
                text: "Sign In",
                handleOnPress: signInState.status.isValidated
                    ? () => BlocProvider.of<SignInBloc>(context)
                        .add(SignInWithCredentials())
                    : () {},
              );
      },
    );
  }
}

class _SignInWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SignInBloc>(context).add(SignInWithGoogle());
      },
      child: Container(
        height: getProportionateScreenHeight(56),
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12)),
        decoration: BoxDecoration(
          color: Color(0xffF5F6F9),
        ),
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
}
