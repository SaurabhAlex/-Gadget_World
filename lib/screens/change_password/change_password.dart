import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/firebase_helper/firebase_auth_helper/auth_helper.dart';

import '../../model/user_model/user_model.dart';
import '../../widgets/primary_button/primary_button.dart';

class ChangePasswordSC extends StatefulWidget {
  const ChangePasswordSC({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSC> createState() => _ChangePasswordSCState();
}

class _ChangePasswordSCState extends State<ChangePasswordSC> {
  @override
  Widget build(BuildContext context) {
    TextEditingController newpassword = TextEditingController();
    TextEditingController cpassword = TextEditingController();
    bool isShowPassword = true;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:const Text("Change Password",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body:ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            TextFormField(
              controller: newpassword,
              obscureText: isShowPassword,
              decoration: const InputDecoration(
                  hintText: "New Password",
                  prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 22,),
            TextFormField(
              controller: cpassword,
              obscureText: isShowPassword,
              decoration: const InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 22,),
            PrimaryButton(
              title: "Update",
              onPressed: () async{
                if(newpassword.text.isEmpty){
                  showMessage("Password can not be empty!");
                }else if(cpassword.text.isEmpty){
                  showMessage("Confirm Password is Required!");
                }else if(newpassword.text == cpassword.text){
                  FirebaseAuthHelper.instance.changePassword(newpassword.text, context);
                }else{
                showMessage("Confirm password is not matching!");
                }
              },
            )
          ],
        )

    );
  }
}
