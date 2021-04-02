import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:llog/ui/widgets/event_picker.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class LogListScreen extends StatefulWidget {
  @override
  _LogListScreenState createState() => _LogListScreenState();
}

class _LogListScreenState extends State<LogListScreen> {
  EventWithUnit _eventWithUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: _buildLogList(context))],
    );
  }

  _buildLogList(BuildContext context) {
    final logDao = Provider.of<AppDatabase>(context).logDao;
    return StreamBuilder(
        stream: logDao.watchAllLogs(moor.OrderingMode.desc, eventId: _eventWithUnit == null ? null : _eventWithUnit.event.id),
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
                    Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('Filter by event'),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: EventPicker(
                              eventWithUnit: _eventWithUnit,
                              onChange: (EventWithUnit eventWithUnit) {
                                setState(() {
                                  _eventWithUnit = eventWithUnit;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      child: ListView.builder(
                          itemCount: logs.length,
                          itemBuilder: (_, index) {
                            final itemLog = logs[index];
                            return _buildLogItem(itemLog, logDao);
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

  _buildLogItem(LogWithEventAndUnit logWithEventAndUnit, LogDao logDao) {
    final dateFormat = new DateFormat('yyyy-MM-dd hh:mm');
    return Dismissible(
        key: Key(logWithEventAndUnit.log.id.toString()),
        background: Container(
          color: Colors.blue,
          child: Text("Edit"),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Text("Delete"),
        ),
        confirmDismiss: (DismissDirection direction) =>
            _handleDismiss(direction, logWithEventAndUnit, context),
        onDismissed: (DismissDirection direction) {
          final Log log = new Log(
            createdAt: logWithEventAndUnit.log.createdAt,
            date: logWithEventAndUnit.log.date,
            eventId: logWithEventAndUnit.log.eventId,
            value: logWithEventAndUnit.log.value,
            id: logWithEventAndUnit.log.id,
            modifiedAt: DateTime.now(),
            deletedAt: DateTime.now(),
          );
          logDao.updateLog(log);
        },
        child: ListTile(
          title: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        logWithEventAndUnit.event.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(logWithEventAndUnit.log.id.toString()),
                      Text(dateFormat.format(logWithEventAndUnit.log.date))
                    ],
                  ),
                  if (logWithEventAndUnit.log.value != null)
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${logWithEventAndUnit.log.value} ${logWithEventAndUnit.unit.name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> _handleDismiss(DismissDirection direction,
      LogWithEventAndUnit logWithEventAndUnit, BuildContext context) async {
    if (direction == DismissDirection.startToEnd) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => LogFormScreen(logData: logWithEventAndUnit)));
      return false;
    }
    return true;
  }
}
