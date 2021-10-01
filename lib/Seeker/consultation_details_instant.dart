// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/Seeker/my_requests.dart';
import 'package:flutter/material.dart';

class ConsultationDetailsInstant extends StatefulWidget {
  const ConsultationDetailsInstant({Key? key}) : super(key: key);

  @override
  _ConsultationDetailsInstantState createState() => _ConsultationDetailsInstantState();
}

class _ConsultationDetailsInstantState extends State<ConsultationDetailsInstant> {
  int? selectedMethod=0;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
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
              label: "*اكتب استشارتك*",
              maxLength: 400,
              minHeight: 6,
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyRequests()));
                      },
                    child: Text(
                      "إرسال",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.white),
                    )))
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
