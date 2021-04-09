import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/dialog.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressBottomSheet extends StatefulWidget {
  final DeliveryAddress? deliveryAddress;

  const DeliveryAddressBottomSheet({Key? key, this.deliveryAddress})
      : super(key: key);
  @override
  _DeliveryAddressBottomSheetState createState() =>
      _DeliveryAddressBottomSheetState();
}

class _DeliveryAddressBottomSheetState
    extends State<DeliveryAddressBottomSheet> {
  // [deliveryAddress] is null, that means addresses is empty
  // So name and phoneNumber is default
  // And isDefaultAddress = true
  DeliveryAddress? get deliveryAddress => widget.deliveryAddress;

  // local states
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailAddressController = TextEditingController();

  bool isDefaultAddress = true;

  bool get isPopulated =>
      nameController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      detailAddressController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    var profileState = BlocProvider.of<ProfileBloc>(context).state;

    if (deliveryAddress != null) {
      nameController.text = deliveryAddress!.receiverName;
      phoneNumberController.text = deliveryAddress!.phoneNumber;
      detailAddressController.text = deliveryAddress!.detailAddress;
      isDefaultAddress = deliveryAddress!.isDefault;
    } else if (profileState is ProfileLoaded) {
      nameController.text = profileState.loggedUser.name;
      phoneNumberController.text = profileState.loggedUser.phoneNumber;
    }
  }

  Function(bool value)? onSwitchButtonChanged() {
    return deliveryAddress == null || deliveryAddress!.isDefault
        ? null
        : (value) => setState(() => isDefaultAddress = value);
  }

  void onSubmitAddress() {
    if (isPopulated) {
      // Create new delivery address
      var newAddress = DeliveryAddress(
        id: deliveryAddress != null
            ? deliveryAddress!.id
            : UniqueKey().toString(),
        receiverName: nameController.text,
        phoneNumber: phoneNumberController.text,
        detailAddress: detailAddressController.text,
        isDefault: isDefaultAddress,
      );
      // Define method submit
      var _method =
          deliveryAddress == null ? ListMethod.ADD : ListMethod.UPDATE;
      // Call delivery address event
      BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
        deliveryAddress: newAddress,
        method: _method,
      ));

      Navigator.pop(context);
    } else {
      UtilDialog.showInformation(
        context,
        content:
            Translate.of(context).translate("you_need_to_complete_all_fields"),
      );
    }
  }

  void onRemoveAddress() {
    BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
      deliveryAddress: deliveryAddress!,
      method: ListMethod.DELETE,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildInput(),
              _buildGoogleMapOption(),
              _buildSwitchDefaultAddress(),
              _buildDeleteButton(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildInput() {
    return CustomCardWidget(
      child: Column(
        children: [
          // Name input
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("name"),
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
              ),
              border: outlineInputBorder(),
            ),
          ),

          SizedBox(height: SizeConfig.defaultSize),
          // Phone number input
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("phone_number"),
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
              ),
              border: outlineInputBorder(),
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize),
          // Detail address input
          TextFormField(
            controller: detailAddressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: Translate.of(context).translate("detail_address"),
              contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.defaultSize,
                horizontal: SizeConfig.defaultSize * 2,
              ),
              border: outlineInputBorder(),
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  _buildGoogleMapOption() {
    return CustomCardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translate.of(context).translate("use_google_map"),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () => Navigator.pushNamed(context, AppRouter.MAP),
          )
        ],
      ),
    );
  }

  _buildSwitchDefaultAddress() {
    return CustomCardWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translate.of(context).translate("put_this_is_default_address"),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          CupertinoSwitch(
            value: isDefaultAddress,
            onChanged: onSwitchButtonChanged(),
            trackColor: COLOR_CONST.primaryColor,
          ),
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultPadding,
      ),
      child: DefaultButton(
        child: Text(
          Translate.of(context).translate("confirm"),
          style: FONT_CONST.BOLD_WHITE_18,
        ),
        onPressed: onSubmitAddress,
      ),
    );
  }

  _buildDeleteButton() {
    return deliveryAddress != null && !deliveryAddress!.isDefault
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 0.5,
              horizontal: SizeConfig.defaultPadding,
            ),
            child: DefaultButton(
              onPressed: onRemoveAddress,
              child: Text(
                Translate.of(context).translate("delete"),
                style: FONT_CONST.BOLD_WHITE_18,
              ),
              backgroundColor: COLOR_CONST.deleteButtonColor,
            ),
          )
        : Container();
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: COLOR_CONST.textColor),
    );
  }
}
