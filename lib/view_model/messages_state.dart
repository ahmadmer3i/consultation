part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesSentSuccessState extends MessagesState {}

class MessagesGetSuccessState extends MessagesState {}
