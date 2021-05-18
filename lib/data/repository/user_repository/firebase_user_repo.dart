import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/user_repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository implements UserRepository {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  /// Stream of logged user model
  /// [loggedFirebaseUser] is user of firebase auth
  /// Created by NDH
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser) {
    return _userCollection
        .doc(loggedFirebaseUser.uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }

  /// Get user by id
  /// [uid] is user id
  /// Created by NDH
  Future<UserModel> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()!))
        .catchError((error) {});
  }

  /// Add new doc to users collection
  /// [user] is data of new user
  /// Created by NDH
  Future<void> addUserData(UserModel newUser) async {
    await _userCollection
        .doc(newUser.id)
        .set(newUser.toMap())
        .catchError((error) => print(error));
  }

  /// Update a doc in users collection
  /// [user] is updated data of user
  /// Created by NDH
  Future<void> updateUserData(UserModel updatedUser) async {
    await _userCollection.doc(updatedUser.id).get().then((doc) async {
      if (doc.exists) {
        // update
        await doc.reference.update(updatedUser.toMap());
      }
    }).catchError((error) {});
  }

  ///Singleton factory
  static final FirebaseUserRepository _instance =
      FirebaseUserRepository._internal();

  factory FirebaseUserRepository() {
    return _instance;
  }

  FirebaseUserRepository._internal();
}
