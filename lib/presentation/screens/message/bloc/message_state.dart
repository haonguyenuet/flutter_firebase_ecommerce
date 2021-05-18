import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

//////////////////
class DisplayMessages extends MessageState {
  final List<MessageModel>? messages;
  final bool hasReachedMax;
  final bool isPrevious;
  final String msg;
  final bool loading;

  DisplayMessages({
    required this.messages,
    required this.hasReachedMax,
    required this.isPrevious,
    required this.msg,
    required this.loading,
  });

  factory DisplayMessages.loading() {
    return DisplayMessages(
      msg: "",
      messages: null,
      hasReachedMax: false,
      isPrevious: false,
      loading: true,
    );
  }

  factory DisplayMessages.data({
    required List<MessageModel> messages,
    required bool hasReachedMax,
    required bool isPrevious,
  }) {
    return DisplayMessages(
      msg: "",
      messages: messages,
      hasReachedMax: hasReachedMax,
      isPrevious: isPrevious,
      loading: false,
    );
  }

  factory DisplayMessages.error(String msg) {
    return DisplayMessages(
      msg: msg,
      messages: null,
      hasReachedMax: false,
      isPrevious: false,
      loading: false,
    );
  }

  @override
  List<Object?> get props => [messages, hasReachedMax, loading, msg];
}
