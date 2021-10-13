import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/seeker_data.dart';

Future<List<SeekerData>> getSeekerData(
  List<SeekerData> data,
) async {
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

Future<SeekerData> getSeekerDataPerInstant({
  required String seekerId,
}) async {
  var _firebase = FirebaseFirestore.instance; // Firebase Connection instant;

  var snapshots = await _firebase
      .collection("seeker")
      .doc(seekerId)
      .get(); //get all data from the collection "seeker" and store it in snapshot

  // loop over all docs in the collection seeker and add it to data list
  return SeekerData(
    email: snapshots["email"],
    gender: snapshots["gender"],
    date: snapshots["dateOfBirth"],
    name: snapshots["name"],
    uid: snapshots["uid"],
    username: snapshots["username"],
    password: snapshots["password"],
  );
}

SeekerData? seekerData1;
void getSeekerDataPerInstant1({
  required String seekerId,
}) {
  var _firebase = FirebaseFirestore.instance; // Firebase Connection instant;
  _firebase.collection("seeker").doc(seekerId).get().then((value) =>
      seekerData1 = SeekerData(
        email: value["email"],
        gender: value["gender"],
        date: value["dateOfBirth"],
        name: value["name"],
        uid: value["uid"],
        username: value["username"],
        password: value["password"],
      )); //get all data from the collection "seeker" and store it in snapshot

  // loop over all docs in the collection seeker and add it to data list
}
