import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../model/product_model/product_model.dart';
import '../../provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                onPressed: () {
                  AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                  appProvider.removeFavouriteProduct(widget.singleProduct);
                  showMessage("removed from Favourite");
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
