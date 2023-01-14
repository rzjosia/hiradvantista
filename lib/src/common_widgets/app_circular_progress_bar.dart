import 'package:flutter/material.dart';

class AppCircularProgressBar extends StatefulWidget {
  final String? message;

  const AppCircularProgressBar({Key? key, this.message}) : super(key: key);

  @override
  State<AppCircularProgressBar> createState() => _AppCircularProgressBarState();
}

class _AppCircularProgressBarState extends State<AppCircularProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
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
      body: SizedBox(
        width : double.infinity,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.message != null)
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(widget.message!),
              ),
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
      )
    );
  }
}
