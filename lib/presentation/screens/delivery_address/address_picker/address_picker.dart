import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/data/models/delivery_address_model.dart';
import 'package:e_commerce_app/data/models/location_model.dart';
import 'package:e_commerce_app/presentation/screens/delivery_address/address_picker/bloc/bloc.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPicker extends StatefulWidget {
  final Function(LocationModel, LocationModel, LocationModel) addressChanged;
  final DeliveryAddressModel? deliveryAddress;
  const AddressPicker({
    Key? key,
    this.deliveryAddress,
    required this.addressChanged,
  }) : super(key: key);

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  LocationModel? selectedCity;
  LocationModel? selectedDistrict;
  LocationModel? selectedWard;

  @override
  void initState() {
    if (widget.deliveryAddress != null) {
      var detailAddress = widget.deliveryAddress!;
      selectedCity = detailAddress.city;
      selectedDistrict = detailAddress.district;
      selectedWard = detailAddress.ward;
    }
    super.initState();
  }

  void onCityChanged(BuildContext context, LocationModel city) {
    selectedCity = city;
    selectedDistrict = null;
    selectedWard = null;

    BlocProvider.of<AddressPickerBloc>(context).add(LoadDistricts(city.id));
  }

  void onDistrictChanged(BuildContext context, LocationModel district) {
    selectedDistrict = district;
    selectedWard = null;

    BlocProvider.of<AddressPickerBloc>(context).add(LoadWards(district.id));
  }

  void onWardChanged(LocationModel ward) {
    setState(() {
      selectedWard = ward;
    });
    widget.addressChanged(selectedCity!, selectedDistrict!, selectedWard!);
  }

  getDropdownItems(List<LocationModel> list) {
    return list
        .map((item) => DropdownMenuItem(child: Text(item.name), value: item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (widget.deliveryAddress != null) {
          return AddressPickerBloc()
            ..add(InitialEvent(
              cityId: selectedCity!.id,
              districtId: selectedDistrict!.id,
            ));
        } else {
          return AddressPickerBloc()..add(InitialEvent());
        }
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<AddressPickerBloc, AddressPickerState>(
            builder: (context, state) {
              return Column(
                children: [
                  buildCityPicker(context, state),
                  SizedBox(height: SizeConfig.defaultSize),
                  buildDistrictPicker(context, state),
                  SizedBox(height: SizeConfig.defaultSize),
                  buildWardPicker(context, state), 
                ],
              );
            },
          );
        },
      ),
    );
  }

  buildCityPicker(BuildContext context, AddressPickerState state) {
    return DropdownButtonFormField<LocationModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("city"),
      ),
      onChanged: (city) => onCityChanged(context, city!),
      items: getDropdownItems(state.cities),
      value: state.cities.isEmpty ? null : selectedCity,
    );
  }

  buildDistrictPicker(BuildContext context, AddressPickerState state) {
    return DropdownButtonFormField<LocationModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("district"),
      ),
      onChanged: (district) => onDistrictChanged(context, district!),
      items: getDropdownItems(state.districts),
      value: state.districts.isEmpty ? null : selectedDistrict,
    );
  }

  buildWardPicker(BuildContext context, AddressPickerState state) {
    return DropdownButtonFormField<LocationModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("ward"),
      ),
      isExpanded: true,
      onChanged: (ward) => onWardChanged(ward!),
      items: getDropdownItems(state.wards),
      value: state.wards.isEmpty ? null : selectedWard,
    );
  }


}
