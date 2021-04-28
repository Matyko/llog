import 'package:flutter/material.dart';
import 'package:llog/ui/screens/screen_event_form.dart';
import 'package:llog/ui/screens/screen_event_list.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:llog/ui/screens/screen_log_list.dart';
import 'package:llog/ui/screens/screen_unit_form.dart';
import 'package:llog/ui/screens/screen_unit_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    LogListScreen(),
    EventListScreen(),
    UnitListScreen(),
  ];

  final List<String> _titles = ["Your Logs", "Your Events", "Your Units"];

  final List<IconData> _icons = [Icons.post_add, Icons.event_note, Icons.add_chart];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _titles[_currentIndex],
            style: TextStyle(color: Theme
                .of(context)
                .primaryColor),
          )),
      body: SafeArea(
          child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapNavigation, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Logs',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.straighten),
              label: 'Units'
          )
        ],
      ),
      floatingActionButton: _icons[_currentIndex] != null
          ? FloatingActionButton(
        onPressed: () {
          if (_currentIndex == 0) {
            _goToLogFormScreen(context);
          }
          if (_currentIndex == 1) {
            _goToEventFormScreen(context);
          }
          if (_currentIndex == 2) {
            _goToUnitFormScreen(context);
          }
        },
        child: Icon(_icons[_currentIndex]),
      )
          : null,
    );
  }

  _goToEventFormScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => EventFormScreen()));
  }

  _goToLogFormScreen(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: LogFormScreen(),
        ),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (_) => LogFormScreen()));
  }

  _goToUnitFormScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => UnitFormScreen()));
  }

  onTapNavigation(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
