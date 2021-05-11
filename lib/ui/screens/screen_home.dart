import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:llog/ui/screens/screen_profile.dart';
import 'package:llog/ui/screens/screen_settings.dart';
import 'package:llog/ui/widgets/llog_bottom_navigation.dart';
import 'package:llog/ui/widgets/log_timeline_tile.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final eventDao = Provider.of<AppDatabase>(context).eventDao;
    final logDao = Provider.of<AppDatabase>(context).logDao;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.account_circle,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          title: Text('llog'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
            )
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Good ${greeting()}!',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Favourite events'),
            ),
            StreamBuilder(
                stream: eventDao.watchEvents(moor.OrderingMode.desc,
                    isFavourite: true),
                builder: (context,
                    AsyncSnapshot<List<EventWithUnitAndReminder>> snapshot) {
                  final events = snapshot.data ?? [];
                  return AnimatedOpacity(
                      opacity:
                          snapshot.connectionState == ConnectionState.waiting
                              ? 0
                              : 1,
                      duration: Duration(milliseconds: 200),
                      child: (events.length > 0)
                          ? Wrap(
                              children: _getFavourites(events, context),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('You have no favourited events yet'),
                            ));
                }),
            Divider(
              color: Colors.grey.shade600,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text('Recent logs'),
            ),
            StreamBuilder(
                stream: logDao.watchAllLogsWithLimit(moor.OrderingMode.desc, 5),
                builder: (context,
                    AsyncSnapshot<List<LogWithEventAndUnit>> snapshot) {
                  final logs = snapshot.data ?? [];
                  return AnimatedOpacity(
                      opacity:
                          snapshot.connectionState == ConnectionState.waiting
                              ? 0
                              : 1,
                      duration: Duration(milliseconds: 200),
                      child: (logs.length > 0)
                          ? Container(
                              height: 400,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: logs.length,
                                  itemBuilder: (_, index) {
                                    final itemLog = logs[index];
                                    return LogTimelineTile(
                                        itemLog, logDao, index, logs);
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text('You have no logs yet!'),
                            ));
                }),
          ],
        ),
      ),
      bottomNavigationBar: LlogBottomNavigation(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.post_add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LogFormScreen()));
        },
      ),
    );
  }

  _getFavourites(List<EventWithUnitAndReminder> events, BuildContext context) {
    return events.map((eventWithUnit) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eventWithUnit.event.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(eventWithUnit.event.description),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LogFormScreen(
                                eventWithUnit: new EventWithUnit(
                                    event: eventWithUnit.event,
                                    unit: eventWithUnit.unit))));
                  },
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
