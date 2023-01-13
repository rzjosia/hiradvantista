import "package:flutter/services.dart" as s;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yaml/yaml.dart';

import '../domain/song_model.dart';
import 'hymn_db_provider.dart';

final hymnRepositoryProvider = Provider<HymnRepository>((ref) {
  Box<SongModel> box = ref.watch(hymnDbProvider);
  return HymnRepository(box: box);
});

class HymnRepository {
  Box<SongModel> box;

  HymnRepository({required this.box});

  Future<void> loadSongs() async {
    for (int i = 1; i <= 756; ++i) {
      final data =
          await s.rootBundle.loadString('assets/data/sources/song$i.yaml');

      final mapData = loadYaml(data);
      SongModel song = SongModel(
        id: i,
        title: mapData['title'],
        key: mapData['key'],
        content: mapData['content'],
        isFavorite: false,
      );

      await box.add(song);
    }
  }

  List<SongModel> getSongs() {
    return box.values.toList();
  }

  SongModel getSong(int id) {
    return box.getAt(id)!;
  }

  SongModel getSongByNumerous(int num) {
    return box.values.firstWhere((element) => element.id == num);
  }

  List<SongModel> searchSongs(String query) {
    if (query.isEmpty) {
      return box.values.toList();
    }

    return box.values
        .where((element) =>
            element.id.toString().compareTo(query) == 0 ||
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<SongModel> getFavorites() {
    return box.values.where((element) => element.isFavorite == true).toList();
  }

  Future<void> toggleFavorite(SongModel song) async {
    box.putAt(song.id - 1, song.setIsFavorite(!song.isFavorite!));
  }

  Future<void> deleteAll() async {
    await box.deleteAll(box.keys);
  }

  bool isEmpty() {
    return box.isEmpty;
  }
}
