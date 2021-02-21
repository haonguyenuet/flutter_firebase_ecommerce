import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/user.dart';
import 'abstract/i_user_service.dart';

class UserService extends IUserService {

  var _userCollection = FirebaseFirestore.instance.collection("users");

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
