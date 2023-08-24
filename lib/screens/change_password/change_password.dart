import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/firebase_helper/firebase_auth_helper/auth_helper.dart';
import '../../widgets/primary_button/primary_button.dart';

class ChangePasswordSC extends StatefulWidget {
  const ChangePasswordSC({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSC> createState() => _ChangePasswordSCState();
}

class _ChangePasswordSCState extends State<ChangePasswordSC> {
  @override
  Widget build(BuildContext context) {
    TextEditingController newPassword = TextEditingController();
    TextEditingController cPassword = TextEditingController();
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
              controller: newPassword,
              obscureText: isShowPassword,
              decoration: const InputDecoration(
                hintText: "New Password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 22,),
            TextFormField(
              controller: cPassword,
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
                if(newPassword.text.isEmpty){
                  showMessage("Password can not be empty!");
                }else if(cPassword.text.isEmpty){
                  showMessage("Confirm Password is Required!");
                }else if(newPassword.text == cPassword.text){
                  FirebaseAuthHelper.instance.changePassword(newPassword.text, context);
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
