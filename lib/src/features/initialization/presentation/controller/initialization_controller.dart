import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../service/init_service.dart';

final initControllerProvider =
    StateNotifierProvider<InitializationController, bool>((ref) {
  return InitializationController(false, ref: ref);
});

class InitializationController extends StateNotifier<bool> {
  Ref ref;

  InitializationController(super.state, {required this.ref});

  void setInit(bool isInitialized) {
    state = isInitialized;
  }

  Future<bool> initData() async {
    return await ref.watch(initServiceProvider).initData();
  }

  bool isInitialized() {
    return state;
  }
}
