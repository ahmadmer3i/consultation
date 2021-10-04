import 'package:consultation/Seeker/provider_profile.dart';
import 'package:consultation/components.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';

class ListConsultants extends StatefulWidget {
  const ListConsultants({Key? key}) : super(key: key);

  @override
  _ListConsultantsState createState() => _ListConsultantsState();
}

class _ListConsultantsState extends State<ListConsultants> {
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
        autoLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const MyTextFieldDark(
              label: "ابحث باسم المستشار",
              radius: 50,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProviderProfileSchedule(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color(0xffFFE8D6),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        height: 150,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProviderProfileSchedule(
                                            canProceed: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "خالد عبدالله",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      height: 1,
                                                    ),
                                              ),
                                              Text(
                                                " 15.00 ريال / الساعة",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text("3.0"),
                                      StarRating(
                                        rating: 1,
                                        size: 20,
                                        borderColor: const Color(0xff6B705C),
                                        color: const Color(0xff6B705C),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "خريج جامعة الملك سعود عام 2022 م صاحب البرنامج الاستشاري وحاصل على الشهادة الدولية للمسابقة الحائز على الميدالية الذهبية على مستوى المملكة في الذكاء الاصطناعي.",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(height: 1.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(selectedIndex: 0),
    );
  }
}
