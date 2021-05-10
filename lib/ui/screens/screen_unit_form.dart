import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/widgets/form_element.dart';
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
        title: Text((widget.unit == null ? 'Add' : 'Edit') + ' Unit'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (_unitFormKey.currentState.validate()) {
                    Unit unit = new Unit(
                        id: widget.unit == null ? null : widget.unit.id,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Form(
            key: _unitFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FormElementWithIcon(
                    icon: Icons.label,
                    label: 'Unit name',
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Unit name"),
                      controller: _unitNameController,
                      validator: (value) =>
                          value.isEmpty ? 'Please enter a unit name!' : null,
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
                    icon: Icons.note_add,
                    label: 'Unit description',
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Unit description"),
                      controller: _unitDescriptionController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
