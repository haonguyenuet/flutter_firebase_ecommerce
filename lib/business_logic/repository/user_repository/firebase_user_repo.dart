import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository implements UserRepository {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  UserModel _currentUser = UserModel.empty;
  String _authException = "";

  UserModel get currentUser => _currentUser;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  String get authException => _authException;

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
      this.addUserData(newUser);
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

  Future<bool> isLoggedIn() async {
    var currFirebaseUser = _firebaseAuth.currentUser;
    // Get current user from firestore
    if (currFirebaseUser != null) {
      _currentUser = await this.getUserById(currFirebaseUser.uid);
    }
    return _currentUser != UserModel.empty;
  }

  /// Signs out the current user
  /// Created by NDH
  Future<void> logOut() async {
    _currentUser = UserModel.empty;
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]).catchError((error) => print(error));
  }

  /// Get user by id
  Future<UserModel> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.id, doc.data()))
        .catchError((error) => print(error));
  }

  /// Add new doc to users collection
  Future<void> addUserData(UserModel user) async {
    await _userCollection.doc(user.id).set(user.toMap());
  }

  /// Update doc in users collection
  Future<void> updateUserData(UserModel user) async {
    await _userCollection.doc(user.id).update(user.toMap());
  }
}
