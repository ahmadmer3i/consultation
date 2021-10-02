
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/components.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/login_provider.dart';
import 'package:consultation/pre_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SeekerRegisteration extends StatefulWidget {
  const SeekerRegisteration({Key? key}) : super(key: key);

  @override
  _SeekerRegisterationState createState() => _SeekerRegisterationState();
}

class _SeekerRegisterationState extends State<SeekerRegisteration> {
  var key = GlobalKey<FormState>();
  FirebaseAuth auth= FirebaseAuth.instance; // الربط مع الداتا اوثنتكيشن
  late String _email , _password,_name,_username,_dateofbirth ;
  late bool _isObcsure= true ;
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
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(decoration: InputDecoration(labelText:"الأسم بالكامل",),//كود التحقق من الايميل و الباسورد
                                  onChanged: (value){
                                    setState(() {
                                      this._name=value;
                                    });
                                  },
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(decoration: InputDecoration(labelText:"البريد الألكتروني",),//كود التحقق من الايميل و الباسورد
                                  onChanged: (value){
                                    setState(() {
                                      this._email=value;
                                    });
                                  },
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: TextField(decoration: InputDecoration(labelText:"أسم المستخدم",),//كود التحقق من الايميل و الباسورد
                                  onChanged: (value){
                                    setState(() {
                                      this._username=value;
                                    });
                                  },
                                )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "جنس*",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  color: Color(0xff000000),
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
                                    style: TextStyle(color: Color(0xff000000)),
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
                              child: TextField(
                                  onChanged: (value){
                                    setState(() {
                                      this._dateofbirth=value;
                                    });},
                                  decoration: InputDecoration(labelText:" تاريخ الميلاد *",
                                    suffixIcon:
                                    IconButton( onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1920, 8),
                                        lastDate: DateTime(2101),
                                      );},
                                      icon: Icon(Icons.calendar_today,
                                          color: Colors.white38),
                                    ),
                                  )), ) ,



                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    this._password=value;
                                  });},
                                obscureText: _isObcsure,
                                decoration: InputDecoration(labelText:" كلمة المرور*",
                                  suffixIcon:
                                  IconButton( icon:Icon(_isObcsure? Icons.visibility:Icons.visibility_off,),
                                      onPressed:(){
                                        setState(() {
                                          _isObcsure=!_isObcsure;
                                        });}),),

                              ),),

                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    this._password=value;
                                  });},
                                obscureText: _isObcsure,
                                decoration: InputDecoration(labelText:"تأكيد كلمة المرور*",
                                  suffixIcon:
                                  IconButton( icon:Icon(_isObcsure? Icons.visibility:Icons.visibility_off,),
                                      onPressed:(){
                                        setState(() {
                                          _isObcsure=!_isObcsure;
                                        });}),),

                              ),),

                            ElevatedButton(
                                onPressed: () async {
                                  UserCredential credential =
                                  await auth.createUserWithEmailAndPassword(
                                      email:_email,password:_password);

                                  FirebaseFirestore.instance.collection('seeker').add(
                                      {"name":_name,"username":_username,"email":_email,"gender":selectedGender,"date of birth":_dateofbirth,"password":_password,"Type":"seeker"});

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DashboardSeeker()));
                                },
                                child: Text(
                                  "التسجیل",
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
