import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/chat_model/chat_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatModel> messages = [];
  ChatBloc() : super(ChatInitial()) {
    on<AddNewMessageEvent>(addNewMessageEvent);
    on<AddInitialMessageEvent>(addInitialMessageEvent);
    on<ClearAllMessageEvent>(clearAllMessageEvent);
  }
  Future<void> addNewMessageEvent(
      AddNewMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(event.chatModel);
    debugPrint('Message bloc: ${messages.length}');
    if (messages.isNotEmpty) {
      emit(ChatAddedState(messageList: messages));
    }
  }

  Future<void> addInitialMessageEvent(
      AddInitialMessageEvent event, Emitter<ChatState> emit) async {
    if (messages.isEmpty || messages == event.messageList) {
      messages.addAll(event.messageList);
      debugPrint('Message using bloc: ${messages.length}');
    }
    messages.sort((a, b) => a.sendAt.compareTo(b.sendAt));
    emit(ChatAddedState(messageList: messages));
  }

  Future<void> clearAllMessageEvent(
      ClearAllMessageEvent event, Emitter<ChatState> emit) async {
    messages.clear();
    emit(ChatEmptyState());
  }
}
