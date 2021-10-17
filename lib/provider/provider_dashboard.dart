// ignore_for_file: prefer_const_constructors

import 'package:consultation/Provider/instant_consultation_detail.dart';
import 'package:consultation/Provider/scheduled_consultation_detail.dart';
import 'package:consultation/Provider/seeker_profile.dart';
import 'package:consultation/components.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/view_model/get_seeker_data.dart';
import 'package:consultation/view_model/provider/provider_instant_cubit/instant_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                                Text(
                                                  "خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
                                                  style: TextStyle(
                                                    height: 1.5,
                                                  ),
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
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduledConsultationDetail(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                        children: [
                                          CircleAvatar(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              "خالد عبدالله",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("تصميم غرافيك"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
