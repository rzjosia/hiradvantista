// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hiradvantista/src/app.dart';
import 'package:hiradvantista/src/constants/about_constant.dart';
import 'package:hiradvantista/src/utils/hive_db.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  testWidgets('Display song in list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() => HiveDb().init());
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("fihirana-1")), findsOneWidget);
    expect(find.byKey(const Key("fihirana-9")), findsOneWidget);

    await tester.tap(find.byKey(const Key("fihirana-1")));
    await tester.pumpAndSettle();

    expect(find.textContaining("Andriana ambony hasina"), findsOneWidget);
  });

  testWidgets('About page show developer email', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.runAsync(() => HiveDb().init());
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.info), findsOneWidget);

    await tester.tap(find.byIcon(Icons.info));
    await tester.pumpAndSettle();

    expect(find.text("Mombamomba"), findsOneWidget);
    expect(find.textContaining(AboutApp.description), findsOneWidget);
    expect(find.textContaining(AboutApp.author), findsOneWidget);
    expect(find.textContaining(AboutApp.developerEmail), findsOneWidget);
  });
}
