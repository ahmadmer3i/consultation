// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/provider/provider_chat_open.dart';
import 'package:consultation/view_model/provider/get_chat_data_provider.dart';
import 'package:consultation/view_model/provider/get_seeker_offer.dart';
import 'package:consultation/view_model/schedule_cubit/schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: MyAppBar(
        autoLeading: false,
      ),
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
            ),
          ),
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
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<List<ConsultData>>(
                        stream: getChatDataProvider(status: "active"),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, idx) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProviderChatOpen(
                                                  providerId: snapshot
                                                      .data![index].providerId!,
                                                  seekerId:
                                                      snapshot.data![index].uid,
                                                  consultId: snapshot
                                                      .data![index].consultId),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffFFE8D6)),
                                      padding: EdgeInsets.all(10),
                                      child: FutureBuilder(
                                        future: getSeekerOffer(
                                            id: snapshot.data![index].uid),
                                        builder: (context,
                                            AsyncSnapshot<SeekerData>
                                                seekerSnapshot) {
                                          if (seekerSnapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        "${seekerSnapshot.data?.name}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: const [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Color(0xff6B705C),
                                                    ),
                                                    Text(
                                                      "10",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      Builder(builder: (context) {
                        ScheduleCubit.get(context).getChat();
                        return BlocConsumer<ScheduleCubit, ScheduleState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            var cubit = ScheduleCubit.get(context);
                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProviderChatOpen(
                                            providerId: cubit
                                                .scheduledChatData[index]
                                                .providerId!,
                                            seekerId: cubit
                                                .scheduledChatData[index]
                                                .seekerId!,
                                            consultId: cubit
                                                .scheduledChatData[index]
                                                .scheduledId!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffFFE8D6)),
                                      padding: EdgeInsets.all(10),
                                      child: FutureBuilder(
                                        future: getSeekerOffer(
                                          id: cubit.scheduledChatData[index]
                                              .seekerId!,
                                        ),
                                        builder: (context,
                                            AsyncSnapshot<SeekerData>
                                                seekerSnapshot) {
                                          if (seekerSnapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        "${seekerSnapshot.data?.name}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: const [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Color(0xff6B705C),
                                                    ),
                                                    Text(
                                                      "10",
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                              itemCount: cubit.scheduledChatData.length,
                            );
                          },
                        );
                      })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: StreamBuilder<List<ConsultData>>(
                    stream: getChatDataProvider(status: "ended"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return ListView.separated(
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProviderChatOpen(
                                      isClosed: true,
                                      seekerId: snapshot.data![index].uid,
                                      providerId:
                                          snapshot.data![index].providerId!,
                                      consultId:
                                          snapshot.data![index].consultId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffFFE8D6)),
                                padding: EdgeInsets.all(10),
                                child: FutureBuilder(
                                  future: getSeekerOffer(
                                      id: snapshot.data![index].uid),
                                  builder: (context,
                                      AsyncSnapshot<SeekerData>
                                          seekerSnapshot) {
                                    if (seekerSnapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  "${seekerSnapshot.data?.name}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: const [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Color(0xff6B705C),
                                              ),
                                              Text(
                                                "10",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: MyProviderBottomNavigationBar(
        selectedIndex: 2,
      ),
    );
  }
}
