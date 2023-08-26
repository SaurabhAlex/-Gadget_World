import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:grocery_app/model/order_model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}



class _OrderScreenState extends State<OrderScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Screen",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.data!.isEmpty ||snapshot.data == null || !snapshot.hasData){
            return const Center(child: Text("No Order Yet!"),);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
              OrderModel orderModel = snapshot.data![index];
              return ExpansionTile(
                title: Text(
                  orderModel.payment,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      orderModel.status,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              );
              }
          );
        },
      ),
    );
  }
}
