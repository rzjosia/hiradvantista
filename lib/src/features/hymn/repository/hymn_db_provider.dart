import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/features/hymn/domain/hymn_model.dart';
import 'package:hive/hive.dart';

final hymnDbProvider = Provider<Box<HymnModel>>((ref) {
  return Hive.box<HymnModel>("hymns");
});
