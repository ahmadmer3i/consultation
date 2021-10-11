// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/login_provider.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/pre_register.dart';
import 'package:consultation/reset_password.dart';
import 'package:consultation/view_model/get_seeker_data.dart';
import 'package:consultation/view_model/login_register/user_login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginSeeker extends StatefulWidget {
  const LoginSeeker({Key? key}) : super(key: key);

  @override
  _LoginSeekerState createState() => _LoginSeekerState();
}

class _LoginSeekerState extends State<LoginSeeker> {
  late bool _isObscure = true; // لاظهار و اخفاء كلمه المرور (العين)
  var key = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance; // الربط مع الداتا اوثنتكيشن
  late String _email, _password;

  Future<List<SeekerData>>? getSeeker;
  List<SeekerData> seekerList = [];

  @override
  void initState() {
    // built in method
    // Just in StatefulWidget
    // run one time when the screen appear
    super.initState();
    getSeeker = getSeekerData(seekerList);
  }

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
            margin: EdgeInsets.only(top: 40, bottom: 10),
            child: Image.asset(
              "Assets/Logo2.png",
              height: 100,
            ),
          ),
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
                              label: "البريد الألكتروني",
                              onChanged: (value) {
                                // تاخذ قيه الايميل وتحفظه في الفاليو
                                setState(
                                  () {
                                    _email = value;
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: MyTextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    _password = value;
                                  },
                                );
                              },
                              isObscure: _isObscure,
                              label: " كلمة المرور*",
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                              },
                              child: Text(
                                "هل نسيت كلمة السر؟",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginProvider(),
                                  ),
                                );
                              },
                              child: Text(
                                "هل أنت مستشار ؟",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: getSeeker,
                            builder: (context,
                                AsyncSnapshot<List<SeekerData>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    seekerLogin(
                                      email: _email,
                                      password: _password,
                                      userList: seekerList,
                                      context: context,
                                    );

                                    // try {
                                    //   // UserCredential credential =
                                    //   //     await instance
                                    //   //         .signInWithEmailAndPassword(
                                    //   //             email: _email,
                                    //   //             password: _password);
                                    //   for (var seeker in seekerList) {
                                    //     if (seeker.email == _email &&
                                    //         seeker.password == _password) {
                                    //       currentUsername = seeker.name;
                                    //       Navigator.of(context).push(
                                    //         MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               DashboardSeeker(
                                    //             username: seeker.name!,
                                    //           ),
                                    //         ),
                                    //       );
                                    //     } else {}
                                    //   }
                                    // } on FirebaseAuthException catch (e) {
                                    //   if (e.code == "invalid-email") {
                                    //     // print("invalid-email");
                                    //   } else if (e.code == "wrong-password") {
                                    //     // print("wrong-password");
                                    //   } else if (e.code == "user-disabled") {
                                    //     // print("user-disabled");
                                    //   } else if (e.code == "user-not-found") {
                                    //     // print("user-not-found");
                                    //   }
                                    //
                                    //   try {
                                    //     // var result = await FirebaseFirestore
                                    //     //     .instance
                                    //     //     .collection('users')
                                    //     //     .get();
                                    //   } on FirebaseException catch (e) {}
                                    // }
                                  },
                                  child: Text(
                                    "تسجيل الدخول",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Color(0xffFFE8D6),
                                        ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PreRegister(),
                                  ),
                                );
                              },
                              child: Text(
                                "ليس لديك حساب؟ سجل هنا",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Color(0xffFFE8D6),
                                      decoration: TextDecoration.underline,
                                    ),
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
