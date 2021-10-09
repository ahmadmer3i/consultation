import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateInstantStatus(
    {required docId, required data, required price, required isSent}) async {
  var _firebase = FirebaseFirestore.instance;
  List<dynamic> items = [];
  var _auth = FirebaseAuth.instance;
  int index;
  var collection = _firebase.collection("consults");
  var snapshot = await collection.doc(docId).get();
  items = snapshot.data()!["providers"];
  print("items $items");
  index = items
      .indexWhere((element) => element["consultId"] == _auth.currentUser!.uid);
  items[index]["price"] = price;
  items[index]["status"] = "تم ارسال العرض";
  items[index]["isSent"] = true;
  print(items);
  _firebase
      .collection("consults")
      .doc(docId)
      .set({"providers": items}, SetOptions(merge: true));
}
