import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
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

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, avatar: null);

  @override
  List<Object> get props => [email, id, name, avatar];
}
