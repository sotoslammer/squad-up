import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/repository/rosters/constants.dart';
import 'package:squadup/repository/rosters/entity.dart';
import 'package:squadup/screens/database.dart';

import 'package:squadup/widgets/bottom_navigation.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

import 'nav_tabs.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<RosterEntity>(rostersBox);
  getServices();
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
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.lightBlue, foregroundColor: Colors.white),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white)
          ),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white
            )
          )
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
  final _navigatorKeys = {
    TabItem.roster: GlobalKey<NavigatorState>(),
    TabItem.database: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(TabItem.roster),
            _buildOffstageNavigator(TabItem.database),
          ]),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
          ),
        ),
        onWillPop: () async =>
            !await _navigatorKeys[_currentTab].currentState.maybePop());
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    Widget navigator;
    switch (tabItem) {
      case TabItem.roster:
        navigator = RostersTabNavigator(navigatorKey: _navigatorKeys[tabItem]);
        break;
      case TabItem.database:
        navigator = Database();
        break;
      default:
        navigator = Center(child: Column(children: [Text("invalid screen")]));
    }
    return Offstage(
      offstage: _currentTab != tabItem,
      child: navigator,
    );
  }
}
