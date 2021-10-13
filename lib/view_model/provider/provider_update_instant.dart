import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateInstantStatus(
    {required docId,
    required data,
    required double price,
    required isSent}) async {
  var _firebase = FirebaseFirestore.instance;
  List<ProviderConsult> items = [];
  var _auth = FirebaseAuth.instance;
  int index;
  var collection = _firebase.collection("consults");
  var snapshot = await collection.doc(docId).get();
  for (var e in snapshot.data()!["providers"]) {
    items.add(ProviderConsult.fromJson(e));
  }
  index = items
      .indexWhere((element) => element.consultId == _auth.currentUser!.uid);
  items[index].price = price;
  items[index].status = "تم ارسال العرض";
  items[index].isSent = true;
  List<Map<String, dynamic>> updatedItems = [];
  for (var element in items) {
    updatedItems.add(element.toMap());
    print(element);
  }
  _firebase.collection("consults").doc(docId).set({"providers": updatedItems},
      SetOptions(merge: true)).onError((error, stackTrace) => print(error));
}
