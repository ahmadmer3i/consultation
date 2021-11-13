// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/time_cubit/time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsultationDetails extends StatefulWidget {
  final ProviderData providerData;
  const ConsultationDetails({Key? key, required this.providerData})
      : super(key: key);

  @override
  _ConsultationDetailsState createState() => _ConsultationDetailsState();
}

class _ConsultationDetailsState extends State<ConsultationDetails> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final consultController = TextEditingController();
  int? selectedMethod = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: BlocConsumer<TimeCubit, TimeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "تفاصيل الاستشارة",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Color(0xffCB997E)),
                    ),
                  ),
                  MyTextFieldDark(
                    validator: (value) {
                      if (consultController.text.isEmpty) {
                        return "الرجاء كتابة تفاصيل الاستشارة";
                      }
                      return null;
                    },
                    textController: consultController,
                    label: "*اكتب استشارتك*",
                    maxLength: 400,
                    minHeight: 6,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          TimeCubit.get(context).setConsult(
                              seekerConsult: consultController.text);
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => MyBottomSheet(
                              price: widget.providerData.price! *
                                  TimeCubit.get(context).reservedTimes.length,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  TimeCubit.get(context).setSchedule(
                                    context,
                                    formKey: formKey2,
                                    selectedDay:
                                        TimeCubit.get(context).selectedDay,
                                    selectedTimes:
                                        TimeCubit.get(context).reservedTimes,
                                    payment: widget.providerData.price! *
                                        TimeCubit.get(context)
                                            .reservedTimes
                                            .length,
                                    providerId: widget.providerData.uid,
                                  );
                                }
                              },
                              formKey: formKey2,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "الدفع",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
