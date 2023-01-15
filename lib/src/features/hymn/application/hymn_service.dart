import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/hymn_model.dart';
import '../repository/hymn_repository.dart';

enum HymnFilterType { all, favorite }

final hymnServiceProvider = ChangeNotifierProvider<HymnService>((ref) {
  final HymnRepository hymnRepository = ref.watch(hymnRepositoryProvider);
  return HymnService(hymnRepository: hymnRepository);
});

class HymnService extends ChangeNotifier {
  final HymnRepository hymnRepository;

  HymnService({required this.hymnRepository}) : super();

  Future<HymnModel> getHymnById(int num) async {
    return hymnRepository.findById(num);
  }

  Future<List<HymnModel>> searchHymns(String query) async {
    return hymnRepository.search(query);
  }

  Future<List<HymnModel>> getFavorites() async {
    return hymnRepository.findFavorites();
  }

  Future<List<HymnModel>> getFilteredHymns(HymnFilterType filterType,
      {String searchQuery = ""}) async {
    switch (filterType) {
      case HymnFilterType.favorite:
        return getFavorites();
      default:
        return searchHymns(searchQuery);
    }
  }

  Future<void> toggleFavorite(HymnModel hymn) {
    final result = hymnRepository.toggleFavorite(hymn);
    notifyListeners();
    return result;
  }
}
