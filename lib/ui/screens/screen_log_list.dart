import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:llog/ui/widgets/event_picker.dart';
import 'package:llog/ui/widgets/llog_bottom_navigation.dart';
import 'package:llog/ui/widgets/llog_dismissible.dart';
import 'package:llog/ui/widgets/log_timeline_tile.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LogListScreen extends StatefulWidget {
  @override
  _LogListScreenState createState() => _LogListScreenState();
}

class _LogListScreenState extends State<LogListScreen> {
  EventWithUnit _eventWithUnit;
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your logs'),
        actions: [
          IconButton(icon: Icon(
              _eventWithUnit == null ? Icons.filter_alt_outlined : Icons.filter_alt,
              color: Theme.of(context).primaryColor
          ), onPressed: () {
            showFilterOptions(context);
          })
        ]
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            children: [Expanded(child: _buildLogList(context))],
          ),
        ),
      ),
      bottomNavigationBar: LlogBottomNavigation(currentIndex: 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLogForm(context);
        },
        child: Icon(Icons.post_add),
      ),
    );
  }

  _buildLogList(BuildContext context) {
    final logDao = Provider.of<AppDatabase>(context).logDao;
    return StreamBuilder(
        stream: logDao.watchAllLogs(moor.OrderingMode.desc,
            eventId: _eventWithUnit == null ? null : _eventWithUnit.event.id),
        builder: (context, AsyncSnapshot<List<LogWithEventAndUnit>> snapshot) {
          final logs = snapshot.data ?? [];
          return AnimatedOpacity(
            opacity:
                snapshot.connectionState == ConnectionState.waiting ? 0 : 1,
            duration: Duration(milliseconds: 200),
            child: (logs.length > 0)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (_, index) {
                            final itemLog = logs[index];
                            return LogTimelineTile(itemLog, logDao, index, logs);
                          },
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/events_1.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'Nothing to show yet...',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade400),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Log your first event!',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  _showLogForm(BuildContext context) {
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

  showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('Select an event to filter by', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: EventPicker(
                showNull: true,
                eventWithUnit: _eventWithUnit,
                onChange: (EventWithUnit eventWithUnit) {
                  setState(() {
                    _eventWithUnit = eventWithUnit;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
