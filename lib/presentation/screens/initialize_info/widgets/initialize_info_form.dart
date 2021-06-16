import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:flutter/services.dart';

class InitializeInfoForm extends StatefulWidget {
  @override
  _InitializeInfoFormState createState() => _InitializeInfoFormState();
}

class _InitializeInfoFormState extends State<InitializeInfoForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void onClickContinue() {
    if (formKey.currentState!.validate()) {
      UserModel initialUser = UserModel(
        id: "",
        email: "",
        avatar: "",
        addresses: [],
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
      );
      Navigator.pushReplacementNamed(
        context,
        AppRouter.REGISTER,
        arguments: initialUser,
      );
    } else {
      UtilDialog.showInformation(
        context,
        content:
            Translate.of(context).translate("you_need_to_complete_all_fields"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        vertical: SizeConfig.defaultSize * 3,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _buildNameInput(),
            SizedBox(height: SizeConfig.defaultSize),
            _buildPhoneNumberInput(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildButtonContinue(),
          ],
        ),
      ),
    );
  }

  /// Build content
  _buildNameInput() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return UtilValidators.isValidName(value!)
            ? null
            : Translate.of(context).translate("invalid_name");
      },
      decoration: InputDecoration(
        hintText: Translate.of(context).translate("name"),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildPhoneNumberInput() {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return UtilValidators.isVietnamesePhoneNumber(value!)
            ? null
            : Translate.of(context).translate("invalid_phone_number");
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: Translate.of(context).translate("phone_number"),
        suffixIcon: Icon(Icons.phone_callback_outlined),
      ),
    );
  }

  _buildButtonContinue() {
    return DefaultButton(
      child: Text(
        Translate.of(context).translate("continue").toUpperCase(),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: onClickContinue,
    );
  }

 
}
