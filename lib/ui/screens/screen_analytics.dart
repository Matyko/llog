import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/widgets/analytics_card.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  final EventWithUnit eventWithUnit;

  const AnalyticsScreen(this.eventWithUnit);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final logDao = Provider.of<AppDatabase>(context).logDao;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${widget.eventWithUnit.event.name} Analytics',
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
      body: StreamBuilder<List<LogWithEventAndUnit>>(
          stream: logDao.watchAllLogs(moor.OrderingMode.desc,
              eventId: widget.eventWithUnit.event.id),
          builder: (context, snapshot) {
            final logsWithEventAndUnit = snapshot.data ?? [];
            return AnimatedOpacity(
                opacity:
                    snapshot.connectionState == ConnectionState.waiting ? 0 : 1,
                duration: Duration(milliseconds: 200),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        AnalyticsCard(
                          indicator: Icon(Icons.history, color: Theme.of(context).primaryColorDark,),
                          title: logsWithEventAndUnit.length.toString(),
                          content: Text('Times this event was logged.')
                        ),
                        if (widget.eventWithUnit.unit != null) StreamBuilder<double>(
                            stream: logDao.getValueSumForEvent(
                                widget.eventWithUnit.event.id),
                            builder: (context, snapshot) {
                              double sum = snapshot.data ?? 0;
                              return AnalyticsCard(
                                indicator: Icon(Icons.all_inclusive, color: Theme.of(context).primaryColorDark,),
                                title: '${sum.toString()} ${widget.eventWithUnit.unit.name}',
                                content: Text('Sum of all logged values.')
                              );
                            }),
                        if (widget.eventWithUnit.unit != null) StreamBuilder<double>(
                            stream: logDao.getValueAvgForEvent(
                                widget.eventWithUnit.event.id),
                            builder: (context, snapshot) {
                              double sum = snapshot.data ?? 0;
                              return AnalyticsCard(
                                  indicator: Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text('~', style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  title: '${sum.roundToDouble().toString()} ${widget.eventWithUnit.unit.name}',
                                  content: Text('Average of all logged values.')
                              );
                            }),
                        AnalyticsCard(
                          indicator: Icon(Icons.bar_chart, color: Theme.of(context).primaryColorDark,),
                          content: Container(
                            height: 200,
                            child: new charts.TimeSeriesChart(
                              [new charts.Series<LogWithEventAndUnit, DateTime>(
                                id: 'Log',
                                domainFn: (LogWithEventAndUnit logWithEventAndUnit, _) => new DateTime(logWithEventAndUnit.log.date.year, logWithEventAndUnit.log.date.month, logWithEventAndUnit.log.date.day),
                                measureFn: (LogWithEventAndUnit logWithEventAndUnit, _) => logWithEventAndUnit.log.value,
                                data: logsWithEventAndUnit,
                                fillColorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
                              )],
                              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                              defaultInteractions: false,
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
