import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart_screen/singlecard_item.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
              child: SingleCardItem(singleProduct: appProvider.getCartProductList[index],)
            ),
          );
          }
      ),
    );
  }
}
