import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_unit_form.dart';
import 'package:llog/ui/widgets/form_element.dart';
import 'package:provider/provider.dart';

class EventFormScreen extends StatefulWidget {
  final EventWithUnit eventWithUnit;

  EventFormScreen({this.eventWithUnit});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _unitId;
  bool _measurable = false;

  @override
  void initState() {
    _nameController.text =
        widget.eventWithUnit == null ? "" : widget.eventWithUnit.event.name;
    _descriptionController.text = widget.eventWithUnit == null
        ? ""
        : widget.eventWithUnit.event.description;

    if (widget.eventWithUnit != null &&
        widget.eventWithUnit.event.unitId != null) {
      _unitId = widget.eventWithUnit.event.unitId;
      _measurable = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unitDao = Provider.of<AppDatabase>(context).unitDao;
    final eventDao = Provider.of<AppDatabase>(context).eventDao;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              (widget.eventWithUnit == null ? 'Create' : 'Edit') + ' Event'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text(
                    (widget.eventWithUnit == null ? 'Create' : 'Save') +
                        ' Event'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final event = new Event(
                        id: null,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        unitId: _unitId,
                        createdAt: widget.eventWithUnit == null
                            ? DateTime.now()
                            : widget.eventWithUnit.event.createdAt,
                        modifiedAt: DateTime.now()
                    );
                    if (widget.eventWithUnit == null) {
                      eventDao.insertEvent(event);
                    } else {
                      eventDao.updateEvent(event);
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Image(
                    image: AssetImage('assets/images/plan_1.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: FormElementWithIcon(
                    icon: Icons.label,
                    label: 'Event Name',
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Event name"),
                      controller: _nameController,
                      validator: (value) =>
                      value.isEmpty ? 'Please enter an event name!' : null,
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade700),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: FormElementWithIcon(
                    icon: Icons.event_note,
                    label: 'Event description',
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(hintText: "Event description"),
                      controller: _descriptionController,
                    )
                  ),
                ),
                Divider(color: Colors.grey.shade700),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: FormElementWithIcon(
                      label: 'Is this event measurable?',
                      icon: Icons.straighten,
                      child: Row(
                        children: [
                          Switch(
                              value: _measurable,
                              onChanged: (measurable) => {
                                setState(() {
                                  _measurable = measurable;
                                })
                              }),
                          Text('Measurable')
                        ],
                      )
                  ),
                ),
                if (_measurable)
                  Divider(color: Colors.grey.shade700),
                if (_measurable)
                  StreamBuilder(
                      stream: unitDao.watchUnits(),
                      builder: (context, AsyncSnapshot<List<Unit>> snapshot) {
                        final units = snapshot.data ?? [];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: FormElementWithIcon(
                            icon: Icons.square_foot,
                            label: 'Select a measurement unit',
                            child: units.length > 0
                                ? DropdownButtonFormField(
                                value: _unitId,
                                hint: Text('Unit'),
                                onChanged: (unitId) => {
                                  setState(() {
                                    _unitId = unitId;
                                  })
                                },
                                validator: (value) => value == null &&
                                    _measurable
                                    ? 'Please select a measurement unit!'
                                    : null,
                                items: units
                                    .map<DropdownMenuItem>((unit) {
                                  return DropdownMenuItem(
                                      value: unit.id,
                                      child: Text(unit.name));
                                }).toList())
                                : null,
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                    child: Text('Add new unit'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => UnitFormScreen()));
                                    },
                                  ),
                            )
                          ),
                        );
                      }),
              ],
            )),
      ),
    );
  }
}
