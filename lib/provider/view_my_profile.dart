// ignore_for_file: prefer_const_constructors

import 'package:consultation/Provider/provider_edit_profile.dart';
import 'package:consultation/components.dart';
import 'package:consultation/view_model/provider/provider_instant_cubit/instant_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ViewMyProfile extends StatefulWidget {
  final bool canProceed;
  final double ratingEditor = 0;

  const ViewMyProfile({Key? key, this.canProceed = true}) : super(key: key);

  @override
  _ViewMyProfileState createState() => _ViewMyProfileState();
}

class _ViewMyProfileState extends State<ViewMyProfile>
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = InstantCubit.get(context);
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
        this.setState(
          () {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          },
        );
      },
    );

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                        ),
                        Text(
                          InstantCubit.get(context).providerData1!.name!,
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
                                      actionsAlignment: MainAxisAlignment.start,
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "إرسال",
                                            style:
                                                TextStyle(color: Colors.white),
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
                                            )),
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
                              Text(cubit.providerData1!.rate!
                                  .toStringAsFixed(1)),
                              StarRating(
                                rating: InstantCubit.get(context)
                                    .providerData1!
                                    .rate,
                                size: 20,
                                borderColor: Color(0xff6B705C),
                                color: Color(0xff6B705C),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              InstantCubit.get(context)
                                  .providerData1!
                                  .price!
                                  .toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      height: 0.2, color: Color(0xffCB997E)),
                            ),
                            Text(
                              "ريال / ساعة",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      )),
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
                    child: TabBarView(controller: tabController, children: [
                      Column(
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
                              height: 500,
                              width: 500,
                              color: Color(0xffFFE8D6),
                              child: _calendarCarouselNoHeader),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              InstantCubit.get(context)
                                  .providerData1!
                                  .experience!,
                              // "خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
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
                                                    'https://picsum.photos/200'),
                                                resetDuration: const Duration(
                                                    milliseconds: 100),
                                                maxScale: 2.5,
                                                onZoomStart: () {
                                                  print('Start zooming');
                                                },
                                                onZoomEnd: () {
                                                  print('Stop zooming');
                                                },
                                              );
                                            });
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
                                  }),
                            )
                          ],
                        ),
                      ),
                    ])),
                widget.canProceed
                    ? Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProviderProfileEdit()));
                            },
                            child: Text(
                              "تعديل بياناتي",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            )))
                    : Container()
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
