import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/data/models/location_model.dart';

import 'package:e_commerce_app/data/repository/app_repository.dart';
import 'package:e_commerce_app/data/repository/location_repository/location_repo.dart';

import 'address_picker_event.dart';
import 'address_picker_state.dart';

class AddressPickerBloc extends Bloc<AddressPickerEvent, AddressPickerState> {
  LocationRepository _locationRepository = AppRepository.locationRepository;

  AddressPickerBloc() : super(AddressPickerState());

  @override
  Stream<AddressPickerState> mapEventToState(AddressPickerEvent event) async* {
    if (event is InitialEvent) {
      yield* _mapInitialEventToState(event, state);
    } else if (event is LoadDistricts) {
      yield* _mapLoadDistrictsToState(event, state);
    } else if (event is LoadWards) {
      yield* _mapLoadWardsToState(event, state);
    }
  }

  Stream<AddressPickerState> _mapInitialEventToState(
    InitialEvent event,
    AddressPickerState state,
  ) async* {
    try {
      List<LocationModel> cities = await _locationRepository.fetchCities();
      List<LocationModel> districts = [];
      List<LocationModel> wards = [];
      if (event.cityId != null) {
        districts = await _locationRepository.fetchDistricts(event.cityId!);
      }
      if (event.districtId != null) {
        wards = await _locationRepository.fetchWards(event.districtId!);
      }
      yield state.cloneWith(
        cities: cities,
        districts: districts,
        wards: wards,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AddressPickerState> _mapLoadDistrictsToState(
    LoadDistricts event,
    AddressPickerState state,
  ) async* {
    try {
      var districts = await _locationRepository.fetchDistricts(event.cityId);
      yield state.cloneWith(districts: districts, wards: []);
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<AddressPickerState> _mapLoadWardsToState(
    LoadWards event,
    AddressPickerState state,
  ) async* {
    try {
      var wards = await _locationRepository.fetchWards(event.districtId);
      yield state.cloneWith(wards: wards);
    } catch (e) {
      print(e.toString());
    }
  }
}
