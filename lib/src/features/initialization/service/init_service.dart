import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/constants/app_info.dart';

import '../../hymn/repository/hymn_repository.dart';

final initServiceProvider = Provider<InitService>((ref) {
  return InitService(ref: ref);
});

class InitService {
  Ref ref;

  InitService({required this.ref});

  Future<bool> initData({bool isTest = false}) async {
    HymnRepository hymnRepository = ref.watch(hymnRepositoryProvider);

    if (kDebugMode || isTest) {
      await hymnRepository.deleteAll();
    }

    if (hymnRepository.isEmpty()) {
      await ref.watch(hymnRepositoryProvider).loadHymns();
    }

    await AppInfo().init();

    return true;
  }
}
