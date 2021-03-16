import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/screens/database.dart';

import 'package:squadup/widgets/BottomNavigation.dart';
import 'package:squadup/widgets/TabNavigator.dart';

import 'nav_tabs.dart';

void main() {
  runApp(SquadUpApp());
}

class SquadUpApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squad Up',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);


  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TabItem _currentTab = TabItem.roster;
  final rostersNavKey = GlobalKey<NavigatorState>();

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_currentTab) {
      case TabItem.roster:
        body = RostersTabNavigator(
            navigatorKey: rostersNavKey, tabItem: _currentTab);
        break;
      case TabItem.database:
        body = Database();
        break;
      default:
        body = Center(child: Column(children: [Text("invalid screen")]));
    }
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }
}
