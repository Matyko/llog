import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:provider/provider.dart';

class UnitFormScreen extends StatefulWidget {
  final Unit unit;

  const UnitFormScreen({this.unit});
  @override
  _UnitFormScreenState createState() => _UnitFormScreenState();
}

class _UnitFormScreenState extends State<UnitFormScreen> {
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _unitDescriptionController =
  TextEditingController();
  final _unitFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.unit != null) {
      _unitNameController.text = widget.unit.name;
      _unitDescriptionController.text = widget.unit.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unitDao = Provider.of<AppDatabase>(context, listen: false).unitDao;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              (widget.unit == null ? 'Create' : 'Edit') + ' Event')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _unitFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Unit name"),
                controller: _unitNameController,
                validator: (value) =>
                value.isEmpty ? 'Please enter a unit name!' : null,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Unit description"),
                controller: _unitDescriptionController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_unitFormKey.currentState.validate()) {
                        Unit unit = new Unit(
                            id: null,
                            name: _unitNameController.text,
                            description: _unitDescriptionController.text,
                            createdAt: widget.unit == null
                                ? new DateTime.now()
                                : widget.unit.createdAt,
                            modifiedAt: new DateTime.now());
                        if (widget.unit != null) {
                          unitDao.updateUnit(unit);
                        } else {
                          unitDao.insertUnit(unit);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
