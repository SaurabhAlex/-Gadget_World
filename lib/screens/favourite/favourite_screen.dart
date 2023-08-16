import 'package:flutter/material.dart';
import 'package:grocery_app/screens/favourite/singlefavourite_item.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Screen",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
      ),
      body:  appProvider.getFavouriteProductList.isEmpty ? const Center(
        child: Text("Favourite List is Empty"),
      ):
      ListView.builder(
          itemCount: appProvider.getFavouriteProductList.length,
          itemBuilder: (context, index){
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleFavouriteItem(singleProduct: appProvider.getFavouriteProductList[index],)
              ),
            );
          }
      ),
    );
  }
}

