import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_home.dart';
import 'package:llog/util/app_settings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await StreamingSharedPreferences.instance;
  final settings = AppSettings(preferences);
  runApp(LLog(settings));
}

class LLog extends StatelessWidget {
  LLog(this.settings);

  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => AppDatabase(),
        child: PreferenceBuilder(
            preference: settings.authRequired,
            builder: (_, authRequired) {
              return FutureBuilder<bool>(
                  future: authUser(authRequired),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    if (!snapshot.data) {
                      SystemNavigator.pop(animated: true);
                    }
                    return PreferenceBuilder(
                      preference: settings.hasDarkMode,
                      builder: (_, hasDarkMode) {
                        return MaterialApp(
                            theme: _getThemeData(hasDarkMode),
                            title: 'llog',
                            home: HomeScreen());
                      },
                    );
                  });
            }));
  }
}

ThemeData _getThemeData(bool hasDarkMode) {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange)),
      primaryColor: Colors.deepOrange,
      primaryColorLight: Colors.deepOrange.shade100,
      primaryColorDark: Colors.deepOrange.shade700,
      accentColor: Colors.deepOrangeAccent,
      backgroundColor: hasDarkMode
          ? Colors.grey.shade800
          : Colors.white,
      scaffoldBackgroundColor: hasDarkMode
          ? Colors.grey.shade900
          : Colors.grey.shade200,
      cardColor: hasDarkMode
          ? Colors.grey.shade700
          : Colors.white,
      fontFamily: 'Montserrat',
      iconTheme: IconThemeData(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        bodyText2: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        caption: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline1: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline2: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        subtitle1: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        subtitle2: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline3: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline4: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline5: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
        headline6: TextStyle(
          color: hasDarkMode
              ? Colors.white
              : Colors.grey.shade800,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: hasDarkMode
                ? Colors.white
                : Colors.grey.shade800,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: hasDarkMode
                    ? Colors.white
                    : Colors.grey.shade800),
          ),
          hintStyle: TextStyle(
            color: hasDarkMode
                ? Colors.white
                : Colors.grey.shade800,
          )),
      canvasColor: hasDarkMode
          ? Colors.grey.shade800
          : Colors.white,
      bottomNavigationBarTheme:
      BottomNavigationBarThemeData(
        backgroundColor: hasDarkMode
            ? Colors.grey.shade800
            : Colors.white,
        unselectedItemColor: hasDarkMode
            ? Colors.white
            : Colors.grey.shade800,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: hasDarkMode
              ? Colors.grey.shade900
              : Colors.grey.shade200,
          shadowColor: Colors.transparent,
          centerTitle: true,
          textTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay')),
          iconTheme: IconThemeData(
              color: Colors.deepOrange)));
}

Future<bool> authUser(bool authRequired) async {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  if (authRequired) {
    final isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'Please complete the biometrics to proceed.',
    );
    return isAuthenticated;
  }
  return true;
}
