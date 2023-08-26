import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes.dart';
import 'package:grocery_app/screens/cart_screen/singlecard_item.dart';
import 'package:provider/provider.dart';
import '../../firebase_helper/firebase_auth_helper/auth_helper.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../cart_item_checkout/card_item_checkout.dart';
import '../payment/payment.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:  appProvider.getCartProductList.isEmpty ? const Center(
        child: Text("Cart List is Empty"),
      ):
      ListView.builder(
        itemCount: appProvider.getCartProductList.length,
          itemBuilder: (context, index){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleCardItem(singleProduct: appProvider.getCartProductList[index],),
            ),
          );
          }
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Column(
            children: [
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
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  Routes.instance.push(  const CartItemCheckout(), context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
