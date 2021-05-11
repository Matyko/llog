import 'package:flutter/material.dart';
import 'package:llog/ui/screens/screen_event_list.dart';
import 'package:llog/ui/screens/screen_home.dart';
import 'package:llog/ui/screens/screen_log_list.dart';

class LlogBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const LlogBottomNavigation({this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                switch (index) {
                  case 0:
                    return HomeScreen();
                  case 1:
                    return LogListScreen();
                  case 2:
                    return EventListScreen();
                  default:
                    return HomeScreen();
                }
              },
              transitionDuration: Duration(seconds: 0)),
        );
      }, // new
      currentIndex: currentIndex, // new
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Logs',
        ),
        new BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events')
      ],
    );
  }
}
