import 'package:e_commerce_app/data/models/models.dart';

abstract class MessageRepository {
  /// Get 20 first messages
  /// Created by NDH
  Stream<List<MessageModel>> fetchRecentMessages({
    required String uid,
    required int messagesLimit,
  });

  /// Get more messages
  /// Created by NDH
  Future<List<MessageModel>> fetchPreviousMessages({
    required String uid,
    required int messagesLimit,
    required MessageModel lastMessage,
  });

  /// Get lastest message
  /// Created by NDH
  Future<MessageModel?> getLastestMessage({required String uid});

  /// Add message
  /// [uid] is user id
  /// [newItem] is data of new  message
  /// Created by NDH
  Future<void> addMessage(String uid, MessageModel message);

  /// Remove message
  /// [uid] is user id
  /// [cartItem] is data of  message
  /// Created by NDH
  Future<void> removeMessage(String uid, MessageModel message);
}
