import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/seeker_data.dart';

Future<List<SeekerData>> getSeekerData(List<SeekerData> data) async {
  var _firebase = FirebaseFirestore.instance; // Firebase Connection instant;

  var snapshots = await _firebase
      .collection("seeker")
      .get(); //get all data from the collection "seeker" and store it in snapshot

  for (var doc in snapshots.docs) {
    // loop over all docs in the collection seeker and add it to data list
    data.add(
      SeekerData(
        email: doc["email"],
        gender: doc["gender"],
        date: doc["dateOfBirth"],
        name: doc["name"],
        uid: doc["uid"],
        username: doc["username"],
        password: doc["password"],
      ),
    );
  }
  return data; // it will return data of type Future<List<SeekerData>>
}
