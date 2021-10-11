import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/provider_data.dart';

Future<ProviderData> getProviderOffer({required String id}) async {
  var snapshot = await FirebaseFirestore.instance
      .collection(providerCollection)
      .doc(id)
      .get();
  return ProviderData(
      rate: double.parse(snapshot.data()!["rate"].toString()),
      password: snapshot.data()!["password"],
      email: snapshot.data()!["email"],
      name: snapshot.data()!["name"],
      uid: snapshot.data()!["uid"],
      isApproved: snapshot.data()!["isApproved"],
      price: double.parse(snapshot.data()!["price"].toString()));
}
