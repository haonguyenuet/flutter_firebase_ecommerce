import 'package:e_commerce_app/models/user.dart';

abstract class IUserService {
  /// Get user by id
  Future<UserModel> getUserById(String id);

  /// Add new doc to users collection
  Future<void> addUserData(UserModel user);

  /// Update doc in users collection
  Future<void> updateUserData(UserModel user);
}
