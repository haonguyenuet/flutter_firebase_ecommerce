import 'package:e_commerce_app/models/user.dart';

abstract class IUserService {
  /// Get user by id
  Future<UserModel> getUserById(String id);

  /// Add new doc to users collection
  void addUserData(UserModel user);

  /// Update doc in users collection
  void updateUserData(Map<String, dynamic> values);
}
