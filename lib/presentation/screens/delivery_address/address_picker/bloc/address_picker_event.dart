import 'package:equatable/equatable.dart';

abstract class AddressPickerEvent extends Equatable {
  const AddressPickerEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AddressPickerEvent {
  final int? cityId;
  final int? districtId;

  InitialEvent({this.cityId, this.districtId});
}

class LoadDistricts extends AddressPickerEvent {
  final int cityId;

  LoadDistricts(this.cityId);

  List<Object> get props => [cityId];
}

class LoadWards extends AddressPickerEvent {
  final int districtId;

  LoadWards(this.districtId);

  List<Object> get props => [districtId];
}
