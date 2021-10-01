// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:flutter/material.dart';

class ConsultationDetails extends StatefulWidget {
  const ConsultationDetails({Key? key}) : super(key: key);

  @override
  _ConsultationDetailsState createState() => _ConsultationDetailsState();
}

class _ConsultationDetailsState extends State<ConsultationDetails> {
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
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                        ),
  context: context,
  builder: (_) => MyBottomSheet(),
);
                      },
                    child: Text(
                      "الدفع",
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
