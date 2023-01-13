import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hiradvantista/src/app.dart';
import 'package:hiradvantista/src/constants/app_info.dart';
import 'package:hiradvantista/src/features/hymn/domain/song_model.dart';
import 'package:hiradvantista/src/features/hymn/repository/hymn_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/hive_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  setUp(() async {
    await setUpTestHive();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> init(WidgetTester tester) async {
    return await tester.runAsync(() async {
      await Hive.initFlutter();

      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(SongModelAdapter());
      }

      await Hive.openBox<SongModel>("songs");

      Box<SongModel> box = await Hive.openBox("songs");

      box.deleteAll(box.keys);

      await HymnRepository(box: box).loadSongs();
      await AppInfo().init();
    });
  }

  testWidgets('Display song in list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await init(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("fihirana-1")), findsOneWidget);
    expect(find.byKey(const Key("fihirana-9")), findsOneWidget);

    await tester.tap(find.byKey(const Key("fihirana-1")));
    await tester.pumpAndSettle();

    expect(find.textContaining("Andriana ambony hasina"), findsOneWidget);
  });

  testWidgets('Add and remove favorite', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await init(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("favorite-1")), findsOneWidget);
    expect(find.byKey(const Key("favorite-9")), findsOneWidget);

    await tester.tap(find.byKey(const Key("favorite-1")));
    await tester.tap(find.byKey(const Key("fihirana-1")));
    await tester.pumpAndSettle();

    expect(find.textContaining("Andriana ambony hasina"), findsOneWidget);

    var favoriteIcon =
        tester.widget<IconButton>(find.byKey(const Key("favorite-1")));
    expect((favoriteIcon.icon as Icon).color, Colors.red);

    await tester.tap(find.byKey(const Key("favorite-1")));
    await tester.pumpAndSettle();

    favoriteIcon =
        tester.widget<IconButton>(find.byKey(const Key("favorite-1")));

    expect((favoriteIcon.icon as Icon).icon, Icons.favorite_border);
  });

  testWidgets('About page show developer email', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await init(tester);
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.info), findsOneWidget);

    await tester.tap(find.byIcon(Icons.info));
    await tester.pumpAndSettle();

    expect(find.text("Mombamomba"), findsOneWidget);
    expect(find.textContaining(AppInfo().description), findsOneWidget);
    expect(find.textContaining(AppInfo().author), findsOneWidget);
    expect(find.textContaining(AppInfo().developerEmail), findsOneWidget);
  });
}
