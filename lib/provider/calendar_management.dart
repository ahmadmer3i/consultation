// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:consultation/Provider/add_new_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

import '../Components.dart';

class CalendarManagement extends StatefulWidget {
  const CalendarManagement({Key? key}) : super(key: key);

  @override
  _CalendarManagementState createState() => _CalendarManagementState();
}

class _CalendarManagementState extends State<CalendarManagement> {
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
  int selectedIndex = 0;
  DateTime? _selectedDate;
  // DateTime _currentDate = DateTime.now();
  // DateTime _currentDate2 = DateTime.now();
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
        setState(() {
          _selectedDate = day;
        });
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
        // ignore: unnecessary_this
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffCB997E),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNewSlot()));
        },
        child: Icon(Icons.add),
      ),
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  "الأوقات المتاحة",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Color(0xffCB997E)),
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Color(0xffCB997E),
                    height: 70,
                    child: ListView.builder(
                        itemCount: times.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Color(0xff6B705C)
                                    : Color(0xffFAFAFA),
                                border: Border.all(
                                    color: selectedIndex == index
                                        ? Color(0xffFAFAFA)
                                        : Color(0xff6B705C),
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text(
                                times.elementAt(index),
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Color(0xffFAFAFA)
                                        : Color(0xff6B705C),
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          );
                        }),
                  ),
                  Container(
                      height: 400,
                      color: Color(0xffFFE8D6),
                      child: _calendarCarouselNoHeader),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(),
    );
  }
}
