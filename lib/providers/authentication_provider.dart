import 'dart:async';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/services/abstract/i_user_service.dart';
import 'package:e_commerce_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

/// Authentication Result
class AuthenticationResult {
  final bool isSuccess;
  final String message;

  AuthenticationResult({this.isSuccess, this.message});
}

enum Status { Authenticated, Authenticating, Unauthenticated }

/// Repository which manages user authentication.
class AuthenticationProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  IUserService userService = UserService();
  User _user; // Firebase user
  Status _status = Status.Unauthenticated;

  Status get status => _status;
  User get user => _user;

  AuthenticationProvider.instance()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn.standard() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _user = null;
        _status = Status.Unauthenticated;
      } else {
        _user = firebaseUser;
        _status = Status.Authenticated;
      }
      notifyListeners();
    });
  }

  /// Creates a new user with the provided [email] and [password].
  Future<AuthenticationResult> signUp(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create new record for this user in firestore
      userService.addUserData(result.user.toUser);
      // Return result
      return AuthenticationResult(isSuccess: true, message: "Success");
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return AuthenticationResult(
        isSuccess: false,
        message: e.message.toString(),
      );
    }
  }

  /// Starts the Sign In with Google Flow.
  Future<void> logInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.message);
    }
  }

  /// Signs in with the provided [email] and [password].
  Future<AuthenticationResult> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Return result
      return AuthenticationResult(
        isSuccess: true,
        message: "Success",
      );
    } on FirebaseAuthException catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return AuthenticationResult(
        isSuccess: false,
        message: e.message.toString(),
      );
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  Future<void> logOut() async {
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {}
  }

  /// Get current user
  UserModel getCurrentUser() {
    return _firebaseAuth.currentUser.toUser;
  }
}

// Add extension to firebase_auth.User
extension on User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      avatar: photoURL,
    );
  }
}
