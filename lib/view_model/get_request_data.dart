import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> get getRequestData {
  return _firebase.collection("consults").snapshots().map(
        (event) => event.docs
            .where(
              (element) =>
                  element.data()["uid"] == _auth.currentUser!.uid &&
                  element.data()["isDeleted"] == false &&
                  (element.data()["status"] == "active" ||
                      element.data()["status"] == "pending"),
            )
            .map(
              (e) => ConsultData(
                docId: e.id,
                price: e.data()["price"],
                providerId: e.data()["providerId"],
                uid: e.data()["uid"],
                isDeleted: e.data()["isDeleted"],
                payment: e.data()["payment"],
                isPaid: e.data()["isPaid"],
                topic: e.data()["topic"],
                detail: e.data()["details"],
                date: e.data()["date"],
                status: e.data()["status"],
              ),
            )
            .toList(),
      );
}

void deleteItem(BuildContext context, {required String docId}) {
  MessageDialog.showWaitingDialog(context, message: "يرجى الانتظار");
  FirebaseFirestore.instance.collection("consults").doc(docId).update(
    {"isDeleted": true},
  ).then((value) => Navigator.pop(context));
}

Future<bool> checkConsult() async {
  var snapshot = await _firebase.collection("consults").get();

  for (var doc in snapshot.docs) {
    if ((doc["status"] == "active" || doc["status"] == "pending") &&
        doc["uid"] == _auth.currentUser!.uid &&
        doc["isDeleted"] == false) {
      return false;
    }
  }

  return true;
}

void setPayment(
  BuildContext context, {
  required String providerId,
  required String docId,
  required double price,
  required String payment,
}) async {
  MessageDialog.showWaitingDialog(context, message: "جاري عملية الدفع");
  await _firebase.collection("consults").doc(docId).set(
    {
      "providerId": providerId,
      "price": price,
      "status": "pending",
      "payment": payment,
      "isPaid": false,
    },
    SetOptions(merge: true),
  );
  Navigator.pop(context);
}
