import 'package:e_commerce_app/data/entities/entites.dart';

abstract class MessageRepository {
  /// Get all messages of logged user
  /// Created by NDH
  Future<List<Message>> getMessages({
    required String uid,
    required int messagesLimit,
    required bool isTheFirstTime,
  });

  /// Add message
  /// [uid] is user id
  /// [newItem] is data of new  message
  /// Created by NDH
  Future<void> addMessage(String uid, Message message);

  /// Remove message
  /// [uid] is user id
  /// [cartItem] is data of  message
  /// Created by NDH
  Future<void> removeMessage(String uid, Message message);
}
