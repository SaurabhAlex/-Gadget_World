import 'package:flutter/material.dart';
import 'package:grocery_app/screens/welcome/welcome.dart';

import '../../constants/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Routes.instance.push(const WelcomeScreen(), context);
        }, icon:  const Icon(Icons.arrow_back_ios),)

      ),
      body: Center(
        child: Text("Home SCREEN"),
      ),
    );
  }
}
