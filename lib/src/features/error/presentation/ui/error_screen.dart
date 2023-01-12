import 'package:flutter/material.dart';

class RouteErrorScreen extends StatefulWidget {
  final String errorMessage;
  const RouteErrorScreen({required this.errorMessage, super.key});

  @override
  State<RouteErrorScreen> createState() => _RouteErrorScreenState();
}

class _RouteErrorScreenState extends State<RouteErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oops !!!'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.errorMessage),
      ),
    );
  }
}
