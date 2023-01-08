import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hiradvantista/src/features/core/presentation/home.dart';
import 'package:hiradvantista/src/features/song/application/song_service.dart';
import 'package:hiradvantista/src/features/song/domain/song_model.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initHive();

  runApp(const MyApp());
}

Future<void> initHive({bool isTest = false}) async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongModelAdapter());
  }

  Box<SongModel> box = await Hive.openBox("songs");

  if (kDebugMode || isTest) {
    box.deleteAll(box.keys);
  }

  if (box.isEmpty) {
    await SongService(box: box).loadSongs();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Fihirana advantista",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Home());
  }
}
