import 'package:consultation/Provider/provider_dashboard.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/login_provider.dart';
import 'package:consultation/models/provider_data.dart';
import 'package:consultation/models/seeker_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void seekerLogin({
  required String email,
  required String password,
  required List<SeekerData> userList,
  required BuildContext context,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) async {
  try {
    MessageDialog.showWaitingDialog(context);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    for (var user in userList) {
      if (user.email == email) {
        currentUsername = user.name;
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardSeeker(
                username: user.name!,
              ),
            ),
            (route) => false);
      }
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    if (e.code == "invalid-email") {
      MessageDialog.showSnackBar("خطأ في البريد المستخدم", context);
    } else if (e.code == "wrong-password") {
      MessageDialog.showSnackBar(
          "البريد المستخذم او كلمة السر غير صحيحة", context);
    } else if (e.code == "user-disabled") {
      MessageDialog.showSnackBar("الحساب موقوف", context);
    } else if (e.code == "user-not-found") {
      MessageDialog.showSnackBar("البريد الالكتورني غير مسجل", context);
    }
  }
}

void providerLogin({
  required String email,
  required String password,
  required List<ProviderData> userList,
  required BuildContext context,
  SnackBar? snackBar,
  GlobalKey? scaffoldKey,
}) async {
  try {
    MessageDialog.showWaitingDialog(context);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    for (var user in userList) {
      if (user.email == email && user.isApproved == true) {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ProviderDashboard(),
          ),
        );
      } else if (user.email == email && user.isApproved == false) {
        Navigator.pop(context);
        MessageDialog.showMessageDialog(
          context,
          message: "الحساب بإنتظار الموافقة",
          buttonTitle: "موافق",
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginProvider(),
              ),
            );
          },
        );
      }
    }
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    if (e.code == "invalid-email") {
      MessageDialog.showSnackBar("خطأ في البريد المستخدم", context);
    } else if (e.code == "wrong-password") {
      MessageDialog.showSnackBar(
          "البريد المستخذم او كلمة السر غير صحيحة", context);
    } else if (e.code == "user-disabled") {
      MessageDialog.showSnackBar("الحساب موقوف", context);
    } else if (e.code == "user-not-found") {
      MessageDialog.showSnackBar("البريد الالكتورني غير مسجل", context);
    }
  }
}
