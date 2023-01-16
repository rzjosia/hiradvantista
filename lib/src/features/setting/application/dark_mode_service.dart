import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkModeServiceProvider = StateNotifierProvider<DarkModeService, bool>(
  (ref) => DarkModeService(),
);

class DarkModeService extends StateNotifier<bool> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    bool? darkMode = prefs.getBool("darkMode");
    state = darkMode ?? false;
  }

  DarkModeService() : super(false) {
    _init();
  }

  void toggle() async {
    state = !state;
    prefs.setBool("darkMode", state);
  }
}
