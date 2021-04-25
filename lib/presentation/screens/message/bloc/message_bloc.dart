import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/entities/entites.dart';
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
  List<Message> _allMessages = [];
  bool _hasReachedMax = false;

  MessageBloc() : super(DisplayMessages.loading());

  /// Debounce events
  @override
  Stream<Transition<MessageEvent, MessageState>> transformEvents(
      Stream<MessageEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is LoadMessages)
        .debounceTime(Duration(milliseconds: 500));
    var nonDebounceStream = events.where((event) => event is! LoadMessages);
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapLoadMessagesToState(event);
    } else if (event is SendTextMessage) {
      yield* _mapSendTextMessageToState(event);
    } else if (event is SendImageMessage) {
      yield* _mapSendImageMessageToState(event);
    } else if (event is RemoveMessage) {
      yield* _mapRemoveMessageToState(event);
    }
  }

  Stream<MessageState> _mapLoadMessagesToState(LoadMessages event) async* {
    if (_hasReachedMax) {
      return;
    }
    try {
      List<Message> messages = [];

      // Get messages
      if (event.isTheFirstTime) {
        _loggedFirebaseUser = _authRepository.loggedFirebaseUser;
        messages = await _messageRepository.getMessages(
          uid: _loggedFirebaseUser.uid,
          messagesLimit: _messagesLimit,
          isTheFirstTime: true,
        );
      } else {
        messages = await _messageRepository.getMessages(
          uid: _loggedFirebaseUser.uid,
          messagesLimit: _messagesLimit,
          isTheFirstTime: false,
        );
      }

      _hasReachedMax = messages.length < _messagesLimit;
      _allMessages = List<Message>.of(_allMessages)..addAll(messages);

      yield DisplayMessages.data(
        messages: _allMessages,
        hasReachedMax: _hasReachedMax,
      );
    } catch (e) {
      yield DisplayMessages.error(e.toString());
    }
  }

  Stream<MessageState> _mapSendTextMessageToState(
    SendTextMessage event,
  ) async* {
    try {
      // Create new text message object
      var newMessage = TextMessage(
        text: event.text,
        id: Uuid().v1(),
        senderId: _loggedFirebaseUser.uid,
        createdAt: Timestamp.now(),
      );

      await _messageRepository.addMessage(
        _loggedFirebaseUser.uid,
        newMessage,
      );
      _messagesUpdated();
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
      var newMessage = ImageMessage(
        images: imageUrls,
        text: event.text,
        id: Uuid().v1(),
        senderId: _loggedFirebaseUser.uid,
        createdAt: Timestamp.now(),
      );

      await _messageRepository.addMessage(
        _loggedFirebaseUser.uid,
        newMessage,
      );
      _messagesUpdated();
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
      _messagesUpdated();
    } catch (e) {
      print(e);
    }
  }

  void _messagesUpdated() async {
    if (_allMessages.isEmpty ||
        _allMessages[0]
                .createdAt
                .toDate()
                .add(Duration(days: 1))
                .compareTo(DateTime.now()) <
            1) {
      await _messageRepository.addMessage(
        _loggedFirebaseUser.uid,
        automaticMessage,
      );
    }
    _allMessages = [];
    _hasReachedMax = false;
    add(LoadMessages(true));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

Message automaticMessage = TextMessage(
  id: Uuid().v1(),
  senderId: "admin",
  text: "We will reply to your message as soon as possible",
  createdAt: Timestamp.now(),
);
