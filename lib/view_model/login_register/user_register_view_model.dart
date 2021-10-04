import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/Provider/provider_dashboard.dart';
import 'package:consultation/Seeker/dashboard_seeker.dart';
import 'package:consultation/helpers/helper.dart';
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
        .collection("seeker")
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
    {required name,
    required password,
    required email,
    required price,
    required iban,
    required experience,
    required gender,
    required username,
    required dob,
    required instant,
    required scheduled,
    required bank,
    required List<String> topics,
    required context,
    required}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection("provider")
        .doc(FirebaseAuth.instance.currentUser?.uid)
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
      },
    );
    currentUsername = name;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProviderDashboard(),
      ),
    );
  } on FirebaseAuthException catch (e) {}
}
