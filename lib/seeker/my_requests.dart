import 'package:consultation/Seeker/consultation_details_instant.dart';
import 'package:consultation/Seeker/offers.dart';
import 'package:consultation/Seeker/seeker_chat.dart';
import 'package:consultation/components.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/get_request_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  bool request = true;

  Future<List<ConsultData>>? getConsults;
  List<ConsultData>? consultsList = [];

  @override
  void initState() {
    super.initState();
    // getConsults = getRequestData(consultsList);
  }

  @override
  Widget build(BuildContext context) {
    List<ProviderData> providerTopic = [];
    Future<List<ProviderData>>? getProvider;
    return Scaffold(
      appBar: MyAppBar(
        autoLeading: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "طلباتي",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: const Color(0xffCB997E)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SeekerChat(
                        tabIndex: 1,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ConsultData>>(
              stream: getRequestData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    print(snapshot.data!.length);
                    return snapshot.data!.isNotEmpty
                        ?
                        // ListView.builder(
                        //         itemCount: snapshot.data!.length,
                        //         itemBuilder: (context, index) {
                        //           consultsList.sort(
                        //             (b, a) {
                        //               var aDate = a.date;
                        //               var bDate = b.date;
                        //               return aDate.compareTo(bDate);
                        //             },
                        //           );

                        // return
                        Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xffFFE8D6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data![0].topic,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteItem(context,
                                                docId: snapshot.data![0].docId);
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.yMMMd('ar').format(
                                              snapshot.data![0].date.toDate()),
                                          // " 17 سبتمبر 2021",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Text(
                                          DateFormat.jm('ar').format(
                                              snapshot.data![0].date.toDate()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        snapshot.data![0].detail,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              height: 1.2,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "عروض : ${snapshot.data![0].providers.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Offers(
                                              providerData:
                                                  snapshot.data![0].providers,
                                              docId: snapshot.data![0].docId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "مشاهدة العروض",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // );
                            // },
                            // )
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لا یوجد استشارات",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ConsultationDetailsInstant(
                                        topic: "",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "استشر الآن",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                  } else {
                    return MessageDialog.showLoadingDialog(context,
                        message: "يرجى الإنتظار");
                  }
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "لا یوجد استشارات",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ConsultationDetailsInstant(
                                topic: "",
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "استشر الآن",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
