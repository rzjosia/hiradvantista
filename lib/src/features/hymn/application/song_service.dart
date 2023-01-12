import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/song_model.dart';
import '../repository/hymn_repository.dart';

enum HymnFilterType { all, favorite }

final hymnServiceProvider = ChangeNotifierProvider<HymnService>((ref) {
  final HymnRepository hymnRepository = ref.watch(hymnRepositoryProvider);
  return HymnService(hymnRepository: hymnRepository);
});

class HymnService extends ChangeNotifier {
  final HymnRepository hymnRepository;

  HymnService({required this.hymnRepository}) : super();

  Future<SongModel> getSongByNumerous(int num) async {
    return hymnRepository.getSongByNumerous(num);
  }

  Future<List<SongModel>> searchSongs(String query) async {
    return hymnRepository.searchSongs(query);
  }

  Future<List<SongModel>> getFavorites() async {
    return hymnRepository.getFavorites();
  }

  Future<List<SongModel>> getSongsByFilter(HymnFilterType filterType,
      {String searchQuery = ""}) async {
    switch (filterType) {
      case HymnFilterType.favorite:
        return getFavorites();
      default:
        return searchSongs(searchQuery);
    }
  }

  Future<void> toggleFavorite(SongModel song) {
    final result = hymnRepository.toggleFavorite(song);
    notifyListeners();
    return result;
  }
}
