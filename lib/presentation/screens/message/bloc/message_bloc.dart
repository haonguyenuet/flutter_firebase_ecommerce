import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/message/bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

const _messagesLimit = 20;

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  StorageRepository _storageRepository = AppRepository.storageRepository;
  final AuthRepository _authRepository = AppRepository.authRepository;
  final MessageRepository _messageRepository = AppRepository.messageRepository;
  late User _loggedFirebaseUser;
  bool _hasReachedMax = false;
  StreamSubscription? _messagesStreamSubs;

  MessageBloc() : super(DisplayMessages.loading());

  /// Debounce events
  @override
  Stream<Transition<MessageEvent, MessageState>> transformEvents(
      Stream<MessageEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is LoadPreviousMessages)
        .debounceTime(Duration(milliseconds: 500));
    var nonDebounceStream =
        events.where((event) => event is! LoadPreviousMessages);
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapLoadMessagesToState(event);
    } else if (event is LoadPreviousMessages) {
      yield* _mapLoadPreviousMessagesToState(event);
    } else if (event is SendTextMessage) {
      yield* _mapSendTextMessageToState(event);
    } else if (event is SendImageMessage) {
      yield* _mapSendImageMessageToState(event);
    } else if (event is RemoveMessage) {
      yield* _mapRemoveMessageToState(event);
    } else if (event is MessagesUpdated) {
      _hasReachedMax = event.messages.length < _messagesLimit;
      yield DisplayMessages.data(
        messages: event.messages,
        hasReachedMax: _hasReachedMax,
        isPrevious: false,
      );
    }
  }

  Stream<MessageState> _mapLoadMessagesToState(LoadMessages event) async* {
    try {
      _loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      _messagesStreamSubs?.cancel();
      _messagesStreamSubs = _messageRepository
          .fetchRecentMessages(
            uid: _loggedFirebaseUser.uid,
            messagesLimit: _messagesLimit,
          )
          .listen((messages) => add(MessagesUpdated(messages)));
    } catch (e) {
      yield DisplayMessages.error(e.toString());
    }
  }

  Stream<MessageState> _mapLoadPreviousMessagesToState(
    LoadPreviousMessages event,
  ) async* {
    if (_hasReachedMax) return;
    // get messages after event.lastMessage
    List<MessageModel> messages =
        await _messageRepository.fetchPreviousMessages(
      uid: _loggedFirebaseUser.uid,
      messagesLimit: _messagesLimit,
      lastMessage: event.lastMessage,
    );
    // check messages has reached max
    _hasReachedMax = messages.length < _messagesLimit;
    // yield data state
    yield DisplayMessages.data(
      messages: messages,
      hasReachedMax: _hasReachedMax,
      isPrevious: true,
    );
    try {} catch (e) {
      yield DisplayMessages.error(e.toString());
    }
  }

  Stream<MessageState> _mapSendTextMessageToState(
    SendTextMessage event,
  ) async* {
    try {
      // Create new text message object
      var newMessage = TextMessageModel(
        text: event.text,
        id: Uuid().v1(),
        senderId: _loggedFirebaseUser.uid,
        createdAt: Timestamp.now(),
      );

      var automaticReply = await _automacticReply();

      await _messageRepository.addMessage(_loggedFirebaseUser.uid, newMessage);

      if (automaticReply) {
        await _messageRepository.addMessage(
          _loggedFirebaseUser.uid,
          automaticMessage,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<MessageState> _mapSendImageMessageToState(
    SendImageMessage event,
  ) async* {
    try {
      // Get image urls from firebase storage
      List<String> imageUrls = [];
      for (int i = 0; i < event.images.length; i++) {
        ByteData byteData = await event.images[i].getByteData();
        Uint8List imageData = byteData.buffer.asUint8List();
        String imageUrl = await _storageRepository.uploadImageData(
          "users/messages/${_loggedFirebaseUser.uid}/${event.images[i].name}",
          imageData,
        );
        imageUrls.add(imageUrl);
      }
      // Create new image message object
      var newMessage = ImageMessageModel(
        images: imageUrls,
        text: event.text,
        id: Uuid().v1(),
        senderId: _loggedFirebaseUser.uid,
        createdAt: Timestamp.now(),
      );

      var automaticReply = await _automacticReply();

      await _messageRepository.addMessage(_loggedFirebaseUser.uid, newMessage);

      if (automaticReply) {
        await _messageRepository.addMessage(
          _loggedFirebaseUser.uid,
          automaticMessage,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<MessageState> _mapRemoveMessageToState(RemoveMessage event) async* {
    try {
      await _messageRepository.removeMessage(
        _loggedFirebaseUser.uid,
        event.message,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _automacticReply() async {
    var lastestMessage = await _messageRepository.getLastestMessage(
      uid: _loggedFirebaseUser.uid,
    );
    return lastestMessage == null ||
        lastestMessage.createdAt
                .toDate()
                .add(Duration(days: 1))
                .compareTo(DateTime.now()) <
            1;
  }

  @override
  Future<void> close() {
    _messagesStreamSubs?.cancel();
    return super.close();
  }
}

MessageModel automaticMessage = TextMessageModel(
  id: Uuid().v1(),
  senderId: "admin",
  text: "We will reply to your message as soon as possible",
  createdAt: Timestamp.now(),
);
