import 'dart:async';

import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/business_logic/repository/storage_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;
  StorageRepository _storageRepository;
  StreamSubscription? _profileStreamSub;
  UserModel? _loggedUser;

  ProfileBloc({
    required UserRepository userRepository,
    required StorageRepository storageRepository,
  })   : _userRepository = userRepository,
        _storageRepository = storageRepository,
        super(ProfileLoading());

  @override
  Stream<ProfileState> mapEventToState(event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState(event);
    } else if (event is UploadAvatar) {
      yield* _mapUploadAvatarToState(event);
    } else if (event is AddressListChanged) {
      yield* _mapAddressListChangedToState(event);
    } else if (event is ProfileUpdated) {
      yield* _mapProfileUpdatedToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileToState(LoadProfile event) async* {
    try {
      _profileStreamSub?.cancel();
      _profileStreamSub = _userRepository
          .loggedUserStream(event.loggedFirebaseUser)
          .listen((user) => add(ProfileUpdated(user)));
    } catch (e) {
      yield ProfileLoadFailure(e.toString());
    }
  }

  Stream<ProfileState> _mapUploadAvatarToState(UploadAvatar event) async* {
    try {
      // Get image url from firebase storage
      String imageUrl = await _storageRepository.uploadImage(
        "users/profile/${_loggedUser!.id}",
        event.imageFile,
      );
      // Clone logged user with updated avatar
      var updatedUser = _loggedUser!.cloneWith(avatar: imageUrl);
      // Update user's avatar
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {}
  }

  ///
  Stream<ProfileState> _mapAddressListChangedToState(
      AddressListChanged event) async* {
    try {
      // Get delivery address from event
      var deliveryAddress = event.deliveryAddress;
      // Get current addresses
      var addresses = List<DeliveryAddress>.from(_loggedUser!.addresses!);
      if (deliveryAddress.isDefault) {
        addresses =
            addresses.map((item) => item.cloneWith(isDefault: false)).toList();
      }
      // Check method
      switch (event.method) {
        case ListMethod.ADD:
          addresses.add(deliveryAddress);
          break;
        case ListMethod.DELETE:
          addresses.remove(deliveryAddress);
          break;
        case ListMethod.UPDATE:
          addresses = addresses.map((item) {
            return item.id == deliveryAddress.id ? deliveryAddress : item;
          }).toList();

          break;
        default:
      }
      // Clone logged user with updated addresses
      var updatedUser = _loggedUser!.cloneWith(addresses: addresses);
      // Update user's addresses
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {}
  }

  Stream<ProfileState> _mapProfileUpdatedToState(ProfileUpdated event) async* {
    try {
      _loggedUser = event.updatedUser;
      yield ProfileLoaded(event.updatedUser);
    } catch (e) {
      yield ProfileLoadFailure(e.toString());
    }
  }

  @override
  Future<void> close() {
    _profileStreamSub?.cancel();
    _loggedUser = null;
    return super.close();
  }
}

enum ListMethod { ADD, DELETE, UPDATE }
