import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_dialog.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryAddressBottomSheet extends StatefulWidget {
  final DeliveryAddress? deliveryAddress;

  const DeliveryAddressBottomSheet({
    Key? key,
    this.deliveryAddress,
  }) : super(key: key);
  @override
  _DeliveryAddressBottomSheetState createState() =>
      _DeliveryAddressBottomSheetState();
}

class _DeliveryAddressBottomSheetState
    extends State<DeliveryAddressBottomSheet> {
  DeliveryAddress? get deliveryAddress => widget.deliveryAddress;

  // local states
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _detailAddressController =
      TextEditingController();

  bool _isDefaultAddress = false;

  @override
  void initState() {
    super.initState();
    if (deliveryAddress != null) {
      _nameController.text = deliveryAddress!.receiverName;
      _phoneNumberController.text = deliveryAddress!.phoneNumber;
      _detailAddressController.text = deliveryAddress!.detailAddress;
      _isDefaultAddress = deliveryAddress!.isDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize),
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
      margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Column(
        children: [
          // Name input
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name",
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
              ),
              border: outlineInputBorder(),
            ),
          ),

          SizedBox(height: SizeConfig.defaultSize),
          // Phone number input
          TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.text,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: "Phone Number",
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
              ),
              border: outlineInputBorder(),
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize),
          // Detail address input
          TextFormField(
            controller: _detailAddressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Detail address",
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
      margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Use google map", style: FONT_CONST.MEDIUM_DEFAULT_18),
          IconButton(icon: Icon(Icons.forward), onPressed: () {})
        ],
      ),
    );
  }

  _buildSwitchDefaultAddress() {
    return CustomCardWidget(
      margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Put this is default address",
            style: FONT_CONST.MEDIUM_DEFAULT_18,
          ),
          CupertinoSwitch(
            value: _isDefaultAddress,
            onChanged: deliveryAddress != null && deliveryAddress!.isDefault
                ? null
                : (value) => setState(() => _isDefaultAddress = value),
            trackColor: mAccentShadeColor,
          ),
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return DefaultButton(
      child: Text("Done", style: FONT_CONST.BOLD_WHITE_18),
      onPressed: () {
        if (isPopulated) {
          // Create new delivery address
          var newAddress = DeliveryAddress(
            id: deliveryAddress != null
                ? deliveryAddress!.id
                : UniqueKey().toString(),
            receiverName: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            detailAddress: _detailAddressController.text,
            isDefault: _isDefaultAddress,
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
          MyDialog.showInformation(
            context,
            content: "You need to complete all fields",
          );
        }
      },
    );
  }

  _buildDeleteButton() {
    return deliveryAddress != null && !deliveryAddress!.isDefault
        ? Container(
            margin: EdgeInsets.only(bottom: SizeConfig.defaultSize * 1.5),
            width: double.infinity,
            height: SizeConfig.defaultSize * 5,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red[300]),
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
                  deliveryAddress: deliveryAddress!,
                  method: ListMethod.DELETE,
                ));
                Navigator.pop(context);
              },
              child: Text("Delete", style: FONT_CONST.BOLD_WHITE_18),
            ),
          )
        : Container();
  }

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _detailAddressController.text.isNotEmpty;
}
