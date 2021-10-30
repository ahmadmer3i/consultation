import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/models/scheduled_data.dart';
import 'package:consultation/provider/provider_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleInitialState());

  static ScheduleCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var userId = "";

  List<ProviderData> providers = [];

  List<ScheduledData> scheduledData = [];
  List<ScheduledData> scheduledChatData = [];

  getScheduleData({required String topic}) {
    _firebase
        .collection("provider")
        .where("scheduled", isEqualTo: true)
        .where("topics", arrayContains: topic)
        .get()
        .then((value) {
      providers = [];
      for (var doc in value.docs) {
        providers.add(ProviderData.fromJson(doc.data()));
      }
      emit(ScheduleProviderDataSuccessState());
    }).catchError((err) => print(err));
  }

  void getScheduledDataProvider() {
    _firebase
        .collection("scheduled")
        .where("providerId", isEqualTo: _auth.currentUser!.uid)
        .where("isApproved", isEqualTo: false)
        .snapshots()
        .listen(
      (event) {
        scheduledData = [];
        for (var data in event.docs) {
          scheduledData.add(
            ScheduledData.fromDatabase(
              data.data(),
            ),
          );
        }
      },
    );
    emit(ScheduledProviderDataGetSucceedState());
  }

  void setApproved(
    context, {
    required String providerId,
    required String seekerId,
    required String scheduledId,
  }) {
    _firebase.collection("scheduled").doc(scheduledId).set(
      {
        "isApproved": true,
        "isOpened": true,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ProviderChat(),
        ),
      ),
    );
  }

  void getChat({required String userId}) {
    _firebase
        .collection("scheduled")
        .where("isApproved", isEqualTo: true)
        .where(userId, isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((event) {
      scheduledChatData = [];
      for (var doc in event.docs) {
        scheduledChatData.add(
          ScheduledData.fromDatabase(
            doc.data(),
          ),
        );
      }
    });
    emit(ScheduledGetChatSuccessState());
  }

  String getUserId() {
    return _auth.currentUser!.uid;
  }
}
