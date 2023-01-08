// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hiradvantista/constants/about_constant.dart';

import 'package:hiradvantista/main.dart';

void main() {
  testWidgets('About page show developer email', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text("Home"), findsOneWidget);
    expect(find.text("A propos"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.info));
    await tester.pump();

    expect(find.textContaining(AboutApp.description), findsOneWidget);
    expect(find.textContaining(AboutApp.author), findsOneWidget);
    expect(find.textContaining(AboutApp.developerEmail), findsOneWidget);
  });
}
