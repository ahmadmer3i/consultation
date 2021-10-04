// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:adobe_xd/pinned.dart';
import 'package:consultation/Provider/provider_registration_three.dart';
import 'package:consultation/components.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:flutter/material.dart';

class ProviderRegistrationTwo extends StatefulWidget {
  const ProviderRegistrationTwo({Key? key}) : super(key: key);

  @override
  _ProviderRegistrationTwoState createState() =>
      _ProviderRegistrationTwoState();
}

class _ProviderRegistrationTwoState extends State<ProviderRegistrationTwo> {
  bool instant = false;
  bool scheduled = false;
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffFFE8D6),
      body: Stack(children: [
        Pinned.fromPins(
          Pin(size: 256.0, end: -100.0),
          Pin(size: 256.0, start: -100.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              color: const Color(0xff6B705C),
              border: Border.all(width: 1.0, color: const Color(0xff6B705C)),
            ),
          ),
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.only(top: 80, right: 50),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ),
            Align(
                child: Text(
              "أهلا بك! ",
              style: Theme.of(context).textTheme.headline6!.copyWith(height: 1),
            )),
            Text(providerName,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(height: 2, fontWeight: FontWeight.bold)),
            Text(
              'نحتاج إلى بعض المعلومات الإضافية لإعداد حسابك',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(height: 1, color: Color(0xffCB997E)),
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Text("أخبرنا عن نفسك",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          height: 2,
                                          color: Color(0xff21686C)))),
                        ),
                        CategoriesSelector(),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text("نوع الاستشارة*")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text("فوري"),
                                Checkbox(
                                    value: instant,
                                    onChanged: (value) {
                                      setState(() {
                                        instant = value!;
                                        providerInstant = instant;
                                      });
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                Text("المقرر"),
                                Checkbox(
                                    value: scheduled,
                                    onChanged: (value) {
                                      setState(() {
                                        scheduled = value!;
                                        providerScheduled = scheduled;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                        MyTextFieldDark(
                          textController: priceController,
                          label: "رسوم الاستشارة / الساعة*",
                          suffix: Text("ریال"),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xff8EC73F),
                              ),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xff6B705C),
                              ),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xff8EC73F),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            providerPrice = priceController.text;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProviderRegistrationThree(),
                              ),
                            );
                          },
                          child: Text(
                            "التالي",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ]),
    );
  }
}
