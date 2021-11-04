// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/seeker/seeker_chat_open.dart';
import 'package:consultation/seeker/seeker_chat_open_schedule.dart';
import 'package:consultation/view_model/get_chat_data.dart';
import 'package:consultation/view_model/get_provider_data.dart';
import 'package:consultation/view_model/get_provider_offer.dart';
import 'package:consultation/view_model/messages_cubit.dart';
import 'package:consultation/view_model/schedule_cubit/schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeekerChat extends StatefulWidget {
  const SeekerChat({Key? key, this.tabIndex = 0}) : super(key: key);
  final int? tabIndex;
  @override
  _SeekerChatState createState() => _SeekerChatState();
}

class _SeekerChatState extends State<SeekerChat>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  Future<List<ProviderData>>? getProvider;
  List<ProviderData> providersList = [];
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController!.animateTo(widget.tabIndex!);
    super.initState();
    getProvider = getProviderData(providersList);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                            stream: getChatData(status: "active"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                return ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 5,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == snapshot.data!.length) {
                                      return SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          MessagesCubit.get(context)
                                              .resetIsClosing();
                                          MessagesCubit.get(context)
                                              .resetRating();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SeekerChatOpen(
                                                collectionName: "consults",
                                                seekerId:
                                                    snapshot.data![index].uid,
                                                providerId: snapshot
                                                    .data![index].providerId!,
                                                uid: snapshot.data![index].uid,
                                                consultId: snapshot
                                                    .data![index].consultId,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: FutureBuilder(
                                                      future: getProviderOffer(
                                                          id: snapshot
                                                              .data![index]
                                                              .providerId!),
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  ProviderData>
                                                              snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return Text(
                                                            "${snapshot.data?.name}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1,
                                                          );
                                                        } else {
                                                          return CircularProgressIndicator();
                                                        }
                                                      },
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
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Builder(
                            builder: (context) {
                              ScheduleCubit.get(context).getChat(
                                  isClosed: false,
                                  userId: "seekerId",
                                  isApproved: true,
                                  isOpened: true);
                              return BlocConsumer<ScheduleCubit, ScheduleState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  var cubit = ScheduleCubit.get(context);
                                  return ListView.separated(
                                    itemCount: cubit.scheduledChatData.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: GestureDetector(
                                          onTap: cubit.scheduledChatData[index]
                                                  .scheduledDate!
                                                  .toDate()
                                                  .isBefore(DateTime.now())
                                              ? () {
                                                  MessagesCubit.get(context)
                                                      .resetIsClosing();
                                                  MessagesCubit.get(context)
                                                      .resetRating();
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeekerChatOpenSchedule(
                                                        collectionName:
                                                            "scheduled",
                                                        seekerId: cubit
                                                            .scheduledChatData[
                                                                index]
                                                            .seekerId!,
                                                        providerId: cubit
                                                            .scheduledChatData[
                                                                index]
                                                            .providerId!,
                                                        uid: cubit
                                                            .scheduledChatData[
                                                                index]
                                                            .seekerId!,
                                                        consultId: cubit
                                                            .scheduledChatData[
                                                                index]
                                                            .scheduledId!,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              : () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xffFFE8D6)),
                                            padding: EdgeInsets.all(10),
                                            child: Row(
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
                                                      child: FutureBuilder(
                                                        future: getProviderOffer(
                                                            id: cubit
                                                                .scheduledChatData[
                                                                    index]
                                                                .providerId!),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                    ProviderData>
                                                                snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            return Text(
                                                              "${snapshot.data?.name}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                            );
                                                          } else {
                                                            return CircularProgressIndicator();
                                                          }
                                                        },
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
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 5,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //-------------------------------------
                    // Ended
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StreamBuilder<List<ConsultData>>(
                            stream: getChatData(status: "ended"),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                return ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 5,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == snapshot.data!.length) {
                                      return SizedBox.shrink();
                                    }
                                    return FutureBuilder(
                                      future: getProviderOffer(
                                          id: snapshot
                                              .data![index].providerId!),
                                      builder: (context,
                                          AsyncSnapshot<ProviderData>
                                              snapshotEnded) {
                                        if (snapshotEnded.connectionState ==
                                            ConnectionState.done) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeekerChatOpen(
                                                      isClosed: true,
                                                      collectionName:
                                                          "consults",
                                                      seekerId: snapshot
                                                          .data![index].uid,
                                                      providerId: snapshot
                                                          .data![index]
                                                          .providerId!,
                                                      uid: snapshot
                                                          .data![index].uid,
                                                      consultId: snapshot
                                                          .data![index]
                                                          .consultId,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xffFFE8D6),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            snapshotEnded
                                                                .data!.name!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
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
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Builder(
                            builder: (context) {
                              ScheduleCubit.get(context).getChatEnded(
                                  userId: "seekerId",
                                  isOpened: false,
                                  isApproved: true);
                              return BlocConsumer<ScheduleCubit, ScheduleState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  var cubit = ScheduleCubit.get(context);
                                  return ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        cubit.scheduledChatDataEnded.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return FutureBuilder(
                                        future: getProviderOffer(
                                            id: cubit
                                                .scheduledChatDataEnded[index]
                                                .providerId!),
                                        builder: (context,
                                            AsyncSnapshot<ProviderData>
                                                snapshotEnded) {
                                          if (snapshotEnded.connectionState ==
                                              ConnectionState.done) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SeekerChatOpenSchedule(
                                                        isClosed: true,
                                                        collectionName:
                                                            "scheduled",
                                                        seekerId: cubit
                                                            .scheduledChatDataEnded[
                                                                index]
                                                            .seekerId!,
                                                        providerId: cubit
                                                            .scheduledChatDataEnded[
                                                                index]
                                                            .providerId!,
                                                        uid: cubit
                                                            .scheduledChatDataEnded[
                                                                index]
                                                            .seekerId!,
                                                        consultId: cubit
                                                            .scheduledChatDataEnded[
                                                                index]
                                                            .scheduledId!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xffFFE8D6),
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              snapshotEnded
                                                                  .data!.name!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: const [
                                                          CircleAvatar(
                                                            radius: 10,
                                                            backgroundColor:
                                                                Color(
                                                                    0xff6B705C),
                                                          ),
                                                          Text(
                                                            "10",
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: MyBottomNavigationBar(
            selectedIndex: 3,
          ),
        );
      },
    );
  }
}
