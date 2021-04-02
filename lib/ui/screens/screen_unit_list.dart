import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_unit_form.dart';
import 'package:llog/ui/widgets/llog_dismissible.dart';
import 'package:provider/provider.dart';

class UnitListScreen extends StatefulWidget {
  @override
  _UnitListScreenState createState() => _UnitListScreenState();
}

class _UnitListScreenState extends State<UnitListScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: _buildEventList(context))],
    );
  }

  _buildEventList(BuildContext context) {
    final unitDao = Provider.of<AppDatabase>(context).unitDao;
    return StreamBuilder(
        stream: unitDao.watchUnits(),
        builder: (context, AsyncSnapshot<List<Unit>> snapshot) {
          final events = snapshot.data ?? [];
          return AnimatedOpacity(
              opacity:
                  snapshot.connectionState == ConnectionState.waiting ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: (events.length > 0)
                  ? ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (_, index) {
                        final itemEvent = events[index];
                        return _buildUnitItem(itemEvent, unitDao);
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/plan_2.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  'No units to show...',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade400),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Try creating a new one!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade400),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
        });
  }

  _buildUnitItem(Unit unit, UnitDao unitDao) {
    return LlogDismissible(
        confirmDismiss: (DismissDirection direction) =>
            _handleDismiss(direction, unit),
        onDismissed: (DismissDirection direction) {
          Unit unitWithDeletedAt = new Unit(
              id: unit.id,
              createdAt: unit.createdAt,
              modifiedAt: unit.modifiedAt,
              deletedAt: DateTime.now(),
              name: unit.name,
              description: unit.description);
          unitDao.updateUnit(unitWithDeletedAt);
        },
        key: Key(unit.name),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(unit.name),
          ),
        ));
  }

  Future<bool> _handleDismiss(DismissDirection direction, Unit unit) async {
    if (direction == DismissDirection.startToEnd) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => UnitFormScreen(unit: unit)));
      return false;
    }
    return true;
  }
}
