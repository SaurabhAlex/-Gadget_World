import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("About us",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text("This is About Page"),
        ),
      ),
    );
  }
}
