import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Stream<List<ConsultData>> get getRequestData {
  var firebase = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  return firebase.collection("consults").snapshots().map((event) => event.docs
      .where(
        (element) =>
            element.data()["uid"] == auth.currentUser!.uid &&
            element.data()["isDeleted"] == false,
      )
      .map((e) => ConsultData(
          docId: e.id,
          uid: e.data()["uid"],
          isDeleted: e.data()["isDeleted"],
          topic: e.data()["topic"],
          detail: e.data()["details"],
          date: e.data()["date"]))
      .toList());
}

void deleteItem(BuildContext context, {required String docId}) {
  MessageDialog.showWaitingDialog(context, message: "يرجى الانتظار");
  FirebaseFirestore.instance.collection("consults").doc(docId).update(
    {"isDeleted": true},
  ).then((value) => Navigator.pop(context));
}
