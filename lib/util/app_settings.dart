import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppSettings {
  AppSettings(StreamingSharedPreferences preferences)
      : authRequired = preferences.getBool('authRequired', defaultValue: false),
        hasDarkMode = preferences.getBool('hasDarkMode', defaultValue: false);

  final Preference<bool> authRequired;
  final Preference<bool> hasDarkMode;
}
