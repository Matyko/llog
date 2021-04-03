import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  final Widget indicator;
  final String title;
  final Widget content;

  const AnalyticsCard({this.indicator, this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title != null ? Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),) : Container(),
                Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Center(child: indicator)
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: content,
            )
          ],
        ),
      ),
    );
  }
}
