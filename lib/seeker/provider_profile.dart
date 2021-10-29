// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/time_cubit/time_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'consultation_details.dart';

class ProviderProfileSchedule extends StatefulWidget {
  final bool canProceed;
  final double ratingEditor = 0;
  final ProviderData? data;
  final String? topic;
  const ProviderProfileSchedule(
      {Key? key, this.canProceed = true, this.data, this.topic})
      : super(key: key);

  @override
  _ProviderProfileScheduleState createState() =>
      _ProviderProfileScheduleState();
}

class _ProviderProfileScheduleState extends State<ProviderProfileSchedule>
    with SingleTickerProviderStateMixin {
  List times = [
    "08:45",
    "09:15",
    "09:45",
    "10:15",
    "10:45",
    "11:15",
    "11:45",
    "12:15",
  ];
  //Map<String,bool> times=new Map<String,bool>();
  int selectedIndex = 0;
  var tabController;
  DateTime? _selectedDate;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2021, 9, 26): [
        Event(
          date: DateTime(2021, 9, 26),
        ),
      ],
    },
  );
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    TimeCubit.get(context).resetReservedTimes();
    TimeCubit.get(context).resetAvailableTimeSeeker();
    TimeCubit.get(context)
        .getTimeIntervalsSeeker(providerId: widget.data!.uid!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      locale: "ar",
      dayButtonColor: Color(0xffDDBEA9),
      daysTextStyle:
          TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
      todayButtonColor: Color(0xffA6A68E),
      todayBorderColor: Color(0xff6B705C),
      selectedDateTime: _selectedDate,
      onDayPressed: (DateTime day, List<Event> events) {
        setState(
          () {
            _selectedDate = day;
          },
        );
      },
      todayTextStyle:
          TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
      weekendTextStyle:
          TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
      weekdayTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Janna"),
      headerTextStyle: TextStyle(
          fontWeight: FontWeight.w900,
          color: Color(0xff6B705C),
          fontFamily: "janna",
          fontSize: 20),
      rightButtonIcon: Icon(
        Icons.arrow_right,
        size: 30,
        color: Color(0xff6B705C),
      ),
      leftButtonIcon: Icon(
        Icons.arrow_left,
        size: 30,
        color: Color(0xff6B705C),
      ),
      selectedDayButtonColor: Color(0xff6B705C),
      onCalendarChanged: (DateTime date) {
        setState(
          () {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          },
        );
      },
    );

    return Scaffold(
      appBar: MyAppBar(
        autoLeading: true,
      ),
      body: Builder(
        builder: (context) {
          TimeCubit.get(context)
              .getTimeIntervalsSeeker(providerId: widget.data!.uid!);
          TimeCubit.get(context).getSelectedTime();

          return BlocConsumer<TimeCubit, TimeState>(
            listener: (context, state) {
              print("state: $state");
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                              ),
                              Text(
                                "${widget.data?.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(height: 1, color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "قيم تجربتك",
                                                style: TextStyle(
                                                    color: Color(0xffCB997E)),
                                              ),
                                            ),
                                            content: RatingEditor(
                                              rating: widget.ratingEditor,
                                            ),
                                            //actionsAlignment: MainAxisAlignment.start,
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "إرسال",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.grey),
                                                onPressed: () {},
                                                child: Text(
                                                  "إلغاء",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${widget.data?.rate?.toStringAsFixed(1)}"),
                                    StarRating(
                                      rating: double.parse(widget.data!.rate!
                                          .toStringAsFixed(1)),
                                      size: 20,
                                      borderColor: Color(0xff6B705C),
                                      color: Color(0xff6B705C),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TabBar(
                          labelColor: Color(0xff696E5A),
                          unselectedLabelColor: Color(0xffA9A890),
                          controller: tabController,
                          indicatorWeight: 4,
                          tabs: const [
                            Tab(
                              text: "الاوقات المتاحة",
                            ),
                            Tab(
                              text: "معلومات الاستشاري",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 600,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    color: Color(0xffCB997E),
                                    height: 70,
                                    child: ListView.builder(
                                      itemCount: TimeCubit.get(context)
                                          .timeAvailableSeeker
                                          .length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            TimeCubit.get(context)
                                                .toggleSelectedTime(
                                                    index: index);

                                            TimeCubit.get(context)
                                                .setReservedTime(index: index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 5,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 0,
                                              horizontal: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: TimeCubit.get(context)
                                                      .selectedTime[index]
                                                  ? Color(0xff6B705C)
                                                  : Color(0xffFAFAFA),
                                              border: Border.all(
                                                color: TimeCubit.get(context)
                                                        .selectedTime[index]
                                                    ? Color(0xffFAFAFA)
                                                    : Color(0xff6B705C),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: TimeCubit.get(context)
                                                      .timeAvailableSeeker
                                                      .isNotEmpty
                                                  ? Text(
                                                      TimeCubit.get(context)
                                                              .timeAvailableSeeker[
                                                          index],
                                                      style: TextStyle(
                                                        color: TimeCubit.get(
                                                                        context)
                                                                    .selectedTime[
                                                                index]
                                                            ? Color(0xffFAFAFA)
                                                            : Color(0xff6B705C),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      color: Color(0xffFFE8D6),
                                      child: dp.DayPicker.single(
                                        selectedDate: TimeCubit.get(context)
                                            .selectedDay
                                            .add(
                                              Duration(hours: 2),
                                            ),
                                        onChanged: TimeCubit.get(context)
                                                .reservedTimes
                                                .isEmpty
                                            ? (day) {
                                                TimeCubit.get(context)
                                                    .getDate(day);
                                                TimeCubit.get(context)
                                                    .getAvailableTimeSeeker(
                                                        day);
                                                TimeCubit.get(context)
                                                    .getSelectedTime();
                                                TimeCubit.get(context)
                                                    .setReservedDay(day: day);
                                              }
                                            : (day) {
                                                TimeCubit.get(context)
                                                    .resetReservedTimes();
                                                TimeCubit.get(context)
                                                    .getDate(day);
                                                TimeCubit.get(context)
                                                    .getAvailableTimeSeeker(
                                                        day);
                                                TimeCubit.get(context)
                                                    .getSelectedTime();
                                                TimeCubit.get(context)
                                                    .setReservedDay(day: day);
                                              },
                                        eventDecorationBuilder: (date) {
                                          TimeCubit.get(context)
                                              .setEvents(date);
                                          BoxDecoration roundedBorder =
                                              BoxDecoration(
                                                  color: Color(0xff6B705C),
                                                  border: Border.all(
                                                    color: Color(0xffDDBEA9),
                                                  ),
                                                  shape: BoxShape.circle);

                                          return TimeCubit.get(context)
                                                  .isEventDate
                                              ? dp.EventDecoration(
                                                  boxDecoration: roundedBorder)
                                              : dp.EventDecoration(
                                                  boxDecoration: BoxDecoration(
                                                    color: Color(0xffDDBEA9),
                                                    shape: BoxShape.circle,
                                                  ),
                                                );
                                        },
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(
                                          Duration(days: 365),
                                        ),
                                        datePickerLayoutSettings:
                                            dp.DatePickerLayoutSettings(
                                          scrollPhysics:
                                              NeverScrollableScrollPhysics(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "${widget.data?.experience}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "الشهادات",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Color(0xffCB997E)),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return PinchZoom(
                                                    child: Image.network(
                                                      'https://picsum.photos/200',
                                                    ),
                                                    resetDuration:
                                                        const Duration(
                                                      milliseconds: 100,
                                                    ),
                                                    maxScale: 2.5,
                                                    onZoomStart: () {
                                                      // print('Start zooming');
                                                    },
                                                    onZoomEnd: () {
                                                      // print('Stop zooming');
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              child: Image.network(
                                                "https://picsum.photos/200",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TimeCubit.get(context).reservedTimes.isNotEmpty
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ConsultationDetails(
                                        providerData: widget.data!,
                                        topic: widget.topic,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "التالي",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
