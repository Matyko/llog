import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/widgets/event_picker.dart';
import 'package:provider/provider.dart';

class LogFormScreen extends StatefulWidget {
  final LogWithEventAndUnit logData;

  LogFormScreen({this.logData});

  @override
  _LogFormScreenState createState() => _LogFormScreenState();
}

class _LogFormScreenState extends State<LogFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  final dateFormat = new DateFormat('yyyy-MM-dd hh:mm');

  DateTime _date = DateTime.now();
  EventWithUnit _eventWithUnit;

  @override
  void initState() {
    if (widget.logData != null && widget.logData.log.value != null) {
      _valueController.text = widget.logData.log.value.toString();
      _date = widget.logData.log.createdAt;
      _eventWithUnit = new EventWithUnit(
          event: widget.logData.event, unit: widget.logData.unit);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text((widget.logData == null ? 'Create' : 'Edit') + ' Log')),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              'When?',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _openDatePicker(context),
                            child: Text(dateFormat.format(_date)),
                          ),
                        ],
                      ),
                      EventPicker(
                        eventWithUnit: _eventWithUnit,
                        onChange: (EventWithUnit eventWithUnit) => setState(() {
                          _eventWithUnit = eventWithUnit;
                        }),
                      ),
                      if (_eventWithUnit != null && _eventWithUnit.unit != null)
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Enter a measurement value"),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,4}'))
                                ],
                                controller: _valueController,
                                validator: (value) => value.isEmpty
                                    ? 'Please enter a measurement value!'
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(_eventWithUnit.unit.name),
                            )
                          ],
                        ),
                      ElevatedButton(
                          onPressed: () => _save(context), child: Text('Log!'))
                    ],
                  ),
                ))));
  }

  _save(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final logDao = Provider.of<AppDatabase>(context, listen: false).logDao;
      final event = new Log(
          id: widget.logData != null ? widget.logData.log.id : null,
          eventId: _eventWithUnit.event.id,
          date: _date,
          value: double.parse(_valueController.text),
          createdAt: widget.logData == null
              ? DateTime.now()
              : widget.logData.log.createdAt,
          modifiedAt: DateTime.now());
      if (widget.logData == null) {
        logDao.insertLog(event);
      } else {
        logDao.updateLog(event);
      }
      Navigator.of(context).pop();
    }
  }

  _openDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: _date.hour, minute: _date.minute));
    if (picked != null && picked != _date)
      setState(() {
        _date = new DateTime(picked.year, picked.month, picked.day,
            pickedTime.hour, pickedTime.minute);
      });
  }
}
