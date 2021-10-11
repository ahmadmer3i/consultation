part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesSentSuccessState extends MessagesState {}

class MessagesGetSuccessState extends MessagesState {}

class MessageRatingSuccessState extends MessagesState {}

class MessageClosingSuccessState extends MessagesState {}

class MessageEndingSuccessState extends MessagesState {}

class MessageResetClosingSuccessState extends MessagesState {}

class MessageSetRatingSuccessState extends MessagesState {}

class MessageResetRatingSuccessState extends MessagesState {}
