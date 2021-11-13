import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AddNewSlot extends StatefulWidget {
  const AddNewSlot({Key? key}) : super(key: key);

  @override
  _AddNewSlotState createState() => _AddNewSlotState();
}

class _AddNewSlotState extends State<AddNewSlot> {
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  var startTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
  var endTime = TimeOfDay(hour: DateTime.now().hour + 2, minute: 0);
  var date;
  List timeIntervals = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "إضافة وقت جديد",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: const Color(0xffCB997E)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldDark(
                  textController: dateController,
                  isReadOnly: true,
                  label: "تاريخ",
                  iconButton: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        initialDate: DateTime.now(),
                      ).then(
                        (value) {
                          setState(
                            () {
                              date = value;
                              dateController.text =
                                  DateFormat.yMMMd('ar').format(value!);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: MyTextFieldDark(
                  validator: (value) {
                    if (endTime.minute - startTime.minute != 0 ||
                        endTime == startTime ||
                        timeController.text.isEmpty ||
                        startTime.hour > endTime.hour) {
                      return "يجب ان يكون عدد الساعات ساعات كاملة";
                    } else {
                      return null;
                    }
                  },
                  textController: timeController,
                  isReadOnly: true,
                  label: "الوقت",
                  iconButton: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      showTimeRangePicker(
                        snap: true,
                        ticks: 3,
                        start: startTime,
                        end: endTime,
                        interval: const Duration(hours: 1),
                        context: context,
                        // maxDuration: Duration(hours: 12, minutes: 00),
                        hideTimes: false,
                        onStartChange: (value) async {
                          startTime = value;
                          var minutes = endTime.minute - startTime.minute;
                          if (minutes != 0) {}
                        },
                        onEndChange: (value) async {
                          endTime = value;
                          var hour = endTime.hour - startTime.hour;
                          var minutes = endTime.minute - startTime.minute;
                          if (minutes != 0) {}
                        },
                        use24HourFormat: false,
                      ).then(
                        (value) {
                          setState(
                            () {
                              timeController.text = value != null
                                  ? DateFormat.jm('ar').format(
                                        DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          startTime.hour,
                                          startTime.minute,
                                        ),
                                      ) +
                                      " - " +
                                      DateFormat.jm('ar').format(
                                        DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          endTime.hour,
                                          endTime.minute,
                                        ),
                                      )
                                  : "";
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var time1 = DateTime(date!.year, date!.month, date!.day,
                      startTime.hour, startTime.minute);
                  var time2 = DateTime(date!.year, date!.month, date!.day,
                      endTime.hour, endTime.minute);
                  var counter = time1.hour;

                  timeIntervals = [];
                  if (_formKey.currentState!.validate()) {
                    while (time2.hour > counter) {
                      timeIntervals.add(
                        DateTime(date!.year, date!.month, date!.day, counter,
                            time2.minute),
                      );
                      counter++;
                    }
                    for (var i in timeIntervals) {
                      await FirebaseFirestore.instance
                          .collection("provider")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("availableTime")
                          .doc(i.toString())
                          .set({});
                    }
                    // var snapshot = await FirebaseFirestore.instance
                    //     .collection("provider")
                    //     .doc(FirebaseAuth.instance.currentUser!.uid)
                    //     .get();
                    // if (snapshot.data() != null) {
                    //   if (snapshot.data()!.containsKey("available")) {
                    //     for (var i in timeIntervals) {
                    //       if (!snapshot.data()!.containsValue(i)) {
                    //         print(snapshot.data()!.containsValue(i));
                    //
                    //       }else {
                    //         FirebaseFirestore.instance.
                    //       }
                    //     }
                    //   } else {

                    // }
                    // }
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "إضافة",
                  style: TextStyle(
                    color: Color(0xffFFE8D6),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyProviderBottomNavigationBar(),
    );
  }
}
