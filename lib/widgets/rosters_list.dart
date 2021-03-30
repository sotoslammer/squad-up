import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/roster.dart';

class RostersList extends StatelessWidget {
  final List<Roster> rosters;

  const RostersList({Key key, @required this.rosters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rosters.isEmpty) {
      return Center(
          child: Column(
              children: [
                Text(
                  "There are no rosters to display.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
          ),
        ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
      );
    }

    return ListView.builder(itemBuilder: buildItem, itemCount: rosters.length);
  }

  Widget buildItem(BuildContext context, int index) {
    final roster = rosters[index];
    return ListTile(title: Text('${roster.name}'));
  }
}