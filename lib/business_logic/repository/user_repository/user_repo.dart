import 'package:e_commerce_app/business_logic/entities/user.dart';

abstract class UserRepository {
  UserModel get currentUser;
  String get authException;

  /// Creates a new user with the provided [information]
  /// Created by NDH
  Future<void> signUp(UserModel newUser, String password);

  /// Signs in with the provided [email] and [password].
  /// Created by NDH
  Future<void> logInWithEmailAndPassword(String email, String password);

  /// Starts the Sign In with Google Flow.
  /// Created by NDH
  Future<void> logInWithGoogle();

  Future<bool> isLoggedIn();

  /// Signs out the current user
  /// Created by NDH
  Future<void> logOut();

  /// Get user by id
  /// Created by NDH
  Future<UserModel> getUserById(String uid);

  /// Add new doc to users collection
  /// Created by NDH
  Future<void> addUserData(UserModel user);

  /// Update doc in users collection
  /// Created by NDH
  Future<void> updateUserData(UserModel user);
}
