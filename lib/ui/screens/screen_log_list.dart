import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:llog/ui/widgets/event_picker.dart';
import 'package:llog/ui/widgets/llog_bottom_navigation.dart';
import 'package:llog/ui/widgets/llog_dismissible.dart';
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
          color: Colors.white,
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
                            return _buildLogItem(itemLog, logDao, index, logs);
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

  _buildLogItem(LogWithEventAndUnit logWithEventAndUnit, LogDao logDao,
      int index, List<LogWithEventAndUnit> logs) {
    bool isCheckpoint = false;
    final dateFormat = new DateFormat('hh : mm');
    final bool isFirst = index == 0;
    final bool isLast = index == logs.length - 1;
    if (!isFirst && !isLast) {
      final prev = logs[index - 1];
      isCheckpoint = prev.log.date.year != logWithEventAndUnit.log.date.year ||
          prev.log.date.month != logWithEventAndUnit.log.date.month ||
          prev.log.date.day != logWithEventAndUnit.log.date.day;
    }
    final bool hasIndicator = isFirst || isLast || isCheckpoint;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TimelineTile(
        isFirst: index == 0,
        isLast: index == logs.length - 1,
        hasIndicator: hasIndicator,
        afterLineStyle: LineStyle(color: Theme.of(context).primaryColor),
        beforeLineStyle: LineStyle(color: Theme.of(context).primaryColor),
        indicatorStyle: hasIndicator
            ? _indicatorStyle(logWithEventAndUnit)
            : IndicatorStyle(width: 0),
        alignment: TimelineAlign.manual,
        lineXY: 0.05,
        startChild: _leftSide(logWithEventAndUnit),
        endChild: LlogDismissible(
            key: Key(logWithEventAndUnit.log.id.toString()),
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
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.only(left: hasIndicator ? 0 : 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            logWithEventAndUnit.event.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(dateFormat.format(logWithEventAndUnit.log.date))
                        ],
                      ),
                      if (logWithEventAndUnit.log.value != null)
                        Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
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
            )),
      ),
    );
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

  Widget _leftSide(LogWithEventAndUnit logWithEventAndUnit) {
    return Container(
      height: 70,
    );
  }

  IndicatorStyle _indicatorStyle(LogWithEventAndUnit logWithEventAndUnit) {
    final dateFormat = new DateFormat('MMM\ndd');
    return IndicatorStyle(
      width: 35,
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 8),
      indicator: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dateFormat.format(logWithEventAndUnit.log.date),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
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
