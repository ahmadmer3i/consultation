import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/provider_data.dart';

Future<List<ProviderData>> getProviderData(List<ProviderData> data) async {
  var _firebase = FirebaseFirestore.instance;

  var snapshot = await _firebase.collection("provider").get();

  for (var doc in snapshot.docs) {
    data.add(
      ProviderData(
        price: doc["price"] as double,
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
