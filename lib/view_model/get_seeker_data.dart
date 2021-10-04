import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/seeker_data.dart';

Future<List<SeekerData>> getSeekerData(List<SeekerData> data) async {
  var _firebase = FirebaseFirestore.instance;

  var snapshots = await _firebase.collection("seeker").get();

  for (var doc in snapshots.docs) {
    data.add(
      SeekerData(
        email: doc["email"],
        gender: doc["gender"],
        date: doc["dateOfBirth"],
        name: doc["name"],
        // uid: doc["uid"],
        username: doc["username"],
        password: doc["password"],
      ),
    );
  }
  return data;
}
