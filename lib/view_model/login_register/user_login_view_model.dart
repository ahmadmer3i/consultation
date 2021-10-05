import 'package:consultation/Provider/provider_dashboard.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void seekerLogin({
  required String email,
  required String password,
  required List<SeekerData> userList,
  required BuildContext context,
}) async {
  try {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (user != null) {
      for (var user in userList) {
        if (user.email == email) {
          print("user Exist");
          currentUsername = user.name;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DashboardSeeker(
                username: user.name!,
              ),
            ),
          );
        }
      }
    }
  } on FirebaseAuthException catch (e) {}
}

void providerLogin({
  required String email,
  required String password,
  required List<ProviderData> userList,
  required BuildContext context,
}) async {
  try {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (user.credential != null) {
      for (var user in userList) {
        if (user.email == email) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProviderDashboard(),
            ),
          );
        }
      }
    }
  } on FirebaseAuthException catch (e) {}
}
