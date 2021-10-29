// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui' as ui;

import 'package:consultation/Provider/instant_consultation_detail.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:consultation/components.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/provider/scheduled_consultation_detail.dart';
import 'package:consultation/view_model/get_seeker_data.dart';
import 'package:consultation/view_model/provider/provider_instant_cubit/instant_cubit.dart';
import 'package:consultation/view_model/schedule_cubit/schedule_cubit.dart';
import 'package:consultation/view_model/seeker_cubit/seeker_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({
    Key? key,
    this.tabIndex = 0,
  }) : super(key: key);
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
    return Builder(builder: (context) {
      InstantCubit.get(context).getProviderData();
      return BlocConsumer<InstantCubit, InstantState>(
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
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Color(0xffCB997E),
                        ),
                  ),
                ),
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
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      InstantCubit.get(context).consultData.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                                itemCount: InstantCubit.get(context)
                                    .consultData
                                    .length,
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                    future: getSeekerDataPerInstant(
                                        seekerId: InstantCubit.get(context)
                                            .consultData[index]
                                            .uid),
                                    builder: (
                                      context,
                                      AsyncSnapshot<SeekerData> snapshotSeeker,
                                    ) {
                                      if (snapshotSeeker.connectionState ==
                                          ConnectionState.done) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InstantConsultationDetail(
                                                  seekerData:
                                                      snapshotSeeker.data!,
                                                  consultData:
                                                      InstantCubit.get(context)
                                                          .consultData[index],
                                                  data: InstantCubit.get(
                                                          context)
                                                      .consultProvider[index],
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
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            SeekerProfile(),
                                                      ),
                                                    );
                                                  },
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
                                                              horizontal: 10,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  snapshotSeeker
                                                                      .data!
                                                                      .name!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.grey,
                                                          ),
                                                          onPressed: () => InstantCubit.get(context).deleteInstantProvider(
                                                              docId: InstantCubit.get(
                                                                      context)
                                                                  .consultData[
                                                                      index]
                                                                  .docId,
                                                              data: InstantCubit
                                                                          .get(
                                                                              context)
                                                                      .consultData[
                                                                  index],
                                                              price: InstantCubit
                                                                      .get(
                                                                          context)
                                                                  .consultProvider[
                                                                      index]
                                                                  .price!),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        InstantCubit.get(
                                                                context)
                                                            .consultData[index]
                                                            .topic,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffCB997E),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        InstantCubit.get(
                                                                context)
                                                            .consultProvider[
                                                                index]
                                                            .status!,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff6B705C),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "تاريخ الميلاد",
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshotSeeker
                                                              .data!.date!,
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "تاريخ تقديم الاستشارة",
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          " ${DateFormat.yMMMd('ar').format(InstantCubit.get(context).consultData[index].date.toDate())}",
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
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
                              )
                              // StreamBuilder<List<ConsultData>>(
                              //   stream: getInstantData,
                              //   builder: (context,
                              //       AsyncSnapshot<List<ConsultData>> snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.active) {
                              //       if (snapshot.hasData) {
                              //         return snapshot.data!.isNotEmpty
                              //             ?
                              //         ListView.separated(
                              //                 separatorBuilder: (context, index) =>
                              //                     SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 itemCount: snapshot.data!.length,
                              //                 itemBuilder: (context, index) {
                              //                   return FutureBuilder(
                              //                     future: getSeekerDataPerInstant(
                              //                         seekerId:
                              //                             snapshot.data![index].uid),
                              //                     builder: (
                              //                       context,
                              //                       AsyncSnapshot<SeekerData>
                              //                           snapshotSeeker,
                              //                     ) {
                              //                       if (snapshotSeeker
                              //                               .connectionState ==
                              //                           ConnectionState.done) {
                              //                         return GestureDetector(
                              //                           onTap: () {
                              //                             Navigator.of(context).push(
                              //                               MaterialPageRoute(
                              //                                 builder: (context) =>
                              //                                     InstantConsultationDetail(
                              //                                   seekerData:
                              //                                       snapshotSeeker
                              //                                           .data!,
                              //                                   consultData: snapshot
                              //                                       .data![index],
                              //                                   data: snapshot
                              //                                       .data![index]
                              //                                       .providers[0],
                              //                                 ),
                              //                               ),
                              //                             );
                              //                           },
                              //                           child: Container(
                              //                             decoration: BoxDecoration(
                              //                               borderRadius:
                              //                                   BorderRadius.circular(
                              //                                       10),
                              //                               color: Color(0xffFFE8D6),
                              //                             ),
                              //                             padding: EdgeInsets.all(10),
                              //                             child: Column(
                              //                               children: [
                              //                                 GestureDetector(
                              //                                   onTap: () {
                              //                                     Navigator.of(
                              //                                             context)
                              //                                         .push(
                              //                                       MaterialPageRoute(
                              //                                         builder:
                              //                                             (context) =>
                              //                                                 SeekerProfile(),
                              //                                       ),
                              //                                     );
                              //                                   },
                              //                                   child: Row(
                              //                                     mainAxisAlignment:
                              //                                         MainAxisAlignment
                              //                                             .spaceBetween,
                              //                                     children: [
                              //                                       Row(
                              //                                         children: [
                              //                                           CircleAvatar(),
                              //                                           Container(
                              //                                             padding:
                              //                                                 EdgeInsets
                              //                                                     .symmetric(
                              //                                               horizontal:
                              //                                                   10,
                              //                                             ),
                              //                                             child:
                              //                                                 Column(
                              //                                               children: [
                              //                                                 Text(
                              //                                                   snapshotSeeker
                              //                                                       .data!
                              //                                                       .name!,
                              //                                                   style: Theme.of(context)
                              //                                                       .textTheme
                              //                                                       .subtitle1,
                              //                                                 ),
                              //                                               ],
                              //                                             ),
                              //                                           ),
                              //                                         ],
                              //                                       ),
                              //                                       Align(
                              //                                         alignment: Alignment
                              //                                             .centerLeft,
                              //                                         child:
                              //                                             IconButton(
                              //                                           icon: Icon(
                              //                                             Icons
                              //                                                 .delete,
                              //                                             color: Colors
                              //                                                 .grey,
                              //                                           ),
                              //                                           onPressed:
                              //                                               () {},
                              //                                         ),
                              //                                       )
                              //                                     ],
                              //                                   ),
                              //                                 ),
                              //                                 Row(
                              //                                   mainAxisAlignment:
                              //                                       MainAxisAlignment
                              //                                           .spaceBetween,
                              //                                   children: [
                              //                                     Align(
                              //                                       alignment: Alignment
                              //                                           .centerRight,
                              //                                       child: Text(
                              //                                         snapshot
                              //                                             .data![
                              //                                                 index]
                              //                                             .topic,
                              //                                         style:
                              //                                             TextStyle(
                              //                                           color: Color(
                              //                                               0xffCB997E),
                              //                                           fontWeight:
                              //                                               FontWeight
                              //                                                   .bold,
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                     Align(
                              //                                       alignment: Alignment
                              //                                           .centerRight,
                              //                                       child: Text(
                              //                                         snapshot
                              //                                             .data![
                              //                                                 index]
                              //                                             .providers[
                              //                                                 index]
                              //                                             .status!,
                              //                                         style:
                              //                                             TextStyle(
                              //                                           color: Color(
                              //                                               0xff6B705C),
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                   ],
                              //                                 ),
                              //                                 Text(
                              //                                   "خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
                              //                                   style: TextStyle(
                              //                                     height: 1.5,
                              //                                   ),
                              //                                 )
                              //                               ],
                              //                             ),
                              //                           ),
                              //                         );
                              //                       } else {
                              //                         return Center(
                              //                           child:
                              //                               CircularProgressIndicator(),
                              //                         );
                              //                       }
                              //                     },
                              //                   );
                              //                 },
                              //               )
                              //             : Container();
                              //       } else {
                              //         return Container();
                              //       }
                              //     } else {
                              //       return MessageDialog.showLoadingDialog(
                              //         context,
                              //         message: "يرجى الانتظار",
                              //       );
                              //     }
                              //   },
                              // ),
                              )
                          : Container(),
                      /////////////////
                      Builder(
                        builder: (context) {
                          ScheduleCubit.get(context).getScheduledDataProvider();

                          return BlocConsumer<ScheduleCubit, ScheduleState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              var cubit = ScheduleCubit.get(context);
                              return cubit.scheduledData.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 5,
                                        ),
                                        itemCount: cubit.scheduledData.length,
                                        itemBuilder: (context, index) {
                                          SeekerCubit.get(context)
                                              .getSeekerData(
                                                  seekerId: cubit
                                                      .scheduledData[index]
                                                      .seekerId!);

                                          return FutureBuilder(
                                            future: getSeekerDataPerInstant(
                                              seekerId: cubit
                                                  .scheduledData[index]
                                                  .seekerId!,
                                            ),
                                            builder: (context,
                                                AsyncSnapshot<SeekerData>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScheduledConsultationDetail(
                                                          name: snapshot
                                                              .data!.name!,
                                                          details: cubit
                                                              .scheduledData[
                                                                  index]
                                                              .scheduledDetails!,
                                                          topic: cubit
                                                              .scheduledData[
                                                                  index]
                                                              .topic!,
                                                          time:
                                                              "${DateFormat.jm('ar').format(
                                                            DateFormat.jm()
                                                                .parse(
                                                              cubit
                                                                  .scheduledData[
                                                                      index]
                                                                  .scheduledTimes!
                                                                  .first,
                                                            ),
                                                          )}  - ${DateFormat.jm('ar').format(
                                                            DateFormat.jm()
                                                                .parse(
                                                                  cubit
                                                                      .scheduledData[
                                                                          index]
                                                                      .scheduledTimes!
                                                                      .last,
                                                                )
                                                                .add(
                                                                  Duration(
                                                                      hours: 1),
                                                                ),
                                                          )}",
                                                          date: cubit
                                                              .scheduledData[
                                                                  index]
                                                              .scheduledDate!
                                                              .toDate(),
                                                          seekerId: cubit
                                                              .scheduledData[
                                                                  index]
                                                              .seekerId!,
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
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SeekerProfile(),
                                                              ),
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                                child: Text(
                                                                  snapshot.data!
                                                                      .name!,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle1,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(cubit
                                                              .scheduledData[
                                                                  index]
                                                              .topic!),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              DateFormat.yMMMd(
                                                                      'ar')
                                                                  .format(
                                                                cubit
                                                                    .scheduledData[
                                                                        index]
                                                                    .scheduledDate!
                                                                    .toDate(),
                                                              ),
                                                            ),
                                                            Directionality(
                                                              textDirection: ui
                                                                  .TextDirection
                                                                  .ltr,
                                                              child: Text(
                                                                  "${DateFormat.jm('ar').format(
                                                                DateFormat.jm()
                                                                    .parse(
                                                                  cubit
                                                                      .scheduledData[
                                                                          index]
                                                                      .scheduledTimes!
                                                                      .first,
                                                                ),
                                                              )}  - ${DateFormat.jm('ar').format(
                                                                DateFormat.jm()
                                                                    .parse(
                                                                      cubit
                                                                          .scheduledData[
                                                                              index]
                                                                          .scheduledTimes!
                                                                          .last,
                                                                    )
                                                                    .add(
                                                                      Duration(
                                                                          hours:
                                                                              1),
                                                                    ),
                                                              )}"),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Platform.isIOS
                                                    ? Center(
                                                        child:
                                                            CupertinoActivityIndicator(),
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator(),
                                    );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: MyProviderBottomNavigationBar(
              selectedIndex: 3,
            ),
          );
        },
      );
    });
  }
}
