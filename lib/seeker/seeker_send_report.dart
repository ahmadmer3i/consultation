import 'package:consultation/components.dart';
import 'package:consultation/view_model/report_cubit/report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeekerSendReportScreen extends StatelessWidget {
  final String userId;
  final String reportCollection;
  final String sender;
  final String receiver;
  SeekerSendReportScreen({
    Key? key,
    required this.sender,
    required this.receiver,
    required this.userId,
    required this.reportCollection,
  }) : super(key: key);
  final reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<ReportCubit, ReportState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ReportCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "تقرير البلاغ",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: const Color(0xFFCB997E),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFieldDark(
                    validator: (value) {
                      if (reportController.text.isEmpty) {
                        return "الرجاء كتابة تفاصيل البلاغ";
                      }
                      return null;
                    },
                    textController: reportController,
                    label: "*اكتب استشارتك*",
                    maxLength: 400,
                    minHeight: 6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cubit.sendReport(
                        reportCollection: reportCollection,
                        reportDetails: reportController.text,
                        receiverId: userId,
                        sender: sender,
                        receiver: receiver,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "إرسال",
                      style: TextStyle(
                        color: Color(0xFFFFE8D6),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
