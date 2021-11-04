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
  bool isClosed = false;

  final searchController = TextEditingController();

  List<ProviderData> providers = [];

  List<ScheduledData> scheduledData = [];
  List<ScheduledData> scheduledChatData = [];
  List<ScheduledData> scheduledChatDataEnded = [];
  List<ProviderData> searchResult = [];
  bool isSearchEmpty = true;

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
        .where("isOpened", isEqualTo: true)
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

  void checkSearch() {
    if (searchController.text.length > 2) {
      isSearchEmpty = false;
      emit(ScheduleSearchEmptyState());
      searchResult = [];
      for (var provider in providers) {
        if (provider.name!.contains(searchController.text)) {
          searchResult.add(provider);
        }
      }
      emit((ScheduledSearchState()));
    } else {
      isSearchEmpty = true;
      emit(ScheduleSearchEmptyState());
    }
  }

  void getChat({
    bool? isClosed,
    required String userId,
    required bool isOpened,
    required bool isApproved,
  }) {
    _firebase
        .collection("scheduled")
        .where("isOpened", isEqualTo: isOpened)
        .where("isApproved", isEqualTo: isApproved)
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

  void getChatEnded(
      {bool? closed,
      required String userId,
      required bool isOpened,
      required bool isApproved}) {
    _firebase
        .collection("scheduled")
        .where("isOpened", isEqualTo: false)
        .where("isApproved", isEqualTo: true)
        .where(userId, isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((event) {
      scheduledChatDataEnded = [];
      for (var doc in event.docs) {
        scheduledChatDataEnded.add(
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
