import 'package:flutter/material.dart';
import 'package:grocery_app/constants/assets_image.dart';
import 'package:grocery_app/constants/routes.dart';
import 'package:grocery_app/screens/login/login.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:grocery_app/widgets/top_title/top_title.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const TopTitle(title: "Welcome", subtitle: "Buy any item from using app"),
                Image.asset(AssetImages.instance.welcomeImage ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 30,
                        child:  Image.asset(AssetImages.instance.googleLogo),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.facebook_rounded,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28,),
                PrimaryButton(
                  title: 'Login',
                  onPressed: () {
                    Routes.instance.push(const LoginScreen(), context);
                  },
                ),
                const SizedBox(height: 16,),
                PrimaryButton(
                  title: 'Sign Up',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
