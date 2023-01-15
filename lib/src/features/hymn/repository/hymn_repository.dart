import "package:flutter/services.dart" as s;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yaml/yaml.dart';

import '../domain/hymn_model.dart';
import 'hymn_db_provider.dart';

final hymnRepositoryProvider = Provider<HymnRepository>((ref) {
  Box<HymnModel> box = ref.watch(hymnDbProvider);
  return HymnRepository(box: box);
});

class HymnRepository {
  Box<HymnModel> box;

  HymnRepository({required this.box});

  Future<void> loadHymns() async {
    for (int i = 1; i <= 756; ++i) {
      final data =
          await s.rootBundle.loadString('assets/data/sources/song$i.yaml');

      final mapData = loadYaml(data);
      HymnModel hymn = HymnModel(
        id: i,
        title: mapData['title'],
        key: mapData['key'],
        content: mapData['content'],
        isFavorite: false,
      );

      await box.add(hymn);
    }
  }

  List<HymnModel> all() {
    return box.values.toList();
  }

  HymnModel findByBoxId(int id) {
    return box.getAt(id)!;
  }

  HymnModel findById(int num) {
    return box.values.toList().firstWhere((element) => element.id == num);
  }

  List<HymnModel> search(String query) {
    late List<HymnModel> result;

    if (query.isEmpty) {
      result = box.values.toList();
    } else {
      result = box.values
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    result.sort((a, b) => a.id.compareTo(b.id));
    return result;
  }

  List<HymnModel> findFavorites() {
    List<HymnModel> model =
        box.values.where((element) => element.isFavorite == true).toList();
    model.sort((a, b) => a.id.compareTo(b.id));
    return model;
  }

  Future<void> toggleFavorite(HymnModel hymn) async {
    box.putAt(hymn.id - 1, hymn.setIsFavorite(!hymn.isFavorite!));
  }

  Future<void> deleteAll() async {
    await box.deleteAll(box.keys);
  }

  bool isEmpty() {
    return box.isEmpty;
  }
}
