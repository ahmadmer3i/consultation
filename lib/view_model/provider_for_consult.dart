import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';

Future<List<ProviderData>> getProviderForTopics(List<ProviderData> data,
    {required String topic}) async {
  var snapshot =
      await FirebaseFirestore.instance.collection(providerCollection).get();

  for (var doc in snapshot.docs) {
    for (var providerTopic in doc["topics"]) {
      if (providerTopic == topic) {
        data.add(
          ProviderData(
            birthOfDate: doc["dateOfBirth"],
            price: double.parse(doc["price"].toString()),
            password: doc["password"],
            email: doc["email"],
            name: doc["name"],
            uid: doc.id,
            isApproved: doc["isApproved"],
            topics: doc["topics"],
          ),
        );
      }
    }
  }

  return data;
}
