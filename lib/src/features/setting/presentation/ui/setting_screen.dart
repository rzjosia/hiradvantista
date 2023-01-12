import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            "assets/images/building_app.png",
            fit: BoxFit.contain,
          ),

        ),
      ),
    );
  }
}
