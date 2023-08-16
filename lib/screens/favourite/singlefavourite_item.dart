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
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple, width: 1.2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(widget.singleProduct.image,
            height: 150,
            width: 100,),
          Column(
            children: [
              Text( widget.singleProduct.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
              Text("Price \$${widget.singleProduct.price}"),
              // TextButton(onPressed: () {}, child: const Text("Add to Cart")),
              ElevatedButton.icon(
                onPressed: () {
                  ProductModel productModel = widget.singleProduct.copyWith(qty: qty);
                  appProvider.addCartProduct(productModel);
                  showMessage("Added to Cart");
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                  backgroundColor: Colors.purple
                  ),
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 24.0,
                ),
                label: const Text('Add to cart'),
              ),
            ],
          ),
          CupertinoButton(
            onPressed: () {
              AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
              appProvider.removeFavouriteProduct(widget.singleProduct);
              showMessage("removed from Favourite");
            },
            child: const CircleAvatar(
              maxRadius: 16,
              backgroundColor: Color(0xffF13B38),
              child: Icon(Icons.delete, size: 19,color: Colors.white,),
            ),
          ),

        ],

      ),
    );
  }
}
