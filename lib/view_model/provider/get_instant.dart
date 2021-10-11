import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> get getInstantData {
  var counter = 0;
  List<Map<String, dynamic>> consults = [];
  return _firebase.collection("consults").snapshots().map(
        (event) => event.docs
            .where((element) {
              if (element.data()["providerId"] != null &&
                  element.data()["providerId"] != _auth.currentUser!.uid) {
                print(element.data()["providerId"]);
                return false;
              }
              element.data()["providers"].forEach(
                (elements) {
                  if (elements["consultId"] == _auth.currentUser!.uid) {
                    consults.add(elements);
                  }
                },
              );
              print(consults);
              if (consults.isNotEmpty) {
                return true;
              }
              return false;
            })
            .map(
              (e) => ConsultData(
                consultId: e.id,
                providers: consults,
                price: double.parse(e.data()["price"].toString()),
                payment: e.data()["payment"],
                isPaid: e.data()["isPaid"],
                uid: e.data()["uid"],
                topic: e.data()["topic"],
                detail: e.data()["details"],
                date: e.data()["date"],
                docId: e.id,
                providerId: e.data()["providerId"],
                isDeleted: e.data()["isDeleted"],
                status: e.data()["status"],
              ),
            )
            .toList(),
      );
}
