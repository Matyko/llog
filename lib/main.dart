import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(LLog());

class LLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppDatabase(),
      child: MaterialApp(
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange)),
              primaryColor: Colors.deepOrange,
              primaryColorLight: Colors.deepOrange.shade100,
              primaryColorDark: Colors.deepOrange.shade700,
              accentColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.grey.shade200,
              fontFamily: 'Montserrat',
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.grey.shade200,
                  shadowColor: Colors.transparent,
                  centerTitle: true,
                  textTheme: TextTheme(
                    headline6: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay'
                    )
                  ),
                  iconTheme: IconThemeData(color: Colors.deepOrange))),
          title: 'Quick Log',
          home: FutureBuilder(
            future: _needsAuth(),
            builder: (_, AsyncSnapshot<bool> snapshot) {
              final isAuth = snapshot.data ?? false;
              return isAuth ? HomeScreen() : Container(
                color: Colors.white,
              );
            },
          )
      ),
    );
  }

  Future<bool>_needsAuth() async {
    final preferences = await SharedPreferences.getInstance();
    final authRequired = preferences.getBool('authRequired') ?? false;
    final LocalAuthentication localAuthentication = LocalAuthentication();
    if (authRequired) {
      final isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
      return isAuthenticated;
    }
    return true;
  }
}
