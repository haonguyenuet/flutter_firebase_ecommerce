import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/user.dart';

import 'abstract/i_user_service.dart';

class UserService extends IUserService {
  var userCollection = FirebaseFirestore.instance.collection("users");

  /// Get user by id
  Future<UserModel> getUserById(String id) async {
    return await userCollection.doc(id).get().then((doc) {
      return UserModel.fromMap(doc.id, doc.data());
    });
  }

  /// Add new doc to users collection
  void addUserData(UserModel user) async {
    await userCollection.doc(user.id).set(user.toMap());
  }

  /// Update doc in users collection
  void updateUserData(Map<String, dynamic> values) async {
    await userCollection.doc(values['id']).update(values);
  }
}
