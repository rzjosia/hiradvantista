import 'package:flutter/material.dart';

class SliverCenter extends StatelessWidget {
  final Widget child;

  const SliverCenter({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: child,
      ),
    );
  }
}
