import 'package:e_commerce_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:e_commerce_app/blocs/sign_up/sign_up_event.dart';
import 'package:e_commerce_app/blocs/sign_up/sign_up_state.dart';
import 'package:e_commerce_app/components/custom_suffix_icon.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, signUpState) {
        if (signUpState.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Form(
        child: Column(
          children: [
            _EmailInput(),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            _PasswordInput(),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            _ConfirmedPassword(),
            SizedBox(height: SizeConfig.screenHeight * 0.025),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (preState, currState) => preState.email != currState.email,
      builder: (context, signUpState) {
        return TextFormField(
          onChanged: (value) {
            BlocProvider.of<SignUpBloc>(context).add(SignUpEmailChanged(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            hintText: "Enter your email",
            errorText: signUpState.email.invalid ? "Email Invalid" : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email_outlined),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  //init states
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (preState, currState) =>
          preState.password != currState.password,
      builder: (context, signUpState) {
        return TextFormField(
          obscureText: isShowPassword ? false : true,
          onChanged: (value) {
            BlocProvider.of<SignUpBloc>(context)
                .add(SignUpPasswordChanged(value));
          },
          decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              hintText: "Enter your password",
              errorText:
                  signUpState.password.invalid ? "Password Invalid" : null,
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
              )),
        );
      },
    );
  }
}

class _ConfirmedPassword extends StatefulWidget {
  @override
  __ConfirmedPasswordState createState() => __ConfirmedPasswordState();
}

class __ConfirmedPasswordState extends State<_ConfirmedPassword> {
  //init states
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (preState, currState) =>
          preState.password != currState.password ||
          preState.confirmedPassword != currState.confirmedPassword,
      builder: (context, signUpState) {
        return TextFormField(
          obscureText: isShowPassword ? false : true,
          onChanged: (value) {
            BlocProvider.of<SignUpBloc>(context)
                .add(SignUpConfirmedPasswordChanged(value));
          },
          decoration: InputDecoration(
            labelText: "Confirm Password",
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            hintText: "Enter your password again",
            errorText: signUpState.confirmedPassword.invalid
                ? "Password don't match"
                : null,
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, signUpState) {
        return signUpState.status.isSubmissionFailure
            ? const CircularProgressIndicator()
            : DefaultButton(
                text: "Sign Up",
                handleOnPress: signUpState.status.isValidated
                    ? () => BlocProvider.of<SignUpBloc>(context)
                        .add(SignUpWithCredentials())
                    : () {},
              );
      },
    );
  }
}
