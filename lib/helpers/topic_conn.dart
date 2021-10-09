import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void saveConsult({
  required String topic,
  required String details,
}) async {
  var _firestore = FirebaseFirestore.instance;
  var snapshots = await _firestore
      .collection("provider")
      .where("instant", isEqualTo: true)
      .get();
  print(snapshots.docs);
  List<Map<String, dynamic>> consults = [];
  for (var docs in snapshots.docs) {
    for (var doc in docs["topics"]) {
      if (doc == topic) {
        consults.add({
          "consultId": docs.id,
          "isApproved": false,
          "price": 0,
          "status": "قيد الدراسة"
        });
      }
    }
  }

  await _firestore.collection("consults").doc().set(
    {
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "topic": topic,
      "details": details,
      "isDeleted": false,
      "date": DateTime.now(),
      "status": "pending",
      "payment": "",
      "isPaid": false,
      "price": 0,
      "providerId": null,
      "providers": consults,
    },
  );
}
