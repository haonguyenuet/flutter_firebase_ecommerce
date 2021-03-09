import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/delivery_address.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_dialog.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            _buildNameInput(),
            SizedBox(height: 10),
            _buildPhoneNumberInput(),
            SizedBox(height: 10),
            _buildDetailAddressInput(),
            _buildGoogleMapOption(),
            _buildSwitchDefaultAddress(),
            if (!deliveryAddress!.isDefault) _buildDeleteButton(),
            _buildSubmitButton(),
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
        labelText: "Name",
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        border: outlineInputBorder(),
      ),
    );
  }

  _buildPhoneNumberInput() {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Phone Number",
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        border: outlineInputBorder(),
      ),
    );
  }

  _buildDetailAddressInput() {
    return TextFormField(
      controller: _detailAddressController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Detail address",
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        border: outlineInputBorder(),
      ),
    );
  }

  _buildGoogleMapOption() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: mDarkShadeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Use google map",
            style: FONT_CONST.REGULAR_WHITE_16,
          ),
          IconButton(
            icon: Icon(Icons.forward, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  _buildSwitchDefaultAddress() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: mDarkShadeColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Put this is default address",
            style: FONT_CONST.REGULAR_WHITE_16,
          ),
          CupertinoSwitch(
            value: _isDefaultAddress,
            onChanged: deliveryAddress!.isDefault
                ? null
                : (value) {
                    setState(() => _isDefaultAddress = value);
                  },
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
            id: UniqueKey().toString(),
            receiverName: _nameController.text,
            phoneNumber: _phoneNumberController.text,
            detailAddress: _detailAddressController.text,
            isDefault: _isDefaultAddress,
          );
          // Call add delivery address event
          BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
            deliveryAddress: newAddress,
            method: ListMethod.ADD,
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
    return Container(
      width: double.infinity,
      color: Color(0xFFF5F6F9),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        onPressed: () {
          BlocProvider.of<ProfileBloc>(context).add(AddressListChanged(
            deliveryAddress: deliveryAddress!,
            method: ListMethod.DELETE,
          ));
          Navigator.pop(context);
        },
        child: Text("Delete", style: FONT_CONST.BOLD_DEFAULT_18),
      ),
    );
  }

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty &&
      _detailAddressController.text.isNotEmpty;
}
