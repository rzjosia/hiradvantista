import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final fontSizeServiceProvider = StateNotifierProvider<FontSizeService, int>(
  (ref) => FontSizeService(),
);

class FontSizeService extends StateNotifier<int> {
  late SharedPreferences prefs;
  static const defaultFontSize = 18;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    int? fontSize = prefs.getInt("fontSize");
    state = fontSize ?? defaultFontSize;
  }

  FontSizeService() : super(defaultFontSize) {
    _init();
  }

  void setFontSize(int fontSize) {
    state = fontSize;
    prefs.setInt("fontSize", fontSize);
  }

  void resetFontSize() {
    setFontSize(defaultFontSize);
  }

  void decrease() {
    setFontSize(state - 1);
  }

  void increase() {
    setFontSize(state + 1);
  }
}
