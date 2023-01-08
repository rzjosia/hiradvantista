import "package:flutter/material.dart";
import 'package:hiradvantista/constants/about_constant.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  static const paddingColumn = Padding(padding: EdgeInsets.only(bottom: 10.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          paddingColumn,
          const Text(
            AboutApp.description,
            textAlign: TextAlign.center,
          ),
          paddingColumn,
          const Text(
            "Conçue par ${AboutApp.author}",
            textAlign: TextAlign.center,
          ),
          paddingColumn,
          const Text(
            "Email : ${AboutApp.developerEmail}",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
