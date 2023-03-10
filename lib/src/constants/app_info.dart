import 'package:package_info_plus/package_info_plus.dart';

// Singleton of AppInfo
class AppInfo {
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;

  get author => 'Josia RAZAFINJATOVO';

  get developerEmail => 'rzjosia@gmail.com';

  get developerGithub => 'https://github.com/rzjosia';

  get developerLinkedin => 'https://www.linkedin.com/in/josia-razafinjatovo/';

  get description => "Fihirana advantista dia application"
      " de recueil des cantiques adventistes malagasy.";

  get copyRight => "© 2023 $author";

  get developerPaypal => "H4V2MM2SH89J4";

  static final AppInfo _instance = AppInfo._internal();

  factory AppInfo() {
    return _instance;
  }

  AppInfo._internal();

  Future<void> init() async {
    late PackageInfo packageInfo;

    try {
      packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      packageInfo = PackageInfo(
        appName: 'Hiradvantista',
        packageName: 'com.hiradvantista',
        version: '1.0.0',
        buildNumber: '1',
      );
    }

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }
}
