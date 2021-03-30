import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:squadup/screens/builder.dart';
import 'package:squadup/screens/rosters.dart';

class RosterTabRoutes {
  static const String root = '/';
  static const String builder = "/build";
}

class RostersTabNavigator extends StatelessWidget {
  RostersTabNavigator({@required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  Map<String, Widget> _routeBuilders(BuildContext context) {
    return {
      RosterTabRoutes.root: RostersScreen(),
      RosterTabRoutes.builder: BuilderScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: RosterTabRoutes.root,
      onGenerateRoute: (routeSettings) {
        var route = routeBuilders[routeSettings.name];
        return MaterialPageRoute(
            builder: (context) => route,
            settings: RouteSettings(arguments: routeSettings.arguments));
      },
    );
  }
}
