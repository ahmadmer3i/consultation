// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:consultation/Provider/provider_registration_one.dart';
import 'package:consultation/components.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProviderRegistration extends StatefulWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final checkPasswordController = TextEditingController();
  final birthdayController = TextEditingController();

  ProviderRegistration({Key? key}) : super(key: key);

  @override
  _ProviderRegistrationState createState() => _ProviderRegistrationState();
}

class _ProviderRegistrationState extends State<ProviderRegistration> {
  var key = GlobalKey<FormState>();
  int selectedGender = 0;
  late bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xffCB997E),
      //   child: Icon(Icons.add,color: Colors.black,),
      //   onPressed: () {
      //     key.currentState!.validate();
      //   },
      // ),
      backgroundColor: Color(0xffFFE8D6),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 40),
            child: Image.asset(
              "Assets/Logo2.png",
              height: 100,
            ),
          ),
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
                      topRight: Radius.circular(40),
                    ),
                  ),
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
                            child: MyTextField(
                              textController: widget.nameController,
                              label: "الاسم بالكامل*",
                              onChanged: (_) {
                                providerName = widget.nameController.text;
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MyTextField(
                                onChanged: (_) {
                                  providerEmail = widget.emailController.text;
                                },
                                textController: widget.emailController,
                                label: "البريد الإلكتروني*",
                              )),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                providerUsername =
                                    widget.usernameController.text;
                              },
                              textController: widget.usernameController,
                              label: "اسم المستخدم*",
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "جنس*",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: DropdownButton(
                              hint: Text(
                                "جنس*",
                                style: TextStyle(
                                  color: Color(0xffFFE8D6),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              onChanged: (int? value) {
                                setState(
                                  () {
                                    selectedGender = value!;
                                    selectedGender == 0
                                        ? providerGender = "M"
                                        : providerGender = "F";
                                  },
                                );
                              },
                              focusColor: Colors.white,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              value: selectedGender,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "ذكر",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "أنثى",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                providerBOD = widget.birthdayController.text;
                              },
                              textController: widget.birthdayController,
                              label: "تاريخ الميلاد*",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101),
                                  );
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                providerPassword =
                                    widget.passwordController.text;
                              },
                              textController: widget.passwordController,
                              isObscure: true,
                              label: "كلمة المرور",
                                  suffixIcon: IconButton(
                                  icon: Icon(
                                   _isObscure
                                  ? Icons.visibility
                                      : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                  setState(
                                  () {
                                  _isObscure = !_isObscure;
                                  },
                                  );
                                  },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              textController: widget.checkPasswordController,
                              isObscure: true,
                              label: "تأكيد كلمة المرور*",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(
                                        () {
                                      _isObscure = !_isObscure;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (providerGender == "") {
                                providerGender = "M";
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProviderRegistrationOne(),
                                ),
                              );
                            },
                            child: Text(
                              "التالي",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: Color(0xffFFE8D6),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
