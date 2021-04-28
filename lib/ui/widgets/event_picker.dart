import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class EventPicker extends StatefulWidget {
  final EventWithUnit eventWithUnit;
  final Function onChange;
  final bool showNull;

  const EventPicker({this.eventWithUnit, this.onChange, this.showNull = false});

  @override
  _EventPickerState createState() => _EventPickerState();
}

class _EventPickerState extends State<EventPicker> {
  EventWithUnit _eventWithUnit;

  @override
  void initState() {
    if (widget.eventWithUnit != null) {
      this._eventWithUnit = widget.eventWithUnit;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventDao = Provider.of<AppDatabase>(context).eventDao;
    return StreamBuilder(
        stream: eventDao.watchEvents(moor.OrderingMode.asc),
        builder: (context,
            AsyncSnapshot<List<EventWithUnit>> snapshot) {
          final eventsWithUnits = snapshot.data ?? [];
          final items = eventsWithUnits
              .map<DropdownMenuItem>(
                  (eventWithUnit) {
                return DropdownMenuItem(
                    value: eventWithUnit.event.id,
                    child: Text(eventWithUnit
                        .event.name +
                        (eventWithUnit.unit != null
                            ? ' (${eventWithUnit.unit.name})'
                            : '')));
              }).toList();
          if (widget.showNull) items.add(
            DropdownMenuItem(
              value: null,
              child: Text('None')
            )
          );
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (eventsWithUnits.length > 0)
                Flexible(
                  child: DropdownButtonFormField(
                      value: (_eventWithUnit != null &&
                          _eventWithUnit.event != null)
                          ? _eventWithUnit.event.id
                          : null,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                        ),
                      ),
                      hint: Text('Select event'),
                      onChanged: (id) {
                        if (id == null) {
                          if (widget.onChange != null) {
                            widget.onChange(null);
                          }
                          return;
                        }
                        setState(() {
                          _eventWithUnit = eventsWithUnits
                              .firstWhere((element) =>
                          element.event.id ==
                              id);
                        });
                        if (widget.onChange != null) {
                          widget.onChange(_eventWithUnit);
                        }
                      },
                      validator: (value) => value == null
                          ? 'Please select an event!'
                          : null,
                      items: items),
                ),
            ],
          );
        });
  }
}
