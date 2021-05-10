import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:llog/data/moor_database.dart';
import 'package:llog/ui/screens/screen_analytics.dart';
import 'package:llog/ui/screens/screen_event_form.dart';
import 'package:llog/ui/widgets/llog_bottom_navigation.dart';
import 'package:llog/ui/widgets/llog_dismissible.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Your events'),
      ),
      body: Column(
        children: [Expanded(child: _buildEventList(context))],
      ),
      bottomNavigationBar: LlogBottomNavigation(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EventFormScreen()));
        },
        child: Icon(Icons.event_note),
      ),
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
    final DateFormat dateFormat = new DateFormat('yyyy/MM/dd');
    return LlogDismissible(
        confirmDismiss: (DismissDirection direction) =>
            _handleDismiss(direction, eventWithUnit),
        onDismissed: (DismissDirection direction) {
          Event eventWithDeletedAt = new Event(
              id: eventWithUnit.event.id,
              createdAt: eventWithUnit.event.createdAt,
              modifiedAt: eventWithUnit.event.modifiedAt,
              deletedAt: DateTime.now(),
              name: eventWithUnit.event.name,
              showChange: eventWithUnit.event.showChange,
              showSum: eventWithUnit.event.showSum,
              isFavourite: eventWithUnit.event.isFavourite,
              description: eventWithUnit.event.description,
              unitId: eventWithUnit.event.unitId);
          eventDao.updateEvent(eventWithDeletedAt);
        },
        key: Key(eventWithUnit.event.name),
        child: ListTile(
          title: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eventWithUnit.event.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      if (eventWithUnit.event.description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Tooltip(
                            message: 'Description',
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.event_note),
                                ),
                                Text(eventWithUnit.event.description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Tooltip(
                          message: 'Created at',
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.date_range),
                              ),
                              Text(
                                  dateFormat
                                      .format(eventWithUnit.event.createdAt),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      if (eventWithUnit.unit != null)
                        Tooltip(
                          message: 'Unit',
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.straighten,
                                    size: 18),
                              ),
                              Text(eventWithUnit.unit.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(
                            eventWithUnit.event.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Event eventWithFavouriteFlipped = new Event(
                                id: eventWithUnit.event.id,
                                createdAt: eventWithUnit.event.createdAt,
                                modifiedAt: eventWithUnit.event.modifiedAt,
                                isFavourite: !eventWithUnit.event.isFavourite,
                                showChange: eventWithUnit.event.showChange,
                                showSum: eventWithUnit.event.showSum,
                                name: eventWithUnit.event.name,
                                description: eventWithUnit.event.description,
                                unitId: eventWithUnit.event.unitId);
                            eventDao.updateEvent(eventWithFavouriteFlipped);
                          }),
                      IconButton(
                          icon: Icon(Icons.analytics,
                              size: 30, color: Theme.of(context).accentColor),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        AnalyticsScreen(eventWithUnit)));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
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
