import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/widgets/analytics_card.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  final EventWithUnitAndReminder eventWithUnitAndReminder;

  const AnalyticsScreen(this.eventWithUnitAndReminder);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class ChartValue {
  final DateTime date;
  final double value;

  ChartValue(this.date, this.value);
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final logDao = Provider.of<AppDatabase>(context).logDao;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        '${widget.eventWithUnitAndReminder.event.name} Analytics',
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
      body: StreamBuilder<List<LogWithEventAndUnit>>(
          stream: logDao.watchAllLogs(moor.OrderingMode.desc,
              eventId: widget.eventWithUnitAndReminder.event.id),
          builder: (context, snapshot) {
            final hasValue = widget.eventWithUnitAndReminder.unit != null;
            final showSum = hasValue && widget.eventWithUnitAndReminder.event.showSum;
            final showChange =
                hasValue && widget.eventWithUnitAndReminder.event.showChange;
            final logsWithEventAndUnit = snapshot.data ?? [];
            final changesInSum = <ChartValue>[];
            final changesInValue = <ChartValue>[];
            logsWithEventAndUnit.asMap().forEach((index, logWithEventAndUnit) {
              if (showSum) {
                final base = changesInSum.length > 0
                    ? changesInSum[changesInSum.length - 1].value
                    : 0;
                changesInSum.add(new ChartValue(logWithEventAndUnit.log.date,
                    base + logWithEventAndUnit.log.value));
              }
              if (showChange) {
                final base =
                    index > 0 ? logsWithEventAndUnit[index - 1].log.value : 0;
                changesInValue.add(new ChartValue(logWithEventAndUnit.log.date,
                    logWithEventAndUnit.log.value - base));
              }
            });
            double averageChange = 0;
            if (showChange) {
              double sum = 0;
              changesInValue.forEach((el) {
                sum += el.value;
              });
              averageChange = sum / changesInValue.length;
            }
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
                            indicator: Icon(
                              Icons.history,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            title: logsWithEventAndUnit.length.toString(),
                            content: Text('Times this event was logged.')),
                        if (showSum)
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Sum of logged values', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        if (showSum)
                          StreamBuilder<double>(
                              stream: logDao.getValueSumForEvent(
                                  widget.eventWithUnitAndReminder.event.id),
                              builder: (context, snapshot) {
                                double sum = snapshot.data ?? 0;
                                return AnalyticsCard(
                                    indicator: Icon(
                                      Icons.all_inclusive,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    title:
                                        '${double.parse((sum).toStringAsFixed(2)).toString()} ${widget.eventWithUnitAndReminder.unit.name}',
                                    content: Text('Sum of all logged values.'));
                              }),
                        if (showSum)
                          AnalyticsCard(
                              indicator: Icon(
                                Icons.timeline,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              content: Container(
                                height: 200,
                                child: new charts.TimeSeriesChart(
                                  [
                                    new charts.Series<ChartValue, DateTime>(
                                      id: 'Log',
                                      domainFn: (ChartValue chartValue, _) =>
                                          new DateTime(
                                              chartValue.date.year,
                                              chartValue.date.month,
                                              chartValue.date.day),
                                      measureFn: (ChartValue chartValue, _) =>
                                          chartValue.value,
                                      data: changesInSum,
                                      fillColorFn: (_, __) => charts
                                          .MaterialPalette
                                          .deepOrange
                                          .shadeDefault,
                                    )
                                  ],
                                  defaultRenderer:
                                      new charts.LineRendererConfig<DateTime>(),
                                  defaultInteractions: false,
                                ),
                              )),
                        if (showChange)
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Change in logged values', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        if (showChange)
                          AnalyticsCard(
                              indicator: Text(
                                '~',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              title:
                                  '${double.parse((averageChange).toStringAsFixed(2)).toString()} ${widget.eventWithUnitAndReminder.unit.name}',
                              content: Text('Average change in value.')),
                        if (showChange)
                          AnalyticsCard(
                              indicator: Icon(
                                Icons.timeline,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              content: Container(
                                height: 200,
                                child: new charts.TimeSeriesChart(
                                  [
                                    new charts.Series<ChartValue, DateTime>(
                                      id: 'Log',
                                      domainFn: (ChartValue chartValue, _) =>
                                          new DateTime(
                                              chartValue.date.year,
                                              chartValue.date.month,
                                              chartValue.date.day),
                                      measureFn: (ChartValue chartValue, _) =>
                                          chartValue.value,
                                      data: changesInValue,
                                      fillColorFn: (_, __) => charts
                                          .MaterialPalette
                                          .deepOrange
                                          .shadeDefault,
                                    )
                                  ],
                                  defaultRenderer:
                                      new charts.LineRendererConfig<DateTime>(),
                                  defaultInteractions: false,
                                ),
                              )),
                        AnalyticsCard(
                            indicator: Icon(
                              Icons.bar_chart,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            content: Container(
                              height: 200,
                              child: new charts.TimeSeriesChart(
                                [
                                  new charts
                                      .Series<LogWithEventAndUnit, DateTime>(
                                    id: 'Log',
                                    domainFn: (LogWithEventAndUnit
                                                logWithEventAndUnit,
                                            _) =>
                                        new DateTime(
                                            logWithEventAndUnit.log.date.year,
                                            logWithEventAndUnit.log.date.month,
                                            logWithEventAndUnit.log.date.day),
                                    measureFn: (LogWithEventAndUnit
                                                logWithEventAndUnit,
                                            _) =>
                                        logWithEventAndUnit.log.value,
                                    data: logsWithEventAndUnit,
                                    fillColorFn: (_, __) => charts
                                        .MaterialPalette
                                        .deepOrange
                                        .shadeDefault,
                                  )
                                ],
                                defaultRenderer:
                                    new charts.BarRendererConfig<DateTime>(),
                                defaultInteractions: false,
                              ),
                            ))
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
