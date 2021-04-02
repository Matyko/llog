import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_event_form.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: _buildEventList(context))],
    );
  }

  _buildEventList(BuildContext context) {
    final eventDao = Provider.of<AppDatabase>(context).eventDao;
    return StreamBuilder(
        stream: eventDao.watchEvents(moor.OrderingMode.desc),
        builder: (context, AsyncSnapshot<List<EventWithUnit>> snapshot) {
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
                        return _buildEventItem(itemEvent, eventDao);
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
                                  'No events to show...',
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

  _buildEventItem(EventWithUnit eventWithUnit, EventDao eventDao) {
    return Dismissible(
        background: Container(
          color: Colors.blue,
          child: Text("Edit"),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Text("Delete"),
        ),
        confirmDismiss: (DismissDirection direction) =>
            _handleDismiss(direction, eventWithUnit),
        onDismissed: (DismissDirection direction) {
          Event eventWithDeletedAt = new Event(
              id: eventWithUnit.event.id,
              createdAt: eventWithUnit.event.createdAt,
              modifiedAt: eventWithUnit.event.modifiedAt,
              deletedAt: DateTime.now(),
              name: eventWithUnit.event.name,
              description: eventWithUnit.event.description,
              unitId: eventWithUnit.event.unitId);
          eventDao.updateEvent(eventWithDeletedAt);
        },
        key: Key(eventWithUnit.event.name),
        child: ListTile(
          title: Card(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(eventWithUnit.event.name),
          )),
        ));
  }

  Future<bool> _handleDismiss(
      DismissDirection direction, EventWithUnit eventWithUnit) async {
    if (direction == DismissDirection.startToEnd) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => EventFormScreen(eventWithUnit: eventWithUnit)));
      return false;
    }
    return true;
  }
}
