import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:meta/meta.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());
  static TimeCubit get(context) => BlocProvider.of(context);

  final _firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<String> timeIntervals = [];

  getTimeIntervals() async {
    var docs = await _firebase
        .collection(providerCollection)
        .doc(_auth.currentUser!.uid)
        .collection("availableTime")
        .get();
    timeIntervals = [];
    for (var doc in docs.docs) {
      timeIntervals.add(doc.id);
    }
    emit(TimeGetDataSuccess());
    print('test');
    for (var date in timeIntervals) {
      print(DateTime.parse(date));
      markedDate.add(
        MarkedDate(
          color: const Color(0xff6B705C),
          date: DateTime.parse(date),
        ),
      );
    }
    print(markedDate.length);
    for (var date in markedDate) {
      print(date.date);
    }
    emit(TimeGetDateCalenderSuccess());
  }

  List<MarkedDate> markedDate = [];
}
