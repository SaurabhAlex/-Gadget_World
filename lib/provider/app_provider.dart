import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_helper/firestore_helper/firestore_helper.dart';
import '../model/product_model/product_model.dart';
import '../model/user_model/user_model.dart';

class AppProvider with ChangeNotifier{

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;
  final List<ProductModel> _cartProductList = [];


  void addCartProduct(ProductModel productModel){
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel){
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;



  final List<ProductModel> _favouriteProductList = [];
  void addFavouriteProduct(ProductModel productModel){
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel){
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

//user information

  void getUserInfoFirebase() async{
    _userModel = await FirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

//total Price
  double totalPrice() {
    double totalPrice = 0.0;
    for(var element in _cartProductList){
      totalPrice += element.price*element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty){
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  void addBuyProduct(ProductModel model){

  }

}



