import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered load messages
class LoadMessages extends MessageEvent {}

/// Triggered load more messages
class LoadPreviousMessages extends MessageEvent {
  final MessageModel lastMessage;

  LoadPreviousMessages(this.lastMessage);

  @override
  List<Object> get props => [lastMessage];
}

/// When messages stream has new data
class MessagesUpdated extends MessageEvent {
  final List<MessageModel> messages;

  MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}

/// Triggered to send a text message
class SendTextMessage extends MessageEvent {
  final String text;

  SendTextMessage({required this.text});

  @override
  List<Object> get props => [text];
}

/// Triggered to send a image message
class SendImageMessage extends MessageEvent {
  final String? text;
  final List<Asset> images;

  SendImageMessage({this.text, required this.images});

  @override
  List<Object> get props => [images];
}

/// Triggered to remove a message
class RemoveMessage extends MessageEvent {
  final MessageModel message;

  RemoveMessage(this.message);

  @override
  List<Object> get props => [message];
}
