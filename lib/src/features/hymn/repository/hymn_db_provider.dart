import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/hymn/domain/song_model.dart';
import 'package:hive/hive.dart';

final hymnDbProvider = Provider<Box<SongModel>>((ref) {
  return Hive.box<SongModel>("songs");
});
