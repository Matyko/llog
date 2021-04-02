import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_home.dart';
import 'package:provider/provider.dart';

void main() => runApp(LLog());

class LLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AppDatabase(),
      child: MaterialApp(
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(primary: Colors.orange)),
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.deepOrange))),
          title: 'Quick Log',
          home: HomeScreen()),
    );
  }
}
