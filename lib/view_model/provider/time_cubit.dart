import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());
  static TimeCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  DateTime selectedDay = DateTime.now();
  DateTime reservedDay = DateTime.now();
  String consult = "";

  List<String> timeIntervals = [];
  List<DateTime> markedDate = [];
  List<String> timeAvailable = [];

  List<bool> selectedTime = [];
  List<String> reservedTimes = [];

  void getTimeIntervals({String? providerId}) async {
    _firebase
        .collection(providerCollection)
        .doc(providerId ?? _auth.currentUser!.uid)
        .collection("availableTime")
        .snapshots()
        .listen(
      (event) {
        timeIntervals = [];
        for (var doc in event.docs) {
          timeIntervals.add(doc.id);
        }
        emit(TimeGetDataSuccess());

        markedDate = [];
        for (var date in timeIntervals) {
          markedDate.add(
            DateTime.parse(date),
          );
        }
        emit(TimeGetDateCalenderSuccess());
      },
    );
  }

  void getTimeIntervalsSeeker({required String providerId}) async {
    _firebase
        .collection(providerCollection)
        .doc(providerId)
        .collection("availableTime")
        .snapshots()
        .listen(
      (event) {
        timeIntervals = [];
        for (var doc in event.docs) {
          timeIntervals.add(doc.id);
        }
        emit(TimeGetDataSeekerSuccess());

        markedDate = [];
        for (var date in timeIntervals) {
          markedDate.add(
            DateTime.parse(date),
          );
        }
        emit(TimeGetDateCalenderSeekerSuccess());
      },
    );
  }

  void getAvailableTime(DateTime currentDate) {
    timeAvailable = [];
    for (var date in markedDate) {
      if (currentDate.day == date.day &&
          currentDate.month == date.month &&
          currentDate.year == date.year) {
        timeAvailable.add(DateFormat.jm().format(date));
      }
    }
    emit(TimeAvailableTimeGetSuccess());
  }

  void getDate(DateTime date) {
    if (date == DateTime.now().add(const Duration(days: 1))) {
      return;
    }
    selectedDay = date;
    emit(TimeChangeSelectedDate());
  }

  void resetAvailableTimeSeeker() {
    timeAvailable = [];
  }

  void getSelectedTime() {
    selectedTime = [];
    for (var _ in timeAvailable) {
      selectedTime.add(false);
    }
    emit(TimeGetSelectedTimeSeekerSuccess());
  }

  void toggleSelectedTime({required int index}) {
    selectedTime[index] = !selectedTime[index];
    emit(TimeSelectedTimeToggleSeekerSuccess());
  }

  void setReservedTime({required int index}) {
    if (selectedTime[index]) {
      reservedTimes.add(timeAvailable[index]);
      emit(TimeSetReservedTimeSuccess());
    } else {
      reservedTimes.remove(timeAvailable[index]);
      emit(TimeRemoveReservedTimeSuccess());
    }
  }

  void setReservedDay({required DateTime day}) {
    reservedDay = day;
    emit(TimeSetReservedDaySuccess());
  }

  void setConsult({required String seekerConsult}) {
    consult = seekerConsult;
    print(consult);
  }

  void resetReservedTimes() {
    reservedTimes = [];
    emit(TimeResetReservedDaySuccess());
  }

  void setSchedule({
    required DateTime selectedDay,
    required selectedTimes,
    required double payment,
    required providerId,
  }) {
    _firebase.collection("scheduled").doc(providerId).set({
      "scheduleDate": selectedDay,
      "shceduleTime": selectedTimes,
      "providerId": providerId,
      "payment": payment,
    }, SetOptions(merge: true));
  }
}
