import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/message_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  void sendChat({
    required String collectionName,
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
        .collection(collectionName)
        .doc(consultId)
        .collection("chat")
        .doc(messageId)
        .collection("messages")
        .add(messageData.toMap());
    emit(MessagesSentSuccessState());
  }

  List<MessageData> messages = [];
  void getMessages(
      {required collectionName,
      required String consultId,
      required String messageId}) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(consultId)
        .collection("chat")
        .doc(messageId)
        .collection("messages")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      for (var e in event.docs) {
        messages.add(
          MessageData(
            message: e.data()["message"],
            dateTime: e.data()["date"],
            receiverId: e.data()["receiverId"],
            senderId: e.data()['senderId'],
          ),
        );
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
  var isLoading = false;
  var isClosing = false;

  void calculateRating({required providerId}) async {
    var counter = 0;
    var ratings = 0.0;
    isLoading = true;
    await FirebaseFirestore.instance
        .collection(providerCollection)
        .doc(providerId)
        .get()
        .then(
          (value) => FirebaseFirestore.instance
              .collection(providerCollection)
              .doc(providerId)
              .collection("ratings")
              .get()
              .then(
            (value) async {
              if (value.docs.isNotEmpty) {
                for (var v in value.docs) {
                  counter++;
                  ratings += double.parse(
                    v.data()["rating"].toString(),
                  );
                }
                ratings /= counter;
                await FirebaseFirestore.instance
                    .collection(providerCollection)
                    .doc(providerId)
                    .update(
                  {"rate": ratings},
                );
                isLoading = false;
                emit(MessageRatingSuccessState());
              }
            },
          ),
        );
  }

  void setIsClosing() {
    isClosing = true;
    emit(MessageClosingSuccessState());
  }

  void endChat({required consultId, providerId}) {
    FirebaseFirestore.instance
        .collection("consults")
        .doc(consultId)
        .update({"status": "ended", "isActive": false})
        .then((value) => isClosing == false)
        .then((value) async {
          List<ProviderConsult> items = [];
          int index;
          var collection = FirebaseFirestore.instance.collection("consults");
          var snapshot = await collection.doc(consultId).get();
          for (var e in snapshot.data()!["providers"]) {
            items.add(ProviderConsult.fromDatabase(e));
          }
          index =
              items.indexWhere((element) => element.consultId == providerId);
          items[index].status = "منتهية";
          List<Map<String, dynamic>> updatedItems = [];
          for (var element in items) {
            updatedItems.add(element.toDatabase());
          }
          FirebaseFirestore.instance.collection("consults").doc(consultId).set(
              {"providers": updatedItems},
              SetOptions(
                  merge: true)).onError((error, stackTrace) => print(error));
        });
    emit(MessageEndingSuccessState());
  }

  void resetIsClosing() {
    isClosing = false;
    emit(MessageResetClosingSuccessState());
  }

  double rating = 0.0;
  void setRating(double rate) {
    rating = rate;
    emit(MessageSetRatingSuccessState());
  }

  void resetRating() {
    rating = 0;
    emit(MessageResetRatingSuccessState());
  }
}
