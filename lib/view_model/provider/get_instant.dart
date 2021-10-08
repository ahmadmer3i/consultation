import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> get getInstantData {
  return _firebase.collection("consults").snapshots().map(
        (event) => event.docs
            .where((element) =>
                element.data()["providerId"] == _auth.currentUser!.uid)
            .map(
              (e) => ConsultData(
                providerId: e.data()["providerId"],
                price: double.parse(e.data()["price"].toString()),
                payment: e.data()["payment"],
                isPaid: e.data()["isPaid"],
                uid: e.data()["uid"],
                topic: e.data()["topic"],
                detail: e.data()["details"],
                date: e.data()["date"],
                docId: e.id,
                status: e.data()["status"],
              ),
            )
            .toList(),
      );
}
