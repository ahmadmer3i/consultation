import 'package:consultation/Seeker/consultation_details_instant.dart';
import 'package:consultation/Seeker/list_consultants.dart';
import 'package:consultation/components.dart';
import 'package:consultation/models/topic.dart';
import 'package:consultation/view_model/get_request_data.dart';
import 'package:consultation/view_model/get_topics_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardSeeker extends StatefulWidget {
  final String username;
  const DashboardSeeker({Key? key, required this.username}) : super(key: key);

  @override
  _DashboardSeekerState createState() => _DashboardSeekerState();
}

class _DashboardSeekerState extends State<DashboardSeeker> {
  Future<List<Topic>>? getTopics;
  List<Topic> topicsList = [];
  Future<bool>? checkActive;

  List<String> list = [
    "تصميم غرافيك",
    "تكنولوجيا المعلومات",
    "إحصاء",
    "كيمياء",
    "اللغة والترجمة",
    "تسويق",
    "تصميم غرافيك",
    "تكنولوجيا المعلومات",
    "إحصاء",
    "كيمياء",
    "اللغة والترجمة",
    "تسويق"
  ];
  Map<String, String> map = {};

  @override
  void initState() {
    super.initState();
    getTopics = getTopicsData(topicsList);
    checkActive = checkConsult();
  }

  @override
  Widget build(BuildContext context) {
    map["تسويق"] = "illustrationn5.png";
    map["اللغة والترجمة"] = "illustrationn3.png";
    map["كيمياء"] = "illustrationn4.png";
    map["إحصاء"] = "illustrationn6.png";
    map["تكنولوجيا المعلومات"] = "illustrationn2.png";
    map["تصميم غرافيك"] = "illustrationn1.png";

    return Scaffold(
      appBar: MyAppBar(
        autoLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "أهلاً ${widget.username}", // String interpolation
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: const Color(0xffCB997E),
                    ),
              ),
            ),
            const MyTextFieldDark(
              label: "ابحث باسم المستشار",
              radius: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "ماهي نوع استشارتك التي تود طلبها ؟",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: const Color(0xff6B705C),
                    ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "المجالات",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: const Color(0xffCB997E),
                    ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getTopics,
                builder: (context, AsyncSnapshot<List<Topic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xffFFE8D6),
                                  title: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "حدد نوع الاستشارة",
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListConsultants(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "مجدولة",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                        FutureBuilder(
                                          future: checkActive,
                                          builder: (context,
                                              AsyncSnapshot<bool> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return ElevatedButton(
                                                onPressed: snapshot.data!
                                                    ? () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ConsultationDetailsInstant(
                                                              topic: topicsList[
                                                                      index]
                                                                  .title,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    : null,
                                                child: Text(
                                                  "فورية",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6!
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      topicsList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: const Color(0xff6B705C),
                                            height: 1.2,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.network(
                                    topicsList[index].image,
                                  ),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFE8D6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return MessageDialog.showLoadingDialog(
                      context,
                      message: "يرجى الانتظار",
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 4,
      ),
    );
  }
}
