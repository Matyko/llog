import 'package:flutter/material.dart';

class LlogDismissible extends StatelessWidget {
  final Widget child;
  final Function confirmDismiss;
  final Function onDismissed;

  const LlogDismissible(
      {Key key, this.confirmDismiss, this.onDismissed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => confirmDismiss(DismissDirection.startToEnd),
      child: Dismissible(
          key: key,
          background: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          secondaryBackground: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete, color: Theme.of(context).accentColor),
              ),
            ],
          ),
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.endToStart) {
              return await _showConfirmDeleteDialog(context, direction);
            } else {
              return confirmDismiss(direction);
            }
          },
          onDismissed: onDismissed,
          child: child),
    );
  }

  Future<bool> _showConfirmDeleteDialog(
      BuildContext context, DismissDirection direction) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete this item?'),
            content: Text(
                'This will remove this item.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('DELETE'),
              ),
            ],
          );
        });
  }
}
