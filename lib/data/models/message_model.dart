import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class MessageModel extends Equatable {
  final String id;
  final String senderId;
  final Timestamp createdAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.createdAt,
  });

  /// Json data from server turns into model data
  factory MessageModel.fromMap(Map<String, dynamic> data) {
    final int type = data['type'];
    MessageModel message;
    switch (type) {
      case 0:
        message = TextMessageModel.fromMap(data);
        break;
      case 1:
        message = ImageMessageModel.fromMap(data);
        break;
      default:
        message = TextMessageModel.fromMap(data);
    }
    return message;
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => [id, senderId, createdAt];
}

/// MessageModel type: Text
class TextMessageModel extends MessageModel {
  final String text;

  TextMessageModel({
    required this.text,
    required String id,
    required String senderId,
    required Timestamp createdAt,
  }) : super(id: id, senderId: senderId, createdAt: createdAt);

  factory TextMessageModel.fromMap(Map<String, dynamic> data) {
    return TextMessageModel(
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

/// MessageModel type: Image
class ImageMessageModel extends MessageModel {
  final String? text;
  final List<dynamic> images;

  ImageMessageModel({
    this.text,
    required this.images,
    required String id,
    required String senderId,
    required Timestamp createdAt,
  }) : super(id: id, senderId: senderId, createdAt: createdAt);

  factory ImageMessageModel.fromMap(Map<String, dynamic> data) {
    return ImageMessageModel(
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
