import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<ConsultData>> getRequestData(List<ConsultData> data) async {
  var firebase = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  var snapshotConsult = await firebase.collection("consults").get();

  for (var doc in snapshotConsult.docs) {
    if (doc["uid"] == auth.currentUser!.uid) {
      data.add(
        ConsultData(
          uid: doc['uid'],
          topic: doc['topic'],
          detail: doc['details'],
          date: doc['date'],
        ),
      );
    }
  }
  return data;
}
