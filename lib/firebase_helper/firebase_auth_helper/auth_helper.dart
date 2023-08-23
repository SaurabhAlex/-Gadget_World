import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/model/user_model/user_model.dart';


class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(String email, String password,
      BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showMessage(error.code.toString());
      return false;
    }
  }

  // Future<bool> signUp(String email, String password,
  //     BuildContext context) async {
  //   try {
  //     showLoaderDialog(context);
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     Navigator.pop(context);
  //     return true;
  //   } on FirebaseAuthException catch (error) {
  //     Navigator.pop(context);
  //     showMessage(error.code.toString());
  //     return false;
  //   }

    Future<bool> signUp(String name, String email, String password, BuildContext context) async{
      try{
        showLoaderDialog(context);
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        UserModel userModel = UserModel(id: userCredential.user!.uid, name: name, email: email, image: null);

        _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
        Navigator.pop(context);
        return true;
      }on FirebaseAuthException catch (error){
        Navigator.pop(context);
        showMessage(error.code.toString());
        return false;
      }
    }



      void signOut() async{
        await _auth.signOut();
      }


  Future<bool> changePassword( String password, BuildContext context) async{
    try{
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      // UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // UserModel userModel = UserModel(id: userCredential.user!.uid, name: name, email: email, image: null);
      //
      // _firestore.collection("users").doc(userModel.id).set(userModel.toJson());

      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Password changed");
      Navigator.pop(context);
      return true;
    }on FirebaseAuthException catch (error){
      Navigator.pop(context);
      showMessage(error.code.toString());
      return false;
    }
  }

}