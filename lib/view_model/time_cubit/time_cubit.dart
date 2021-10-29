import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/seeker/dashboard_seeker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());
  static TimeCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  DateTime selectedDay = DateTime.now();
  DateTime reservedDay = DateTime.now();
  String consult = "";
  bool isEventDate = false;

  var id = Uuid().v1();
  var topic = "";

  var providerId = "";

  List<String> timeIntervals = [];
  List<String> timeIntervalsSeeker = [];
  List<DateTime> markedDate = [];
  List<DateTime> markedDateSeeker = [];
  List<String> timeAvailable = [];
  List<String> timeAvailableSeeker = [];
  List<DateTime> eventsDates = [];

  List<bool> selectedTime = [];
  List<String> reservedTimes = [];

  void getTimeIntervals() async {
    _firebase
        .collection(providerCollection)
        .doc(_auth.currentUser!.uid)
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
        timeIntervalsSeeker = [];
        for (var doc in event.docs) {
          timeIntervalsSeeker.add(doc.id);
        }
        emit(TimeGetDataSeekerSuccess());

        markedDateSeeker = [];
        for (var date in timeIntervalsSeeker) {
          markedDateSeeker.add(
            DateTime.parse(date),
          );
        }
        emit(TimeGetDateCalenderSeekerSuccess());
      },
    );
  }

  getProviderId({required currentProviderId}) {
    currentProviderId = providerId;
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

  void getAvailableTimeSeeker(DateTime currentDate) {
    timeAvailableSeeker = [];
    for (var date in markedDateSeeker) {
      if (currentDate.day == date.day &&
          currentDate.month == date.month &&
          currentDate.year == date.year) {
        timeAvailableSeeker.add(DateFormat.jm().format(date));
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
    timeAvailableSeeker = [];
  }

  void getSelectedTime() {
    selectedTime = [];
    for (var _ in timeAvailableSeeker) {
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
      reservedTimes.add(timeAvailableSeeker[index]);
      emit(TimeSetReservedTimeSuccess());
    } else {
      reservedTimes.remove(timeAvailableSeeker[index]);
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

  void setSchedule(
    context, {
    required DateTime selectedDay,
    required selectedTimes,
    required double payment,
    required providerId,
  }) {
    _firebase.collection("scheduled").doc(id).set({
      "scheduledDate": selectedDay,
      "scheduledTime": selectedTimes,
      "providerId": providerId,
      "payment": payment,
      "scheduledId": id,
      "seekerId": _auth.currentUser!.uid,
      "scheduledDetails": consult,
      "topic": topic,
      "isApproved": false,
      "isOpened": false,
    }, SetOptions(merge: true)).then(
      (value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardSeeker(
              username: currentUsername,
            ),
          ),
        );
      },
    );
    id = const Uuid().v1();
    emit(TimeSeekerSetSuccess());
  }

  setEvents(DateTime dateTime) {
    eventsDates = markedDateSeeker.map<DateTime>((e) => e).toList();

    isEventDate = eventsDates.any((DateTime d) =>
        dateTime.year == d.year &&
        dateTime.month == d.month &&
        d.day == dateTime.day);
  }

  setTopic({required String scheduledTopic}) {
    topic = scheduledTopic;
  }
}
