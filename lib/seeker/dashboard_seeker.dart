import 'package:consultation/Seeker/consultation_details_instant.dart';
import 'package:consultation/Seeker/list_consultants.dart';
import 'package:consultation/components.dart';
import 'package:consultation/models/topic.dart';
import 'package:consultation/seeker/provider_profile.dart';
import 'package:consultation/view_model/get_request_data.dart';
import 'package:consultation/view_model/get_topics_data.dart';
import 'package:consultation/view_model/search_cubit/search_cubit.dart';
import 'package:consultation/view_model/time_cubit/time_cubit.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';

class DashboardSeeker extends StatefulWidget {
  final String? username;
  const DashboardSeeker({Key? key, this.username}) : super(key: key);

  @override
  _DashboardSeekerState createState() => _DashboardSeekerState();
}

class _DashboardSeekerState extends State<DashboardSeeker> {
  final searchController = TextEditingController();
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
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);

          return Container(
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
                MyTextFieldDark(
                  textController: cubit.searchController,
                  onChanged: (value) {
                    cubit.checkSearch();
                    for (var item in cubit.searchResult) {
                      print(item.name);
                    }
                  },
                  label: "ابحث باسم المستشار",
                  radius: 50,
                ),
                cubit.isSearchEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          "ماهي نوع استشارتك التي تود طلبها ؟",
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: const Color(0xff6B705C),
                                  ),
                        ),
                      )
                    : const SizedBox.shrink(),
                cubit.isSearchEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "المجالات",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: const Color(0xffCB997E),
                                  ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "نتائج البحث",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: const Color(0xffCB997E),
                                  ),
                        ),
                      ),
                cubit.isSearchEmpty
                    ? Expanded(
                        child: FutureBuilder(
                          future: getTopics,
                          builder:
                              (context, AsyncSnapshot<List<Topic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
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
                                            backgroundColor:
                                                const Color(0xffFFE8D6),
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
                                                      TimeCubit.get(context)
                                                          .setTopic(
                                                              scheduledTopic:
                                                                  topicsList[
                                                                          index]
                                                                      .title);
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ListConsultants(
                                                                  topic: topicsList[
                                                                          index]
                                                                      .title),
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
                                                        AsyncSnapshot<bool>
                                                            snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        return ElevatedButton(
                                                          onPressed:
                                                              snapshot.data!
                                                                  ? () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ConsultationDetailsInstant(
                                                                            topic:
                                                                                topicsList[index].title,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  : null,
                                                          child: Text(
                                                            "فورية",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                  color: Colors
                                                                      .white,
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
                                                      color: const Color(
                                                          0xff6B705C),
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
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
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
                                                data: cubit.searchResult[index],
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
                                                    cubit.searchResult[index]
                                                        .name!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                          height: 1,
                                                        ),
                                                  ),
                                                  Text(
                                                    " ${cubit.searchResult[index].price!.toStringAsFixed(0)} ريال / الساعة",
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
                                          Text(cubit.searchResult[index].rate!
                                              .toStringAsFixed(1)),
                                          StarRating(
                                            rating:
                                                cubit.searchResult[index].rate!,
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
                                    cubit.searchResult[index].experience!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(height: 1.2),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5,
                            ),
                        itemCount: cubit.searchResult.length),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 4,
      ),
    );
  }
}
