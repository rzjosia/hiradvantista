import 'package:flutter/material.dart';

class AppCircularProgressBar extends StatefulWidget {
  const AppCircularProgressBar({Key? key}) : super(key: key);

  @override
  State<AppCircularProgressBar> createState() => _AppCircularProgressBarState();
}

class _AppCircularProgressBarState extends State<AppCircularProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Loading',
            ),
          ),
        ],
      ),
    );
  }
}
