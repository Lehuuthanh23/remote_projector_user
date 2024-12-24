class AppInfo {
  AppInfo._();

  static const userAndroidAppInfo = BaseInfo(
    version: 'U1.0.0.1',
    buildDate: '30/08/2024 17:00',
  );
  static const userIOSAppInfo = BaseInfo(
    version: 'U1.0.0.1',
    buildDate: '30/08/2024 17:00',
  );
}

class BaseInfo {
  final String version;
  final String buildDate;

  const BaseInfo({
    required this.version,
    required this.buildDate,
  });
}
