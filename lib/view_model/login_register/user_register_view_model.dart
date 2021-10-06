import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void seekerRegister({
  required String email,
  required String password,
  required String name,
  required String username,
  required String dateOfBirth,
  required String gender,
  required context,
}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection(seekerCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        "email": email,
        "password": password,
        "name": name,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "username": username,
        "uid": FirebaseAuth.instance.currentUser!.uid,
      },
    );
    currentUsername = name;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DashboardSeeker(
          username: name,
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {}
}

void providerRegister(
    {required String name,
    required String password,
    required String email,
    required double price,
    required String iban,
    required String experience,
    required String gender,
    required String username,
    required String dob,
    required bool instant,
    required bool scheduled,
    required String bank,
    required List<String> topics,
    required BuildContext context,
    required}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection(providerCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid) // uid of the user
        .set(
      {
        "email": email,
        "password": password,
        "name": name,
        "dateOfBirth": dob,
        "gender": gender,
        "username": username,
        "bankName": bank,
        "iban": iban,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "scheduled": scheduled,
        "instant": instant,
        "experience": experience,
        "price": price,
        "topics": topics,
        "isApproved": false,
      },
    );
    currentUsername = name;
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginProvider(),
      ),
    );
  } on FirebaseAuthException catch (e) {}
}
