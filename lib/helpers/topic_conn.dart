import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

void saveConsult({
  required String topic,
  required String details,
}) async {
  var id = const Uuid().v1();
  var _firestore = FirebaseFirestore.instance;
  var snapshots = await _firestore
      .collection("provider")
      .where("instant", isEqualTo: true)
      .get();
  List<Map<String, dynamic>> consults = [];
  for (var docs in snapshots.docs) {
    for (var doc in docs["topics"]) {
      if (doc == topic) {
        consults.add({
          "consultId": docs.id,
          "isApproved": false,
          "price": 0,
          "status": "قيد الدراسة",
          "isSent": false,
          "isDeleted": false,
        });
      }
    }
  }

  await _firestore.collection("consults").doc(id).set(
    {
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "topic": topic,
      "details": details,
      "isActive": true,
      "isDeleted": false,
      "date": DateTime.now(),
      "consultId": id,
      "status": "pending",
      "payment": "",
      "isPaid": false,
      "price": 0,
      "isDeletedProvider": false,
      "providerId": null,
      "providers": consults,
    },
  );
}
