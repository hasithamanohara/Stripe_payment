import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio dio = Dio();

Future createPayment(
    {required String amount,
    required String currency,
    required String description}) async {
  try {
    var url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final securityKey = dotenv.env['STRIPE_SECRET_KEY']!;
    final body = {
      'amount': amount,
      'currency': currency.toLowerCase(),
      'description': description,
    };

    final Response response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(headers: {
        'Authorization': 'Bearer $securityKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      }),
      data: {
        'amount': '100',
        'currency': 'usd',
        'description': 'test description',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final ResponseJson = (response.data);
      print(ResponseJson);
      return ResponseJson;
    } else {
      print("error: " + response.statusCode.toString());
    }
  } catch (e) {
    print(e);
    print("create payment error");
  }
}
