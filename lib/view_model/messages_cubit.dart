import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/message_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  void sendChat({
    required String consultId,
    required String message,
    required Timestamp dateTime,
    required String senderId,
    required String receiverId,
    required messageId,
  }) async {
    MessageData messageData = MessageData(
      message: message,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: senderId,
    );
    await FirebaseFirestore.instance
        .collection("consults")
        .doc(consultId)
        .collection("chat")
        .doc(messageId)
        .collection("messages")
        .add(messageData.toMap());
    emit(MessagesSentSuccessState());
  }

  List<MessageData> messages = [];
  void getMessages({required String consultId, required String messageId}) {
    FirebaseFirestore.instance
        .collection("consults")
        .doc(consultId)
        .collection("chat")
        .doc(messageId)
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      for (var e in event.docs) {
        messages.add(MessageData(
            message: e.data()["message"],
            dateTime: e.data()["date"],
            receiverId: e.data()["receiverId"],
            senderId: e.data()['senderId']));
      }
      if (scroll.hasClients) {
        scroll.animateTo(
          0,
          duration: const Duration(milliseconds: 10),
          curve: Curves.ease,
        );
      }
      emit(MessagesGetSuccessState());
    });
  }

  var scroll = ScrollController();
}
