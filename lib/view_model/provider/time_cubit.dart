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

  List<String> timeIntervals = [];
  List<DateTime> markedDate = [];

  getTimeIntervals() async {
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

  List<String> timeAvailable = [];
  getAvailableTime(DateTime currentDate) {
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
}
