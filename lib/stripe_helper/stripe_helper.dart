import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/provider/app_provider.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../firebase_helper/firestore_helper/firestore_helper.dart';
import '../screens/bottom_navBar/bottom_nav_bar.dart';

class StripeHelper{
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(String amount, BuildContext context) async{
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

      displayPaymentSheet(context);

    }catch(er){
      showMessage("This Feature is Under maintenance");
      print(er.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async{
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try{
      await Stripe.instance.presentPaymentSheet().then((value) async{
          bool value = await FirestoreHelper.instance.uploadOrderedProductFirebase(
              appProvider.getBuyProductList, context, "Paid"
          );
          appProvider.clearBuyProduct();
          if(value){
            Future.delayed(const Duration(seconds: 2), () {
              Routes.instance.push(const BottomNavBar(), context);
            });
          }

      });
    }catch(e){
      showMessage(e.toString());
      print(e);
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