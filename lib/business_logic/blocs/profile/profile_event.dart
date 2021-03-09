import 'dart:io';
import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

///
class LoadProfile extends ProfileEvent {
  final User loggedFirebaseUser;

  LoadProfile(this.loggedFirebaseUser);

  List<Object?> get props => [loggedFirebaseUser];
}

///
class UploadAvatar extends ProfileEvent {
  final File imageFile;

  UploadAvatar(this.imageFile);

  List<Object> get props => [imageFile];
}

///
class AddressListChanged extends ProfileEvent {
  final DeliveryAddress deliveryAddress;
  final ListMethod method;

  AddressListChanged({required this.deliveryAddress, required this.method});

  List<Object> get props => [deliveryAddress, method];
}

///
class ProfileUpdated extends ProfileEvent {
  final UserModel updatedUser;

  ProfileUpdated(this.updatedUser);

  List<Object> get props => [updatedUser];
}
