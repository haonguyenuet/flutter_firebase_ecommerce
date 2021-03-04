import 'dart:io';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final User loggedFirebaseUser;

  LoadProfile(this.loggedFirebaseUser);

  List<Object?> get props => [loggedFirebaseUser];

  @override
  String toString() {
    return "LoadProfile{loggedFirebaseUser: ${loggedFirebaseUser.email}}";
  }
}

class UploadAvatar extends ProfileEvent {
  final File imageFile;

  UploadAvatar(this.imageFile);

  List<Object> get props => [imageFile];
}

class ProfileUpdated extends ProfileEvent {
  final UserModel updatedUser;

  ProfileUpdated(this.updatedUser);

  List<Object> get props => [updatedUser];

  @override
  String toString() {
    return "ProfileUpdated{updatedUser: ${updatedUser.avatar}}";
  }
}
