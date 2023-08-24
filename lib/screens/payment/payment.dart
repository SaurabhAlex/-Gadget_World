import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes.dart';
import 'package:grocery_app/screens/payment/upi_payment.dart';
import 'package:grocery_app/stripe_helper/stripe_helper.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    int? _groupValue = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 22,),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3.0
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        _groupValue = value;
                      });
                    },
                  ),
                  const Icon(Icons.money, size: 22,),
                  const SizedBox(width: 5,),
                  const Text("Cash on Delivery", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3.0
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (value){
                      setState(() {
                        // groupValue = value;
                      });
                    },
                  ),
                  const Icon(Icons.money, size: 22,),
                  const SizedBox(width: 5,),
                  const Text("Pay Online", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            const SizedBox(height: 24,),
            PrimaryButton(
                title: "Continue",
                onPressed: () async{
                  double totalPrice = appProvider.totalPrice() * 100;
                  bool isSuccessfullyPayment = await StripeHelper.instance.makePayment(totalPrice.toString());
                  if(isSuccessfullyPayment){
                    // bool value = await FirebaseFirestore.instance.
                  }
                },
            ),
            const Spacer(),
            Row(
              children: [
                const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const Spacer(),
                Text('\u{20B9}${appProvider.totalPrice()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 25,),
            PrimaryButton(
              title: "Checkout",
              onPressed: () {
                Routes.instance.push( UPIPayment(finalTotalPrice: '\u{20B9}${appProvider.totalPrice()}',), context);
              },
            )
          ],
        ),
      ),
    );
  }
}
