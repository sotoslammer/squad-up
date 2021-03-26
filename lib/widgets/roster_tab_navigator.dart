import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:squadup/screens/builder.dart';
import 'package:squadup/screens/rosters.dart';

class RosterTabRoutes {
  static const String root = '/';
  static const String builder = "/build";
}

class RostersTabNavigator extends StatelessWidget {
  RostersTabNavigator({this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      RosterTabRoutes.root: (context) => RostersScreen(),
      RosterTabRoutes.builder: (context) => BuilderScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: RosterTabRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
            settings: RouteSettings(arguments: routeSettings.arguments));
      },
    );
  }
}
