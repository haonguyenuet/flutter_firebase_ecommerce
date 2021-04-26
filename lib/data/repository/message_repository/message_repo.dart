import 'package:e_commerce_app/data/entities/entites.dart';

abstract class MessageRepository {
  /// Get 20 first messages
  /// Created by NDH
  Stream<List<Message>> getRecentMessages({
    required String uid,
    required int messagesLimit,
  });

  /// Get more messages
  /// Created by NDH
  Future<List<Message>> getPreviousMessages({
    required String uid,
    required int messagesLimit,
    required Message lastMessage,
  });

  /// Get lastest message
  /// Created by NDH
  Future<Message?> getLastestMessage({required String uid});

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
