import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  final int number;
  final GlobalKey<NavigatorState> navKey;
  final Widget child;
  final String label;

  const TabScreen(
      {Key? key,
      required this.number,
      required this.navKey,
      required this.child,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
        navigatorKey: navKey,
        builder: (BuildContext ctx) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(label),
                trailing: Icon(Icons.filter_1, size: 24),
              ),
              child: child);
        });
  }
}
