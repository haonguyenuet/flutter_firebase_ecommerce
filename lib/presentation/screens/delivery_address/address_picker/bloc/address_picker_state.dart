import 'package:e_commerce_app/data/models/location_model.dart';
import 'package:equatable/equatable.dart';

class AddressPickerState extends Equatable {
  final List<LocationModel> cities;
  final List<LocationModel> districts;
  final List<LocationModel> wards;

  AddressPickerState({
    this.cities = const <LocationModel>[],
    this.districts = const <LocationModel>[],
    this.wards = const <LocationModel>[],
  });

  AddressPickerState cloneWith({
    List<LocationModel>? cities,
    List<LocationModel>? districts,
    List<LocationModel>? wards,
  }) {
    return AddressPickerState(
      cities: cities ?? this.cities,
      districts: districts ?? this.districts,
      wards: wards ?? this.wards,
    );
  }

  @override
  String toString() {
    return "AddressPickerState(cities: ${cities.length}, districts: ${districts.length}, wards: ${wards.length})";
  }

  @override
  List<Object> get props => [cities, districts, wards];
}
