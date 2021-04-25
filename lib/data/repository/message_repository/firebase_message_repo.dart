import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/entities/entites.dart';
import 'package:e_commerce_app/data/repository/repository.dart';

class FirebaseMessageRepository implements MessageRepository {
  final userCollection = FirebaseFirestore.instance.collection("users");
  DocumentSnapshot? lastDocument;

  /// Get all messages of logged user
  Future<List<Message>> getMessages({
    required String uid,
    required int messagesLimit,
    required bool isTheFirstTime,
  }) async {
    Query messagesQuery = userCollection
        .doc(uid)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .limit(messagesLimit);

    if (isTheFirstTime == false && lastDocument != null) {
      messagesQuery = messagesQuery.startAfterDocument(lastDocument!);
    }

    QuerySnapshot querySnapshot = await messagesQuery.get();
    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    }

    return querySnapshot.docs
        .map((doc) => Message.fromMap(doc.data()!))
        .toList();
  }

  /// Add item
  /// Created by NDH
  Future<void> addMessage(String uid, Message message) async {
    await userCollection
        .doc(uid)
        .collection("messages")
        .doc(message.id)
        .set(message.toMap())
        .catchError((error) {
      print(error);
    });
  }

  /// Remove item
  /// Created by NDH
  Future<void> removeMessage(String uid, Message message) async {
    await userCollection
        .doc(uid)
        .collection("messages")
        .doc(message.id)
        .delete()
        .catchError((error) => print(error));
  }

  ///Singleton factory
  static final FirebaseMessageRepository _instance =
      FirebaseMessageRepository._internal();

  factory FirebaseMessageRepository() {
    return _instance;
  }

  FirebaseMessageRepository._internal();
}
