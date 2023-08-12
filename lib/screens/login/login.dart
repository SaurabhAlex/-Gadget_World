import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/sign_up/signup.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:grocery_app/widgets/top_title/top_title.dart';
import 'package:grocery_app/constants/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isShowPassword = true;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const TopTitle(title: "Login", subtitle: "Welcome back to App"),
              const SizedBox(height: 32,),
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
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                    hintText: "Password",
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
                title: "Login",
                onPressed: () async{
                  bool isValidated =  loginValidation(email.text, password.text);
                  if(isValidated){
                    bool isLogined = await FirebaseAuthHelper.instance.login(email.text, password.text, context);
                  if(isLogined){
                    Routes.instance.pushAndRemovedUntil(HomeScreen(), context);
                  }
                  }
                },
              ),
              const SizedBox(height: 26,),
              const Text("Don't have an account?"),
              const SizedBox(height: 5,),
              CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(const SignUpScreen(), context);
                  },
                  child: Text(
                      "create an account",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
