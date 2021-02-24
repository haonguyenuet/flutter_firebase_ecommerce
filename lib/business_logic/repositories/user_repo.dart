import 'dart:async';

import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_user_service.dart';
import 'package:e_commerce_app/business_logic/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Repository which manages user authentication.
class UserRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  IUserService _userService = UserService();
  String _authException = "";

  /// Don't use onAuthChange

  /// Creates a new user with the provided [information]
  /// Created by NDH
  Future<void> signUp(UserModel newUser, String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: password,
      );

      /// Add id for new user
      newUser = newUser.cloneWith(id: result.user.uid);

      /// Create new doc in users collection
      _userService.addUserData(newUser);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  /// Signs in with the provided [email] and [password].
  /// Created by NDH
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  /// Starts the Sign In with Google Flow.
  /// Created by NDH
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  /// Signs out the current user
  /// Created by NDH
  Future<void> logOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]).catchError((error) => print(error));
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<UserModel> getCurrentUser() async {
    User currFisebaseUser = _firebaseAuth.currentUser;
    return await _userService.getUserById(currFisebaseUser.uid);
  }

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  String get authException => _authException;
}
