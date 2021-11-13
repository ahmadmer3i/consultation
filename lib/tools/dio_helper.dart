import 'package:consultation/helpers/helper.dart';
import 'package:consultation/seeker/dashboard_seeker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DioHelper {
  static void dioPost(context,
      {required String creditCard,
      required String cvv,
      required String name,
      required year,
      required month,
      required double amount}) {
    print("cvv: $cvv");
    print("year: $year");
    print("name: $currentUsername");
    print("month: $month");
    print("credit card: $creditCard");
    print("amount $amount");
    var dio = Dio();
    dio.post("https://api.moyasar.com/v1/payments", queryParameters: {
      "source[number]": creditCard,
      "source[cvc]": cvv,
      "source[year]": year,
      "source[month]": month,
      "source[name]": name,
      "source[type]": "creditcard",
      "publishable_api_key": "pk_test_cBd1WuRPEiiLSa47UzwRmY8wvDpeTWMh7K7yd4eo",
      "amount": (amount * 100).toStringAsFixed(0),
      "currency": "SAR",
      "callback_url": "https://example.com",
    }).then(
      (value) async {
        print(value.statusCode);
        if (value.statusCode == 400) {
          print(value.data);
        } else if (value.statusCode == 201) {
          print(value.data);
          Navigator.pop(context);
          showBottomSheet(
            context: context,
            builder: (context) => WebView(
              initialUrl: value.data["source"]["transaction_url"],
              onPageFinished: (url) {
                print(url);
                if (url.contains(value.data["callback_url"])) {
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
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashboardSeeker(
                                              username: currentUsername,
                                            )),
                                    (route) => false);
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
      },
    );
  }
}
