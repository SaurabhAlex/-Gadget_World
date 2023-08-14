import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/product_model/product_model.dart';
import '../../model/category_model/category_model.dart';

class FirestoreHelper {
  static FirestoreHelper instance = FirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();

      print(categoriesList);
      return categoriesList;
    }catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return productModelList;
    }catch (e) {
      showMessage(e.toString());
      return [];
    }

  }

  Future<List<ProductModel>> getCategoryViewProducts(String id) async{
    try{
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("categories").doc(id).collection("products").get();

      List<ProductModel> productModelList = querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      return productModelList;
    }catch (e) {
      showMessage(e.toString());
      return [];
    }

  }
}