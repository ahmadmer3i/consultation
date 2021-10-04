// ignore_for_file: prefer_const_constructors

import 'package:consultation/Seeker/seeker_chat_open.dart';
import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class ProviderChat extends StatefulWidget {
  const ProviderChat({Key? key, this.tabIndex = 0}) : super(key: key);
  final int? tabIndex;
  @override
  _ProviderChatState createState() => _ProviderChatState();
}

class _ProviderChatState extends State<ProviderChat>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
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
                text: "انتظار",
              ),
              Tab(
                text: "منتھیۃ",
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
                            builder: (context) => SeekerChatOpen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFE8D6)),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "خالد عبدالله",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ))
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: const [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xff6B705C),
                                ),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                )
                              ],
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
                            builder: (context) => SeekerChatOpen(
                                  isClosed: true,
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFE8D6)),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "خالد عبدالله",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ))
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: const [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xff6B705C),
                                ),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(
        selectedIndex: 2,
      ),
    );
  }
}
