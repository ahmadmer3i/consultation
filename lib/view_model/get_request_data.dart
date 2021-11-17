import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation/helpers/helper.dart';
import 'package:consultation/models/consult_data.dart';
import 'package:consultation/tools/dio_helper.dart';
import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

var _firebase = FirebaseFirestore.instance;
var _auth = FirebaseAuth.instance;
Stream<List<ConsultData>> get getRequestData {
  List<ProviderConsult> consults = [];
  return _firebase.collection("consults").snapshots().map(
        (event) => event.docs.where((element) {
          if (element.data()["isActive"] == true &&
              element.data()["uid"] == _auth.currentUser!.uid &&
              element.data()["isDeleted"] == false) {
            consults.clear();
            var elements = element.data()["providers"];

            for (var e in elements) {
              if (e["isSent"] == true && e["isApproved"] == false) {
                consults.add(ProviderConsult.fromDatabase(e));
              } else if (e["isApproved"] == true) {
                consults.clear();
                return false;
              }
            }
          } else {
            return false;
          }
          return element.data()["uid"] == _auth.currentUser!.uid;
        }).map(
          (e) {
            return ConsultData(
              providers: consults,
              consultId: e.id,
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
              isActive: e.data()["isActive"],
            );
          },
        ).toList(),
      );
}

void deleteItem(BuildContext context, {required String docId}) {
  MessageDialog.showWaitingDialog(context, message: "يرجى الانتظار");
  FirebaseFirestore.instance.collection("consults").doc(docId).update(
    {"isDeleted": true},
  ).then((value) => Navigator.pop(context));
}

Future<bool> checkConsult() async {
  var snapshot = await _firebase.collection("consults").get();

  for (var doc in snapshot.docs) {
    if ((doc["status"] == "active" || doc["status"] == "pending") &&
        doc["uid"] == _auth.currentUser!.uid &&
        doc["isDeleted"] == false) {
      return false;
    }
  }

  return true;
}

void setPayment(
  BuildContext context, {
  required ProviderConsult providerData,
  required String providerId,
  required String docId,
  required double price,
  required String payment,
}) async {
  var payDate = date.split("/");
  print(payDate[0]);
  DioHelper.dioPost(
    context,
    creditCard: creditCard,
    cvv: cvv,
    name: name,
    year: payDate[1],
    month: payDate[0],
    amount: price,
  ).then((response) {
    if (response.statusCode == 201) {
      print(response.data);
      Navigator.pop(context);
      showCupertinoModalPopup(
        context: context,
        builder: (context) => WebView(
          initialUrl: response.data["source"]["transaction_url"],
          onPageFinished: (url) {
            print(url);
            if (url.contains(response.data["callback_url"])) {
              if (url.contains("failed")) {
                Navigator.pop(context);
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("فشل عملية الدفع"),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("إلغاء"))
                        ],
                      ),
                    ),
                  ),
                );
                return;
              }

              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("تم الدفع بنجاح"),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            MessageDialog.showWaitingDialog(
                              context,
                              message: "جاري عملية الدفع",
                            );
                            var _firebase = FirebaseFirestore.instance;
                            List<dynamic> items = [];
                            int index;
                            var collection = _firebase.collection("consults");
                            var snapshot = await collection.doc(docId).get();
                            items = snapshot.data()!["providers"];
                            index = items.indexWhere((element) =>
                                element["consultId"] == providerId);
                            items[index]["isApproved"] = true;
                            items[index]["status"] = "تم قبول العرض";

                            await _firebase
                                .collection("consults")
                                .doc(docId)
                                .set(
                              {
                                "id": response.data["id"],
                                "amount_format": response.data["amount_format"],
                                ""
                                    "providerId": providerId,
                                "price": price,
                                "status": "active",
                                "payment": response.data["source"]["type"],
                                "creditCard": response.data["source"]["number"],
                                "isPaid": true,
                                "providers": items,
                              },
                              SetOptions(merge: true),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("إلغاء"),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  });
}
