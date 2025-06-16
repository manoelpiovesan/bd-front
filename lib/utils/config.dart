///
///
///
class Config {
  static const String appName = 'Projeto DB';

  static const String backUrl = 'http://localhost:3000';


  /// --------------------
  static final Config _instance = Config._internal();

  factory Config() {
    return _instance;
  }

  Config._internal();
}
