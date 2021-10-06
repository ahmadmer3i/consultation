import 'package:consultation/Seeker/consultation_details_instant.dart';
import 'package:consultation/Seeker/list_consultants.dart';
import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class DashboardSeeker extends StatefulWidget {
  final String username;
  const DashboardSeeker({Key? key, required this.username}) : super(key: key);

  @override
  _DashboardSeekerState createState() => _DashboardSeekerState();
}

class _DashboardSeekerState extends State<DashboardSeeker> {
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: map.entries.length,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ConsultationDetailsInstant(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "فورية",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
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
                                map.keys.elementAt(index),
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
                            child: Image.asset(
                              "Assets/${map.values.elementAt(index)}",
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
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 4,
      ),
    );
  }
}
