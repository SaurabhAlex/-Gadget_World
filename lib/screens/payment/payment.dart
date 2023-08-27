import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes.dart';
import 'package:grocery_app/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:grocery_app/model/product_model/product_model.dart';
import 'package:grocery_app/screens/bottom_navBar/bottom_nav_bar.dart';
import 'package:grocery_app/screens/payment/upi_payment.dart';
import 'package:grocery_app/stripe_helper/stripe_helper.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class PaymentScreen extends StatefulWidget {
  final ProductModel singleProduct;
  const PaymentScreen({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    int groupValue = 2 ;
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
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
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
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
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
              onPressed: ( ) async{
              appProvider.clearBuyProduct();
              appProvider.addBuyProduct(widget.singleProduct);

              if(groupValue == 1){
                bool value = await FirestoreHelper.instance.uploadOrderedProductFirebase(
                    appProvider.getBuyProductList, context,  "Cash on delivery"
                );
                appProvider.clearBuyProduct();
                if(value){
                  Future.delayed(const Duration(seconds: 2), () {
                    Routes.instance.push(const BottomNavBar(), context);
                  });
                }
              }else{
                int value = double.parse(appProvider.totalPriceBuyProductList().toString()).round().toInt();
                String totalPrice = (value * 100).toString();
                await StripeHelper.instance.makePayment(totalPrice.toString(), context);
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
                Routes.instance.push( UpiPayment(), context);
              },
            )
          ],
        ),
      ),
    );
  }
}
