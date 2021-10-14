import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> get getRequestData {
  List<ProviderConsult> consults = [];
  return _firebase.collection("consults").snapshots().map(
        (event) => event.docs.where((element) {
          if (element.data()["isActive"] == true &&
              element.data()["isDeleted"] == false) {
            consults.clear();
            var elements = element.data()["providers"];

            for (var e in elements) {
              if (e["isSent"] == true && e["isApproved"] == false) {
                consults.add(ProviderConsult.fromJson(e));
              } else if (e["isApproved"] == true) {
                consults.clear();
                return false;
              }
            }
          } else {
            return false;
          }
          return element.data()["uid"] == _auth.currentUser!.uid;
        }).map(
          (e) {
            return ConsultData(
              providers: consults,
              consultId: e.id,
              price: double.parse(e.data()["price"].toString()),
              payment: e.data()["payment"],
              isPaid: e.data()["isPaid"],
              uid: e.data()["uid"],
              topic: e.data()["topic"],
              detail: e.data()["details"],
              date: e.data()["date"],
              docId: e.id,
              isDeleted: e.data()["isDeleted"],
              status: e.data()["status"],
              isActive: e.data()["isActive"],
            );
          },
        ).toList(),
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
  required ProviderConsult providerData,
  required String providerId,
  required String docId,
  required double price,
  required String payment,
}) async {
  MessageDialog.showWaitingDialog(context, message: "جاري عملية الدفع");
  var _firebase = FirebaseFirestore.instance;
  List<dynamic> items = [];
  int index;
  var collection = _firebase.collection("consults");
  var snapshot = await collection.doc(docId).get();
  items = snapshot.data()!["providers"];
  index = items.indexWhere((element) => element["consultId"] == providerId);
  items[index]["isApproved"] = true;
  items[index]["status"] = "تم قبول العرض";

  await _firebase.collection("consults").doc(docId).set(
    {
      "providerId": providerId,
      "price": price,
      "status": "active",
      "payment": payment,
      "isPaid": true,
      "providers": items,
    },
    SetOptions(merge: true),
  );
  Navigator.pop(context);
  Navigator.pop(context);
}
