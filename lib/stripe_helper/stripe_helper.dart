import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart'as http;

class StripeHelper{
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;
  Future<bool> makePayment(String amount) async{
    try{
      paymentIntent = await createPaymentIntent(amount, "USD");

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US",
          testEnv: true,
          currencyCode: "USD"
      );

      //initialize Payment sheet

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["Client_secret"],
            style: ThemeMode.light,
            merchantDisplayName: "Alex",
            googlePay: gpay
          )
      ).then((value) { });


      //display payment sheet

      displayPaymentSheet();
      return true;
    }catch(er){
      print(er);
      return false;
    }
  }

  displayPaymentSheet() async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successful");
      });
    }catch(e){
      print(e);
      return false;
    }
  }


  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String, dynamic> body = {
        'amount' : amount,
        'currency' : currency
      };
      var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
      headers: {
        'Authorization' : 'Bearer sk_test51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1Pq',
        'Content-Type' : 'application/x-www-form-urlencoded'
      },
        body: body,
      );
      return jsonDecode(response.body);
    }catch(err){
      throw Exception(err.toString());
    }

  }
}