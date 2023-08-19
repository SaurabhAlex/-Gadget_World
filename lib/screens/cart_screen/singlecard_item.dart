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

  @override
  void initState() {
   qty = widget.singleProduct.qty??0;
   setState(() {

   });
    super.initState();
  }
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple, width: 1.2)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Text("Price: \u{20B9}${widget.singleProduct.price}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),),
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        setState(() {
                          if(qty>=2){
                            qty--;
                          }
                        });
                        appProvider.updateQty(widget.singleProduct, qty);
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
                        appProvider.updateQty(widget.singleProduct, qty);
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
            CupertinoButton(
              onPressed: () {
                  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                  appProvider.removeCartProduct(widget.singleProduct);
                  showMessage("remove from Cart");
              },
              child: const CircleAvatar(
                maxRadius: 16,
                backgroundColor: Color(0xffF13B38),
                child: Icon(Icons.delete, size: 19,color: Colors.white,),
              ),
            ),
          ],

        ),
      ),
    );

  }
}
