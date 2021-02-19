import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserModel extends Equatable {
  /// {@macro user}
  const UserModel({
    @required this.email,
    @required this.id,
    this.name,
    this.avatar,
  })  : assert(email != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String avatar;

  @override
  List<Object> get props => [email, id, name, avatar];

  static UserModel fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data["name"] ?? "",
      avatar: data["avatar"] ?? "",
      email: data["email"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> userData = {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "avatar": this.avatar,
    };
    return userData;
  }
}
