import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/utils/common_func.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class InitializeInfoForm extends StatefulWidget {
  @override
  _InitializeInfoFormState createState() => _InitializeInfoFormState();
}

class _InitializeInfoFormState extends State<InitializeInfoForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                'Complete with your information',
                style: TextStyle(
                  color: mPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildNameInput(),
            SizedBox(height: getProportionateScreenHeight(10)),
            _buildAddressInput(),
            SizedBox(height: getProportionateScreenHeight(10)),
            _buildPhoneNumberInput(),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildButtonContinue(),
          ],
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

  _buildButtonContinue() {
    return DefaultButton(
      child: Text(
        'Continue'.toUpperCase(),
        style: mPrimaryFontStyle,
      ),
      onPressed: () {
        if (isContinueButtonEnabled()) {
          UserModel initialUser = UserModel(
            email: "",
            name: _nameController.text,
            address: _addressController.text,
            phoneNumber: _phoneNumberController.text,
          );
          Navigator.pushNamed(
            context,
            AppRouter.REGISTER,
            arguments: initialUser,
          );
        } else {
          showFailureDialog(context, "You need complete all fields");
        }
      },
    );
  }

  bool isContinueButtonEnabled() {
    return isPopulated;
  }

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _addressController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
