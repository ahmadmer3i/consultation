import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/topic.dart';

Future<List<Topic>> getTopicsData(List<Topic> data) async {
  var _firebase = FirebaseFirestore.instance;

  var snapshot = await _firebase.collection("topics").get();

  for (var doc in snapshot.docs) {
    data.add(
      Topic(
        image: doc["image"],
        title: doc["title"],
      ),
    );
  }

  return data;
}
