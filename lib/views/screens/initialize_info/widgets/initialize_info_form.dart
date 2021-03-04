import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/services.dart';

class InitializeInfoForm extends StatefulWidget {
  @override
  _InitializeInfoFormState createState() => _InitializeInfoFormState();
}

class _InitializeInfoFormState extends State<InitializeInfoForm> {
  final TextEditingController _nameController = TextEditingController();
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
            _buildPhoneNumberInput(),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildButtonContinue(),
            SizedBox(height: getProportionateScreenHeight(10)),
            _buildHaveAccountText(),
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
            phoneNumber: _phoneNumberController.text,
          );
          Navigator.pushNamed(
            context,
            AppRouter.REGISTER,
            arguments: initialUser,
          );
        } else {
          MyDialog.showInformation(
            context,
            content: "You need complete all fields",
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
              style: TextStyle(color: mPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  bool isContinueButtonEnabled() {
    return isPopulated;
  }

  bool get isPopulated =>
      _nameController.text.isNotEmpty && _phoneNumberController.text.isNotEmpty;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
