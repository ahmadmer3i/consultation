import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<List<ConsultData>> getChatDataProvider({required String status}) {
  var firebase = FirebaseFirestore.instance;
  List<Map<String, dynamic>> consults = [];
  bool isExist = false;
  var data = firebase.collection("consults").snapshots().map(
        (event) => event.docs
            .where((element) {
              print(element.data()["status"]);
              isExist = element.data()["providerId"] ==
                      FirebaseAuth.instance.currentUser!.uid &&
                  element.data()["status"] == status;
              if (isExist) {
                for (var item in element.data()["providers"]) {
                  consults.add(item);
                }
                print(consults);
                return true;
              } else {
                return false;
              }
              // &&
              // element.data()["status"] == "active";
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
                isDeleted: e.data()["isDeleted"],
                status: e.data()["status"],
                providerId: e.data()["providerId"],
              ),
            )
            .toList(),
      );
  print("data: $data");
  return data;
}
