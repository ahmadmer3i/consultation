// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:adobe_xd/pinned.dart';
import 'package:consultation/components.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/view_model/login_register/user_register_view_model.dart';
import 'package:flutter/material.dart';

class ProviderRegistrationThree extends StatefulWidget {
  const ProviderRegistrationThree({Key? key}) : super(key: key);

  @override
  _ProviderRegistrationThreeState createState() =>
      _ProviderRegistrationThreeState();
}

class _ProviderRegistrationThreeState extends State<ProviderRegistrationThree> {
  bool instant = false;
  bool scheduled = false;
  int selectedBank = 0;
  final ibanController = TextEditingController();
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
              borderRadius: BorderRadius.all(
                Radius.elliptical(9999.0, 9999.0),
              ),
              color: const Color(0xff6B705C),
              border: Border.all(
                width: 1.0,
                color: const Color(0xff6B705C),
              ),
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
                  ),
                ),
              ),
            ),
            Align(
              child: Text(
                "أهلا بك! ",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      height: 1,
                    ),
              ),
            ),
            Text(
              providerName,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    height: 2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'نحتاج إلى بعض المعلومات الإضافية لإعداد حسابك',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    height: 1,
                    color: Color(0xffCB997E),
                  ),
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "أخبرنا عن نفسك",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        height: 2,
                                        color: Color(0xff21686C),
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "حدد البنك*",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            DropdownButton(
                              onChanged: (int? value) {
                                setState(
                                  () {
                                    selectedBank = value!;
                                    selectedBank == 0
                                        ? providerBank = "بنك الرياض"
                                        : providerBank = "بنك الجزيرة";
                                  },
                                );
                              },
                              focusColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              value: selectedBank,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "بنك الرياض",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "بنك الجزيرة",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            MyTextFieldDark(
                              label: "رقم الآيبان*",
                              textController: ibanController,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Color(0xff8EC73F),
                                  ),
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Color(0xff8EC73F),
                                  ),
                                  CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Color(0xff6B705C),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                providerIBAN = ibanController.text;
                                selectedBank == 0
                                    ? providerBank = "بنك الرياض"
                                    : providerBank = "بنك الجزيرة";
                                providerRegister(
                                  rate: 5,
                                  name: providerName,
                                  password: providerPassword,
                                  email: providerEmail,
                                  price: providerPrice,
                                  iban: providerIBAN,
                                  experience: providerExperience,
                                  gender: providerGender!,
                                  username: providerUsername,
                                  dob: providerBOD,
                                  instant: instant,
                                  scheduled: scheduled,
                                  bank: providerBank,
                                  topics: selectedItems,
                                  context: context,
                                );
                              },
                              child: Text(
                                "تسجيل",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
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
