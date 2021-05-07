import 'package:flutter/material.dart';
import 'package:llog/data/moor_database.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventDao = Provider.of<AppDatabase>(context).eventDao;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites')
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: StreamBuilder(
              stream: eventDao.watchEvents(OrderingMode.desc),
              builder: (context, AsyncSnapshot<List<EventWithUnit>> snapshot) {
                final events = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (_, index) {
                      final eventWithUnit = events[index];
                      return ListTile(
                        title: Text(eventWithUnit.event.name),
                        trailing: IconButton(
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
                      );
                    });
              }))
    );
  }
}
