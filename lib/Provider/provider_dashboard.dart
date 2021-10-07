// ignore_for_file: prefer_const_constructors

import 'package:consultation/Provider/instant_consultation_detail.dart';
import 'package:consultation/Provider/scheduled_consultation_detail.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:consultation/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({Key? key, this.tabIndex = 0}) : super(key: key);
  final int? tabIndex;
  @override
  _ProviderDashboardState createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.animateTo(widget.tabIndex!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "دردشة",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Color(0xffCB997E)),
              )),
          TabBar(
            labelColor: Color(0xff696E5A),
            unselectedLabelColor: Color(0xffA9A890),
            controller: tabController,
            indicatorWeight: 4,
            tabs: const [
              Tab(
                text: "الاستشارات فورية",
              ),
              Tab(
                text: "الاستشارات المجدولة",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              Container(
                margin: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InstantConsultationDetail()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFE8D6)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SeekerProfile()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                "خالد عبدالله",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {},
                                      ))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "تصميم غرافيك",
                                      style: TextStyle(
                                          color: Color(0xffCB997E),
                                          fontWeight: FontWeight.bold),
                                    )),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "تم إرسال العرض",
                                      style:
                                          TextStyle(color: Color(0xff6B705C)),
                                    )),
                              ],
                            ),
                            Text(
                              "خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
                              style: TextStyle(height: 1.5),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ScheduledConsultationDetail()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFE8D6)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SeekerProfile()));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "خالد عبدالله",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("تصميم غرافيك")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(" 17 سبتمبر 2021"),
                                Text("6:00 - 8:00 مساء"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(
        selectedIndex: 3,
      ),
    );
  }
}
