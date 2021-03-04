import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// User model
class UserModel extends Equatable {
  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String avatar;

  /// The user's address
  final List<dynamic> address;

  /// The user's phone number
  final String phoneNumber;

  /// Constructor
  const UserModel({
    @required this.email,
    this.id,
    this.address,
    this.phoneNumber,
    this.name,
    this.avatar,
  }) : assert(email != null);

  /// Json data from server turns into model data
  static UserModel fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data["name"] ?? "",
      avatar: data["avatar"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      address: data["address"] ?? [],
      email: data["email"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    Map<String, dynamic> userData = {
      "id": this.id,
      "email": this.email,
      "address": this.address,
      "phoneNumber": this.phoneNumber,
      "name": this.name,
      "avatar": this.avatar,
    };
    return userData;
  }

  /// Clone and update
  UserModel cloneWith({
    email,
    id,
    address,
    phoneNumber,
    name,
    avatar,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  /// Check user has all informations
  bool isCompleteInfo() {
    return this.name.isNotEmpty &&
        this.address.isNotEmpty &&
        this.phoneNumber.isNotEmpty;
  }

  /// Represent to all category
  static const empty =
      UserModel(id: "", name: "", email: "", avatar: "", address: null);

  /// Compare two users by uid
  @override
  List<Object> get props => [email, id, name, avatar];
}
