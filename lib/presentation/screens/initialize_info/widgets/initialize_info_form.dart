import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize * 1.5,
        vertical: SizeConfig.defaultSize * 3,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
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
      validator: (value) {
        return Validators.isValidName(value!)
            ? null
            : Translate.of(context).translate("invalid_name");
      },
      decoration: InputDecoration(
        hintText: Translate.of(context).translate("name"),
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  _buildPhoneNumberInput() {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.text,
      validator: (value) {
        return Validators.isVietnamesePhoneNumber(value!)
            ? null
            : Translate.of(context).translate("invalid_phone_number");
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: Translate.of(context).translate("phone_number"),
        suffixIcon: Icon(Icons.phone_callback),
      ),
    );
  }

  _buildButtonContinue() {
    return DefaultButton(
      child: Text(
        Translate.of(context).translate("continue").toUpperCase(),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (isContinueButtonEnabled()) {
          UserModel initialUser = UserModel(
            id: "",
            email: "",
            avatar: "",
            addresses: [],
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
            content: Translate.of(context)
                .translate("you_need_to_complete_all_fields"),
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
          Text(Translate.of(context).translate("already_have_an_account")),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
              (_) => false,
            ),
            child: Text(
              Translate.of(context).translate("login"),
              style: FONT_CONST.MEDIUM_PRIMARY_16,
            ),
          ),
        ],
      ),
    );
  }

  bool isContinueButtonEnabled() {
    return _formKey.currentState!.validate();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
