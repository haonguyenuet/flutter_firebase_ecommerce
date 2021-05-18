import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/repository.dart';

class FirebaseMessageRepository implements MessageRepository {
  final userCollection = FirebaseFirestore.instance.collection("users");

  /// Get 20 the first messages
  Stream<List<MessageModel>> fetchRecentMessages({
    required String uid,
    required int messagesLimit,
  }) {
    return userCollection
        .doc(uid)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .limit(messagesLimit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()!))
              .toList(),
        );
  }

  @override
  Future<List<MessageModel>> fetchPreviousMessages({
    required String uid,
    required int messagesLimit,
    required MessageModel lastMessage,
  }) async {
    var messagesCollection = userCollection.doc(uid).collection("messages");
    // Gets a reference to the last message in the existing list
    DocumentSnapshot lastDocument =
        await messagesCollection.doc(lastMessage.id).get();
    return messagesCollection
        .orderBy("createdAt", descending: true)
        .startAfterDocument(lastDocument)
        .limit(messagesLimit)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()!))
              .toList(),
        );
  }

  Future<MessageModel?> getLastestMessage({
    required String uid,
  }) async {
    // Gets the lastest message in the existing list
    QuerySnapshot querySnapshot = await userCollection
        .doc(uid)
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isEmpty) return null;
    return MessageModel.fromMap(querySnapshot.docs[0].data()!);
  }

  /// Add item
  /// Created by NDH
  Future<void> addMessage(String uid, MessageModel message) async {
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
  Future<void> removeMessage(String uid, MessageModel message) async {
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
