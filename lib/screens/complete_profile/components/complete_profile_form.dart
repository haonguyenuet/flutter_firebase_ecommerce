import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class CompleteProfileForm extends StatefulWidget {
  final UserModel loggedUser;

  const CompleteProfileForm({Key key, this.loggedUser}) : super(key: key);
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  UserModel get loggedUser => widget.loggedUser;
  // init states
  String _name = "";
  String _phoneNumber = "";
  String _address = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          buildPhoneNumberInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          buildAddressInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.025),
          buildSaveInfoButton(),
        ],
      ),
    );
  }

  TextField buildNameInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Your name",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your name",
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        suffixIcon: Icon(Icons.verified_user),
      ),
    );
  }

  TextField buildPhoneNumberInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _phoneNumber = value;
        });
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Phone number",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your phone number",
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextField buildAddressInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _address = value;
        });
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Address",
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        hintText: "Enter your address",
        contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }

  DefaultButton buildSaveInfoButton() {
    return DefaultButton(
      text: "Save",
      handleOnPress: () {
        if (_name.isNotEmpty &&
            _address.isNotEmpty &&
            _phoneNumber.isNotEmpty) {
          /// Clone a user model with new data
          UserModel updatedUser = loggedUser.cloneWith(
            name: _name,
            address: _address,
            phoneNumber: _phoneNumber,
          );
          context.read<AuthenticationProvider>().updateLoggedUser(updatedUser);
          Navigator.pushNamed(context, AuthenticationWrapper.routeName);
        }
      },
    );
  }
}
