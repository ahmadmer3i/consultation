import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void saveConsult({
  required String topic,
  required String details,
}) async {
  var _firestore = FirebaseFirestore.instance;

  await _firestore.collection("consults").doc().set(
    {
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "topic": topic,
      "details": details,
      "date": DateTime.now(),
    },
  );
}
