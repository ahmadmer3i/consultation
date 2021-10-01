// ignore: file_names
// ignore: file_names
import 'dart:async';

import 'package:consultation/login_seeker.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          LoginSeeker()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6b705c),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 498.0, start: -284.0),
            Pin(size: 498.0, end: -199.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffcb997e),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 256.0, end: -128.0),
            Pin(size: 256.0, start: -128.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffcb997e),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Image.asset('Assets/Logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
