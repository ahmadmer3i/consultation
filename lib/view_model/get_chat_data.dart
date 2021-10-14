import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> getChatData({required String status}) {
  List<ProviderConsult> consults = [];
  // var consultsData = _firebase
  //     .collection("consults")
  //     .where("uid" == _auth.currentUser!.uid && "status" == "approved")
  //     .get()
  //     .then((value) => value.docs
  //         .where((element) => element.data()["providers"] != null))
  //     .then(
  //       (value) => value.forEach(
  //         (element) {
  //           consults.add(element.data()["providers"]);
  //         },
  //       ),
  //     );
  // print(consults.length);
  var data = _firebase
      .collection("consults")
      .orderBy("date", descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .where((element) {
              if (element.data()["status"] == status) {
                var elements = element.data()["providers"];
                // consults = [];
                for (var e in elements) {
                  if (e["isApproved"] == true &&
                      e["status"] == "تم قبول العرض") {
                    consults.clear();
                    break;
                  } else if (e["status"] == "تم ارسال العرض") {
                    consults.add(ProviderConsult.fromDatabase(e));
                  }
                }
              } else {
                consults.clear();
                return false;
              }

              return element.data()["uid"] == _auth.currentUser!.uid;
            })
            .map(
              (e) => ConsultData(
                providers: consults,
                price: double.parse(e.data()["price"].toString()),
                payment: e.data()["payment"],
                isPaid: e.data()["isPaid"],
                uid: e.data()["uid"],
                topic: e.data()["topic"],
                detail: e.data()["details"],
                date: e.data()["date"],
                docId: e.id,
                consultId: e.id,
                isDeleted: e.data()["isDeleted"],
                status: e.data()["status"],
                providerId: e.data()["providerId"],
                isActive: e.data()["isActive"],
              ),
            )
            .toList(),
      );

  return data;
}
