import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String fromId;
  final String content;
  final bool isImageContent;
  final Timestamp createdAt;

  Message({
    required this.fromId,
    required this.content,
    required this.createdAt,
    this.isImageContent = false,
  });

  /// Json data from server turns into model data
  static Message fromMap(Map<String, dynamic> data) {
    return Message(
      fromId: data["fromId"],
      content: data["content"],
      isImageContent: data["isImageContent"],
      createdAt: data["createdAt"],
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "fromId": this.fromId,
      "content": this.content,
      "isImageContent": this.isImageContent,
      "createdAt": this.createdAt,
    };
  }

  /// Clone and update a product
  Message cloneWith({
    fromId,
    content,
    isImageContent,
    createdAt,
  }) {
    return Message(
      fromId: fromId ?? this.fromId,
      content: content ?? this.content,
      isImageContent: isImageContent ?? this.isImageContent,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
