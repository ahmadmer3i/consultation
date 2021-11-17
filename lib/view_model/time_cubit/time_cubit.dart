import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/payemnt_data.dart';
import 'package:consultation/tools/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  var id = const Uuid().v1();
  var topic = "";

  PaymentData? paymentData;

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
  }

  void resetReservedTimes() {
    reservedTimes = [];
    emit(TimeResetReservedDaySuccess());
  }

  void setSchedule(
    context, {
    required GlobalKey<FormState> formKey,
    required DateTime selectedDay,
    required selectedTimes,
    required double payment,
    required providerId,
  }) {
    if (formKey.currentState!.validate()) {
      _firebase.collection("scheduled").doc(id).set({
        "scheduledDate": selectedDay,
        "scheduledTime": selectedTimes,
        "providerId": providerId,
        "scheduledId": id,
        "seekerId": _auth.currentUser!.uid,
        "scheduledDetails": consult,
        "topic": topic,
        "isApproved": false,
        "isOpened": true,
      }, SetOptions(merge: true)).then(
        (value) {
          for (var selectedTime in selectedTimes) {
            var day = (DateFormat.jm().parse(selectedTime));
            var time = DateTime(selectedDay.year, selectedDay.month,
                selectedDay.day, day.hour, day.minute);
            _firebase
                .collection(providerCollection)
                .doc(providerId)
                .collection("availableTime")
                .doc("$time")
                .delete();
          }
          var paymentDate = date.split("/");
          DioHelper.dioPost(
            context,
            name: name,
            amount: payment,
            month: paymentDate[0],
            year: paymentDate[1],
            cvv: cvv,
            creditCard: creditCard,
          ).then(
            (value) {
              if (value.statusCode == 201) {
                Navigator.pop(context);
                showBottomSheet(
                  context: context,
                  builder: (context) => WebView(
                    initialUrl: value.data["source"]["transaction_url"],
                    onPageFinished: (url) {
                      print(url);
                      if (url.contains(value.data["callback_url"])) {
                        if (url.contains("failed")) {
                          Navigator.pop(context);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("فشل عملية الدفع"),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("إلغاء"))
                                  ],
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                        paymentData = PaymentData.fromJson(value.data);

                        Navigator.pop(context);
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("تم الدفع بنجاح"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _firebase
                                          .collection("scheduled")
                                          .doc(id)
                                          .set(
                                            paymentData!.toMap(),
                                            SetOptions(merge: true),
                                          )
                                          .then((value) {
                                        id = const Uuid().v1();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardSeeker(
                                              username: currentUsername,
                                            ),
                                          ),
                                          (route) => false,
                                        );
                                      });
                                    },
                                    child: const Text("إلغاء"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            },
          );
        },
      );
      emit(TimeSeekerSetSuccess());
    }
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
