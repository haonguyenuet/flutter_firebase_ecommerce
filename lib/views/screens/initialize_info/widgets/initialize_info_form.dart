import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
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
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize * 1.5,
        vertical: SizeConfig.defaultSize * 3,
      ),
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
                style: FONT_CONST.BOLD_PRIMARY_18,
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildNameInput(),
            SizedBox(height: SizeConfig.defaultSize),
            _buildPhoneNumberInput(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildButtonContinue(),
            SizedBox(height: SizeConfig.defaultSize),
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
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (isContinueButtonEnabled()) {
          UserModel initialUser = UserModel(
            id: "",
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
            content: "You need to complete all fields",
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
