// ignore_for_file: prefer_const_constructors

import 'package:consultation/Provider/provider_dashboard.dart';
import 'package:consultation/components.dart';
import 'package:consultation/login_seeker.dart';
import 'package:consultation/pre_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginProvider extends StatefulWidget {
  const LoginProvider({Key? key}) : super(key: key);

  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      resizeToAvoidBottomInset: true,
      

      // ignore: prefer_const_constructors
      backgroundColor: Color(0xffFFE8D6),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 40, bottom: 10),
              child: Image.asset(
                "Assets/Logo2.png",
                height: 100,
              )),
          Image.asset(
            "Assets/providerIllustration.png",
            height: 150,
          ),
          Text(
            'تسجيل الدخول كمقدم خدمة',
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
                            margin: EdgeInsets.only(bottom: 20,top: 20),
                            child: MyTextField(label:"اسم المستخدم")),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(label: "كلمة المرور",)),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                                onPressed: () {},
                                child: Text(
                                  "هل نسيت كلمة السر؟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Color(0xffFFE8D6),
                                          decoration: TextDecoration.underline),
                                ))),
                                Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginSeeker()));
                                },
                                child: Text(
                                  "هل أنت مستفيد؟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Color(0xffFFE8D6),
                                          decoration: TextDecoration.underline),
                                ))),
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProviderDashboard()));
                                }, child: Text("تسجيل الدخول",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xffFFE8D6)),)),
                                Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PreRegister()));
                                },
                                child: Text(
                                  "ليس لديك حساب؟ سجل هنا",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Color(0xffFFE8D6),
                                          decoration: TextDecoration.underline),
                                ))),
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
