import 'package:consultation/components.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/view_model/get_seeker_data.dart';
import 'package:consultation/view_model/report_cubit/report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProviderReports extends StatefulWidget {
  const ProviderReports({Key? key}) : super(key: key);

  @override
  _ProviderReportsState createState() => _ProviderReportsState();
}

class _ProviderReportsState extends State<ProviderReports> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportCubit>(
      create: (context) => ReportCubit()
        ..getReports(
            userType: "providerId", reportCollection: "providerReports"),
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ReportCubit.get(context);
          return Scaffold(
            appBar: MyAppBar(),
            body: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "بلاغاتي",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: const Color(0xffCB997E)),
                    )),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFE8D6),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${DateFormat.yMMMd('ar').format(cubit.reportData[index].reportDate!.toDate())} - ${DateFormat.jm('ar').format(cubit.reportData[index].reportDate!.toDate())}",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              cubit.reportData[index].reportDetails!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(height: 1.5),
                            ),
                            Text(
                              "تم الإبلاغ عن الملف الشخصي",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: const Color(0xff6B705C)),
                            ),
                            FutureBuilder(
                                future: getSeekerDataPerInstant(
                                    seekerId:
                                        cubit.reportData[index].seekerId!),
                                builder: (context,
                                    AsyncSnapshot<SeekerData> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            child: const CircleAvatar()),
                                        Text(
                                          snapshot.data!.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "حالۃ البلاغ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: const Color(0xffCB997E)),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: ReportStatus(
                                  selectedIndex:
                                      cubit.reportData[index].status!),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: cubit.reportData.length,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const MyProviderBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
