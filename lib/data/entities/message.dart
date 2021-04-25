import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class Message extends Equatable {
  final String id;
  final String senderId;
  final Timestamp createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.createdAt,
  });

  /// Json data from server turns into model data
  factory Message.fromMap(Map<String, dynamic> data) {
    final int type = data['type'];
    Message message;
    switch (type) {
      case 0:
        message = TextMessage.fromMap(data);
        break;
      case 1:
        message = ImageMessage.fromMap(data);
        break;
      default:
        message = TextMessage.fromMap(data);
    }
    return message;
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => [id, senderId, createdAt];
}

/// Message type: Text
class TextMessage extends Message {
  final String text;

  TextMessage({
    required this.text,
    required String id,
    required String senderId,
    required Timestamp createdAt,
  }) : super(id: id, senderId: senderId, createdAt: createdAt);

  factory TextMessage.fromMap(Map<String, dynamic> data) {
    return TextMessage(
      id: data['id'] ?? "",
      senderId: data['senderId'] ?? "",
      text: data['text'] ?? "",
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text,
      'createdAt': createdAt,
      'type': 0,
    };
  }

  List<Object?> get props => [text, id, senderId, createdAt];
}

/// Message type: Image
class ImageMessage extends Message {
  final String? text;
  final List<dynamic> images;

  ImageMessage({
    this.text,
    required this.images,
    required String id,
    required String senderId,
    required Timestamp createdAt,
  }) : super(id: id, senderId: senderId, createdAt: createdAt);

  factory ImageMessage.fromMap(Map<String, dynamic> data) {
    return ImageMessage(
      id: data['id'] ?? "",
      senderId: data['senderId'] ?? "",
      text: data['text'] ?? "",
      images: data['images'] ?? [],
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'text': text ?? "",
      'images': images,
      'createdAt': createdAt,
      'type': 1,
    };
  }

  List<Object?> get props => [text, images, id, senderId, createdAt];
}
