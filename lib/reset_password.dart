// ignore_for_file: prefer_const_constructors

import 'package:consultation/components.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  var key = GlobalKey<FormState>();
  FirebaseAuth auth= FirebaseAuth.instance; // الربط مع الداتا اوثنتكيشن
  late String _email , _password ;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
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
            "Assets/seekerillustration.png",
            height: 150,
          ),
          Text(
            'إعادة تعيين كلمة المرور',
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

                            ElevatedButton(onPressed: ()  async{
                              try{
                              await auth.sendPasswordResetEmail(email: _email);
                              MessageDialog.showSnackBar("تم إرسال رابط إعاده التعيين على بريدك الألكتروني", context);
                              } on FirebaseAuthException catch (e) {
                              if (e.code == "invalid-email") {
                              MessageDialog.showSnackBar("خطأ في البريد المستخدم", context);
                              } else if (e.code == "user-not-found") {
                              MessageDialog.showSnackBar("ليس لديك حساب ", context);
                              }

                            } },child: Text("إعاده تعيين ",style: TextStyle(color: Colors.white),)),


                            Align(
                                alignment: Alignment.center,
                                child: MaterialButton(

                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "الرجوع لتسجيل الدخول",
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
