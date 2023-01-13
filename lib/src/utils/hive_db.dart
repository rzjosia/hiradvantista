import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../features/hymn/domain/song_model.dart';

final hiveDbProvider = Provider<HiveDb>((ref) {
  return HiveDb();
});

class HiveDb {
  Future<void> init({bool isTest = false}) async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SongModelAdapter());
    }

    await Hive.openBox<SongModel>("songs");
  }
}
