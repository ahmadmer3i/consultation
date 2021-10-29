import 'package:consultation/Seeker/provider_profile.dart';
import 'package:consultation/components.dart';
import 'package:consultation/view_model/provider/time_cubit.dart';
import 'package:consultation/view_model/schedule_cubit/schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_rating/flutter_rating.dart';

class ListConsultants extends StatefulWidget {
  final String topic;
  const ListConsultants({Key? key, required this.topic}) : super(key: key);

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
      body: BlocProvider(
        create: (context) =>
            ScheduleCubit()..getScheduleData(topic: widget.topic),
        child: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            var cubit = ScheduleCubit.get(context);
            return Container(
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
                        itemCount: cubit.providers.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                              TimeCubit.get(context).getTimeIntervalsSeeker(
                                  providerId: cubit.providers[index].uid!);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProviderProfileSchedule(
                                    data: cubit.providers[index],
                                  ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProviderProfileSchedule(
                                                  canProceed: false,
                                                  data: cubit.providers[index],
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
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cubit.providers[index]
                                                          .name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                            height: 1,
                                                          ),
                                                    ),
                                                    Text(
                                                      " ${cubit.providers[index].price!.toStringAsFixed(0)} ريال / الساعة",
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
                                            Text(cubit.providers[index].rate!
                                                .toStringAsFixed(1)),
                                            StarRating(
                                              rating:
                                                  cubit.providers[index].rate!,
                                              size: 20,
                                              borderColor:
                                                  const Color(0xff6B705C),
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
                                      cubit.providers[index].experience!,
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
            );
          },
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(selectedIndex: 0),
    );
  }
}
