import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_log_form.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'llog_dismissible.dart';

class LogTimelineTile extends StatelessWidget {
  final LogWithEventAndUnit logWithEventAndUnit;
  final LogDao logDao;
  final int index;
  final List<LogWithEventAndUnit> logs;

  const LogTimelineTile(this.logWithEventAndUnit, this.logDao, this.index, this.logs);

  @override
  Widget build(BuildContext context) {
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
            ? _indicatorStyle(logWithEventAndUnit, context)
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

  IndicatorStyle _indicatorStyle(LogWithEventAndUnit logWithEventAndUnit, BuildContext context) {
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

}
