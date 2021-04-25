import 'package:e_commerce_app/data/entities/message.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

/// Load messages event
class LoadMessages extends MessageEvent {
  final bool isTheFirstTime;

  LoadMessages(this.isTheFirstTime);

  @override
  List<Object> get props => [isTheFirstTime, DateTime.now()];
}

///
class SendTextMessage extends MessageEvent {
  final String text;

  SendTextMessage({required this.text});

  @override
  List<Object> get props => [text];
}

///
class SendImageMessage extends MessageEvent {
  final String? text;
  final List<Asset> images;

  SendImageMessage({this.text, required this.images});

  @override
  List<Object> get props => [images];
}

///
class RemoveMessage extends MessageEvent {
  final Message message;

  RemoveMessage(this.message);

  @override
  List<Object> get props => [message];
}
