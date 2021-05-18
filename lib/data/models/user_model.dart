import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

/// User model
class UserModel extends Equatable {
  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String email;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String avatar;

  /// The user's phone number
  final String phoneNumber;

  final List<DeliveryAddressModel> addresses;

  /// Get default address
  DeliveryAddressModel? get defaultAddress {
    return addresses.isEmpty
        ? null
        : addresses.firstWhere((address) => address.isDefault);
  }

  /// Constructor
  const UserModel({
    required this.email,
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.addresses,
  });

  /// Json data from server turns into model data
  static UserModel fromMap(Map<String, dynamic> data) {
    List<DeliveryAddressModel> addresses = [];
    if (data["addresses"] != null) {
      data["addresses"].forEach((item) {
        addresses.add(DeliveryAddressModel.fromMap(item));
      });
    }
    return UserModel(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      avatar: data["avatar"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      addresses: addresses,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "avatar": this.avatar,
      "phoneNumber": this.phoneNumber,
      "addresses":
          List<dynamic>.from(this.addresses.map((item) => item.toMap()))
    };
  }

  /// Clone and update
  UserModel cloneWith({
    email,
    id,
    addresses,
    phoneNumber,
    name,
    avatar,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  String toString() {
    return "UserModel:{email:${this.email},name:${this.name},phoneNumber:${this.phoneNumber},avatar:${this.avatar},addresses:${this.addresses}}";
  }

  /// Compare two users
  @override
  List<Object?> get props => [email, id, name, avatar, phoneNumber, addresses];
}
