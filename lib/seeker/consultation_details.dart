// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/view_model/provider/time_cubit.dart';
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
                    )),
                MyTextFieldDark(
                  textController: consultController,
                  label: "*اكتب استشارتك*",
                  maxLength: 400,
                  minHeight: 6,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      TimeCubit.get(context)
                          .setConsult(seekerConsult: consultController.text);
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        context: context,
                        builder: (_) => MyBottomSheet(
                          price: widget.providerData.price! *
                              TimeCubit.get(context).reservedTimes.length,
                          onPressed: () {},
                        ),
                      );
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
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
