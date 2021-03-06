import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/provider_data.dart';

Future<List<ProviderData>> getProviderData(List<ProviderData> data) async {
  var _firebase = FirebaseFirestore.instance;

  var snapshot = await _firebase.collection("provider").get();

  for (var doc in snapshot.docs) {
    data.add(
      ProviderData(
        // topics: doc["topics"] as List<String>,
        birthOfDate: doc["dateOfBirth"],
        rate: double.parse(doc["rate"].toString()),
        price: double.parse(doc["price"].toString()),
        password: doc["password"],
        email: doc["email"],
        name: doc["name"],
        uid: doc["uid"],
        isApproved: doc["isApproved"],
      ),
    );
  }
  return data;
}
