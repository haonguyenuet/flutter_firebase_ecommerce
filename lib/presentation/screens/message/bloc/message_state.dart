import 'package:e_commerce_app/data/entities/entites.dart';
import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

///
// class MessagesLoading extends MessageState {}

// ///
// class MessagesLoaded extends MessageState {
//   final List<Message> messages;
//   final bool hasReachedMax;
//   MessagesLoaded({
//     required this.messages,
//     required this.hasReachedMax,
//   });

//   @override
//   String toString() {
//     return "MessagesLoaded{Number of messages: ${this.messages.length}, hasReachedMax: $hasReachedMax}";
//   }

//   @override
//   List<Object> get props => [messages, hasReachedMax];
// }

// ///
// class MessagesLoadFailure extends MessageState {
//   final String error;

//   MessagesLoadFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

//////////////////
class DisplayMessages extends MessageState {
  final List<Message>? messages;
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
    required List<Message> messages,
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
