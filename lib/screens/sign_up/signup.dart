import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/login/login.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:grocery_app/widgets/top_title/top_title.dart';

import '../../constants/constants.dart';
import '../../firebase_helper/firebase_auth_helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController password = TextEditingController();
    bool isShowPassword = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const TopTitle(title: "Create Account", subtitle: "create an account"),
                const SizedBox(height: 32,),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person)
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "E-mail",
                      prefixIcon: Icon(Icons.email_rounded)
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Phone",
                      prefixIcon: Icon(Icons.call)
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: password,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                      hintText: "Create Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: CupertinoButton(
                          padding: const EdgeInsets.all(2),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                              print(isShowPassword);
                            });
                          },
                          child: const Icon(Icons.visibility)
                      )
                  ),
                ),
                const SizedBox(height: 26,),
                PrimaryButton(
                  title: "CREATE ACCOUNT",
                  onPressed: ()  async{
                    bool isValidated =  signUpValidation(name.text, email.text,phone.text, password.text);
                    if(isValidated){
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(email.text, password.text, context);
                      if(isLogined){
                        Routes.instance.pushAndRemovedUntil(HomeScreen(), context);
                      }
                    }
                  },
                ),
                const SizedBox(height: 26,),
                const Text("Already have an account?"),
                const SizedBox(height: 5,),
                CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(const LoginScreen(), context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
