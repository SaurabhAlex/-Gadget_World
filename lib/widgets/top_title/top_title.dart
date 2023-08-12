import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title,subtitle;
  const TopTitle({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if(title == "Login" || title == "Create Account")
          const BackButton(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 12,),
        Text(
          subtitle,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300
          ),),
      ],
    );
  }
}
