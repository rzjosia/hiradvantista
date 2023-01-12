import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../features/hymn/domain/song_model.dart';
import '../features/hymn/repository/hymn_repository.dart';

final hiveDbProvider = Provider<HiveDb>((ref) {
  return HiveDb();
});

class HiveDb {
  Future<void> init({bool isTest = false}) async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SongModelAdapter());
    }

    Box<SongModel> box = await Hive.openBox("songs");

    if (kDebugMode || isTest) {
      box.deleteAll(box.keys);
    }

    if (box.isEmpty) {
      await HymnRepository(box: box).loadSongs();
    }
  }
}
