import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/product_model/product_model.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class SingleCardItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCardItem({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<SingleCardItem> createState() => _SingleCardItemState();
}

class _SingleCardItemState extends State<SingleCardItem> {
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple, width: 1.2)
      ),
      child: Row(
        children: [
          Image.network(widget.singleProduct.image,
            height: 150,
            width: 100,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text( widget.singleProduct.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
              Text("Price \$${widget.singleProduct.price}"),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        if(qty>=2){
                          qty--;
                        }
                      });
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 2,),
                  Text(qty.toString(), style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  const SizedBox(width: 2,),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                  onPressed: () {
                    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                    appProvider.removeCartProduct(widget.singleProduct);
                    showMessage("remove from Cart");
                  },
                child: const CircleAvatar(
                  maxRadius: 12,
                  child: Icon(Icons.delete, size: 16,),
                ),
              ),
            ],
          )
        ],
        
      ),
    );
  }
}
