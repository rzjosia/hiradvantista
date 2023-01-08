import "package:flutter/services.dart" as s;
import 'package:hiradvantista/src/features/song/domain/song_model.dart';
import 'package:hive/hive.dart';
import "package:yaml/yaml.dart";

class SongService extends SongModelAdapter {
  final Box<SongModel> box;

  SongService({required this.box});

  Future<void> loadSongs() async {
    for (int i = 1; i <= 756; ++i) {
      final data =
          await s.rootBundle.loadString('assets/data/sources/song$i.yaml');

      final mapData = loadYaml(data);

      await box.add(SongModel(
        id: i,
        title: mapData['title'],
        content: mapData['content'],
        key: mapData['key'],
      ));
    }
  }

  List<SongModel> getSongs() {
    return box.values.toList();
  }

  Future<SongModel> getSong(int id) async {
    Box<SongModel> itemBox = box;
    return itemBox.getAt(id)!;
  }

  Future<SongModel> getSongByNumerous(int num) async {
    Box<SongModel> itemBox = box;
    return itemBox.values.firstWhere((element) => element.id == num);
  }

  Future<List<SongModel>> searchSongs(String query) async {
    Box<SongModel> itemBox = box;

    if (query.isEmpty) {
      return itemBox.values.toList();
    }

    return itemBox.values
        .where((element) =>
            element.id.toString().compareTo(query) == 0 ||
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<SongModel>> getFavorites() async {
    Box<SongModel> itemBox = box;

    return itemBox.values
        .where((element) => element.isFavorite == true)
        .toList();
  }

  void deleteSongs() async {
    box.deleteFromDisk();
  }

  void updateSong(int id, SongModel song) async {
    box.putAt(id, song);
  }

  Future<void> toggleFavorite(SongModel song) {
    return box.putAt(
        song.id - 1,
        SongModel(
          id: song.id,
          title: song.title,
          key: song.key,
          content: song.content,
          isFavorite: song.isFavorite == true ? false : true,
        ));
  }
}
