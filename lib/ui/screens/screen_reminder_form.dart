import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/data/tables/table_reminders.dart';
import 'package:llog/ui/widgets/form_element.dart';
import 'package:provider/provider.dart';

class ReminderFormScreen extends StatefulWidget {
  final Event event;
  final Reminder reminder;

  const ReminderFormScreen(this.event, {this.reminder});

  @override
  _ReminderFormScreenState createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends State<ReminderFormScreen> {
  int _notificationId;
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  List<String> _days = [];
  final _reminderFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.reminder != null) {
      _notificationId = widget.reminder.notificationId;
      _hour = widget.reminder.hour;
      _minute = widget.reminder.minute;
      _days = new List<String>.from(widget.reminder.days);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reminderDao =
        Provider.of<AppDatabase>(context, listen: false).reminderDao;
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.reminder == null ? 'Add' : 'Edit') + ' Reminder'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (_reminderFormKey.currentState.validate()) {
                    Reminder reminder = new Reminder(
                        id: widget.reminder == null ? null : widget.reminder.id,
                        notificationId: _notificationId,
                        hour: _hour,
                        minute: _minute,
                        eventId: widget.event.id,
                        createdAt: widget.reminder == null
                            ? new DateTime.now()
                            : widget.reminder.createdAt,
                        modifiedAt: new DateTime.now());
                    if (widget.reminder != null) {
                      reminderDao.updateReminder(reminder);
                    } else {
                      reminderDao.insertReminder(reminder);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save')),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Form(
            key: _reminderFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FormElementWithIcon(
                    icon: Icons.event,
                    label: widget.event.name,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FormElementWithIcon(
                    icon: Icons.view_week,
                    label: 'Days',
                    child: ReminderDayPicker(
                      selectedDays: _days,
                      onChange: (value) {
                        setState(() {
                          _days = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(color: Colors.grey.shade700),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FormElementWithIcon(
                    icon: Icons.schedule,
                    label: 'Time',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: InkWell(
                        onTap: () => _openTimePicker(context),
                        child: Text(
                          '$_hour : $_minute',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.reminder != null)
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: InkWell(
                            onTap: _cancelReminder,
                            child: Text('Cancel reminder',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor))),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openTimePicker(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: _hour, minute: _minute));
    if (pickedTime != null)
      setState(() {
        _hour = pickedTime.hour;
        _minute = pickedTime.minute;
      });
  }

  _cancelReminder() {}
}

class ReminderDayPicker extends StatefulWidget {
  final List<String> selectedDays;
  final Function onChange;

  const ReminderDayPicker(
      {@required this.selectedDays, @required this.onChange});

  @override
  _ReminderDayPickerState createState() => _ReminderDayPickerState();
}

class _ReminderDayPickerState extends State<ReminderDayPicker> {
  final List<String> _days = [
    Days.MONDAY,
    Days.TUESDAY,
    Days.WEDNESDAY,
    Days.THURSDAY,
    Days.FRIDAY,
    Days.SATURDAY,
    Days.SUNDAY
  ];

  List<String> _selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _days
          .map((day) => Row(
            children: [
              Checkbox(
                value: _selectedDays.contains(day),
                onChanged: (value) {
                  if (value) {
                    setState(() {
                      _selectedDays.add(day);
                      if (widget.onChange != null) {
                        widget.onChange(_selectedDays);
                      }
                    });
                  } else {
                    setState(() {
                      _selectedDays.remove(day);
                      if (widget.onChange != null) {
                        widget.onChange(_selectedDays);
                      }
                    });
                  }
                },
              ),
              Text('${day.substring(0,1)}${day.substring(1).toLowerCase()}')
            ],
          ))
          .toList(),
    );
  }
}
