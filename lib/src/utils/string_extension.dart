import 'dart:convert';
import 'dart:math';

class StringExtensionSingleton {
  static final StringExtensionSingleton _singleton =
      StringExtensionSingleton._internal();

  late String _initializationString;

  factory StringExtensionSingleton() {
    return _singleton;
  }

  String get initializationString => _initializationString;

  StringExtensionSingleton._internal() {
    _initializationString = getRandString(32);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
