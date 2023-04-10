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
    String hymnsData =
        await s.rootBundle.loadString('assets/data/fihirana.yaml');

    YamlList hymns = loadYaml(hymnsData);

    for (YamlMap hymn in hymns) {
      HymnModel hymnModel = HymnModel.fromYamlMap(hymn);
      HymnModel? currentHymn = box.get(hymnModel.id - 1);

      if (currentHymn != null) {
        hymnModel = hymnModel.copyWith(isFavorite: currentHymn.isFavorite);
      }

      await box.add(hymnModel);
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

  List<HymnModel> search(String query, {bool searchInContent = false}) {
    late List<HymnModel> result;

    if (query.isEmpty) {
      result = box.values.toList();
    } else {
      result = box.values
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()) ||
              element.id.toString() == query ||
              searchInContent &&
                  element.content.toLowerCase().contains(query.toLowerCase()))
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
    await box.clear();
  }

  bool isEmpty() {
    return box.isEmpty;
  }

  int getLastId() {
    return box.values.toList().last.id;
  }
}
