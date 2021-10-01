// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/components.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/login_provider.dart';
import 'package:consultation/pre_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginSeeker extends StatefulWidget {
  const LoginSeeker({Key? key}) : super(key: key);

  @override
  _LoginSeekerState createState() => _LoginSeekerState();
}

class _LoginSeekerState extends State<LoginSeeker> {
  var key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    FirebaseFirestore.instance.collection('seeker').add({"name":"haroon","username":"haroon90","email":"harron9@hotmail.com","gender":"M","date of birth":"20/09/1999","password":"990976"});
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
              margin: EdgeInsets.only(top: 40, bottom: 10),
              child: Image.asset(
                "Assets/Logo2.png",
                height: 100,
              )),
          Image.asset(
            "Assets/seekerillustration.png",
            height: 150,
          ),
          Text(
            'تسجيل الدخول كمستفيد',
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
                            child: MyTextField(label:"البريد الالكتروني")),
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginProvider()));
                                },
                                child: Text(
                                  "هل أنت مستشار ؟",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Color(0xffFFE8D6),
                                          decoration: TextDecoration.underline),
                                ))),
                                ElevatedButton(onPressed: (){
                                  //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashboardSeeker()));

                                }, child: Text("تسجيل الدخول",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Color(0xffFFE8D6),),),),
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
