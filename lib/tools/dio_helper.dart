import 'package:consultation/helpers/helper.dart';
import 'package:consultation/seeker/dashboard_seeker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DioHelper {
  static void dioPost(context) {
    var dio = Dio();
    dio.post("https://api.moyasar.com/v1/payments", queryParameters: {
      "source[number]": 4111111111111111,
      "source[cvc]": 111,
      "source[year]": 2022,
      "source[month]": 12,
      "source[name]": "Ahmad Merie",
      "source[type]": "creditcard",
      "publishable_api_key": "pk_test_cBd1WuRPEiiLSa47UzwRmY8wvDpeTWMh7K7yd4eo",
      "amount": 60000,
      "currency": "SAR",
      "callback_url": "https://example.com",
    }).then(
      (value) async {
        if (value.statusCode == 200) {
          print(value.data);
        } else if (value.statusCode == 201) {
          print(value.data);
          Navigator.pop(context);
          showBottomSheet(
            context: context,
            builder: (context) => WebView(
              initialUrl: value.data["source"]["transaction_url"],
              onPageFinished: (url) {
                if (url.contains(value.data["callback_url"])) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardSeeker(
                                username: currentUsername,
                              )),
                      (route) => false);
                }
              },
            ),
          );
        }
      },
    );
  }
}