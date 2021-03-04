import 'dart:async';

import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/business_logic/repository/storage_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;
  StorageRepository _storageRepository;
  StreamSubscription _userProfileSubscription;
  UserModel _loggedUser;

  ProfileBloc({
    @required UserRepository userRepository,
    @required StorageRepository storageRepository,
  })  : assert(userRepository != null),
        assert(storageRepository != null),
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        super(ProfileLoading());

  @override
  Stream<ProfileState> mapEventToState(event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState(event);
    } else if (event is UploadAvatar) {
      yield* _mapUploadAvatarToState(event);
    } else if (event is ProfileUpdated) {
      yield* _mapProfileUpdatedToState(event);
    }
  }

  Stream<ProfileState> _mapLoadProfileToState(LoadProfile event) async* {
    try {
      _userProfileSubscription?.cancel();
      _userProfileSubscription = _userRepository
          .loggedUserStream(event.loggedFirebaseUser)
          .listen((user) => add(ProfileUpdated(user)));
    } catch (e) {
      print(e);
      yield ProfileLoadFailure(e.toString());
    }
  }

  Stream<ProfileState> _mapUploadAvatarToState(UploadAvatar event) async* {
    try {
      String imageUrl = await _storageRepository.uploadImage(
        "users/profile/${_loggedUser.id}",
        event.imageFile,
      );
      var updatedUser = _loggedUser.cloneWith(avatar: imageUrl);
      // Update user avatar
      await _userRepository.updateUserData(updatedUser);
    } catch (e) {}
  }

  Stream<ProfileState> _mapProfileUpdatedToState(ProfileUpdated event) async* {
    try {
      _loggedUser = event.updatedUser;
      yield ProfileLoaded(event.updatedUser);
    } catch (e) {
      print(e);
      yield ProfileLoadFailure(e.toString());
    }
  }

  @override
  Future<void> close() {
    _userProfileSubscription?.cancel();
    _loggedUser = null;
    return super.close();
  }
}
