import 'package:equatable/equatable.dart';

abstract class AddressPickerEvent extends Equatable {
  const AddressPickerEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AddressPickerEvent {
  final String? cityId;
  final String? districtId;

  InitialEvent({this.cityId, this.districtId});
}

class LoadDistricts extends AddressPickerEvent {
  final String cityId;

  LoadDistricts(this.cityId);

  List<Object> get props => [cityId];
}

class LoadWards extends AddressPickerEvent {
  final String districtId;

  LoadWards(this.districtId);

  List<Object> get props => [districtId];
}
