import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Future<Stream<List<ConsultData>>>?
Stream<List<ConsultData>> get getRequestData
// Stream<List<ConsultData>> data
{
  var firebase = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  return firebase.collection("consults").snapshots().map((event) => event.docs
      .where((element) =>
          element.data()["uid"] == auth.currentUser!.uid &&
          element.data()["isDeleted"] == false)
      .map((e) => ConsultData(
          docId: e.id,
          uid: e.data()["uid"],
          topic: e.data()["topic"],
          detail: e.data()["details"],
          date: e.data()["date"]))
      .toList());

  // for (var doc in snapshotConsult.docs) {
  //   if (doc["uid"] == auth.currentUser!.uid) {
  //     data.add(
  //       ConsultData(
  //         uid: doc['uid'],
  //         topic: doc['topic'],
  //         detail: doc['details'],
  //         date: doc['date'],
  //       ),
  //     );
  //   }
  // }
  // return snapshotC;
}

void deleteItem({required String docId}) {
  FirebaseFirestore.instance.collection("consults").doc(docId).update(
    {"isDeleted": true},
  );
}
