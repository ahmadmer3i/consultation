import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/seeker_data.dart';

Future<SeekerData> getSeekerOffer({required String id}) async {
  var snapshot = await FirebaseFirestore.instance
      .collection(seekerCollection)
      .doc(id)
      .get();
  return SeekerData(
      email: snapshot["email"],
      gender: snapshot["gender"],
      date: snapshot["dateOfBirth"],
      name: snapshot["name"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      password: snapshot["password"]);
}
