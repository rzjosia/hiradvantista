import "package:flutter/material.dart";
import 'package:hiradvantista/src/constants/about_constant.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  static const paddingColumn = Padding(padding: EdgeInsets.only(bottom: 10.0));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/icon.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            AboutApp.description,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            AboutApp.author,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            "Email : ${AboutApp.developerEmail}",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
