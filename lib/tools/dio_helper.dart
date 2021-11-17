import 'package:dio/dio.dart';

class DioHelper {
  static Future<Response> dioPost(context,
      {required String creditCard,
      required String cvv,
      required String name,
      required year,
      required month,
      required double amount}) {
    var dio = Dio();
    return dio.post("https://api.moyasar.com/v1/payments", queryParameters: {
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
    });
  }
}
