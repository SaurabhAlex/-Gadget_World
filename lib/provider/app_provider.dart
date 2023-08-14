import 'package:flutter/material.dart';

import '../model/product_model/product_model.dart';

class AppProvider with ChangeNotifier{
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

}