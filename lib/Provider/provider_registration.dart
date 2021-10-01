// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:consultation/components.dart';
import 'package:consultation/login_provider.dart';
import 'package:consultation/pre_register.dart';
import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProviderRegisteration extends StatefulWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final checkPasswordController = TextEditingController();

   ProviderRegisteration({Key? key}) : super(key: key);

  @override
  _ProviderRegisterationState createState() => _ProviderRegisterationState();
}

class _ProviderRegisterationState extends State<ProviderRegisteration> {
  var key = GlobalKey<FormState>();
  int selectedGender = 0;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffCB997E),
      //   child: Icon(Icons.add,color: Colors.black,),
      //   onPressed: () {
      //     key.currentState!.validate();
      //   },
      // ),

      // ignore: prefer_const_constructors
      backgroundColor: Color(0xffFFE8D6),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 80, bottom: 40),
              child: Image.asset(
                "Assets/Logo2.png",
                height: 100,
              )),
          Text(
            'تسجيل حساب جديد',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Color(0xffCB997E)),
          ),
          Expanded(
              child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff6B705C),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(10),
                child: Form(
                  key: key,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 20, top: 20),
                            child: MyTextField(label: "الاسم بالكامل*",),),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "البريد الإلكتروني*",
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "اسم المستخدم*",
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "جنس*",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Color(0xffFFE8D6),
                                    ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: DropdownButton(
                              hint: Text(
                                "جنس*",
                                style: TextStyle(color: Color(0xffFFE8D6),decoration: TextDecoration.none),
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                              focusColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              value: selectedGender,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                    value: 0,
                                    child: Text(
                                      "ذكر",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      "أنثى",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              label: "تاريخ الميلاد*",
                              iconButton: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101),
                                  );
                                },
                                icon: Icon(Icons.calendar_today,
                                    color: Colors.white38),
                              ),
                            )),
                            Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              isOsbcure: true,
                              label: "كلمة المرور",
                              iconButton: IconButton(
                                onPressed: () {
                                  
                                },
                                icon: Icon(Icons.remove_red_eye,
                                    color: Colors.white38),
                              ),
                            )),
                            Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              isOsbcure: true,
                              label: "تأكيد كلمة المرور*",
                              iconButton: IconButton(
                                onPressed: () {
                                  
                                },
                                icon: Icon(Icons.remove_red_eye,
                                    color: Colors.white38),
                              ),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProviderRegisterationOne()));
                            },
                            child: Text(
                              "التالي",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Color(0xffFFE8D6)),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
