import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:squadup/screens/builder.dart';
import 'package:squadup/screens/superhero.dart';
import 'package:squadup/screens/superhero_selector.dart';
import 'package:squadup/screens/crisis_selector.dart';
import 'package:squadup/screens/rosters.dart';
import 'package:squadup/screens/tactic.dart';
import 'package:squadup/screens/tactic_selector.dart';

class RosterTabRoutes {
  static const String root = '/';
  static const String builder = "/build";
  static const String characterSelector = "/character-selector";
  static const String tacticSelector = "/tactic-selector";
  static const String crisisSelector = "/crisis-selector";
  static const String superhero = "/superhero";
  static const String tactic = "/tactic";
}

class RostersTabNavigator extends StatelessWidget {
  RostersTabNavigator({required this.navigatorKey});

  final GlobalKey<NavigatorState>? navigatorKey;

  Map<String, Widget> _routeBuilders(BuildContext context) {
    return {
      RosterTabRoutes.root: RostersScreen(),
      RosterTabRoutes.builder: BuilderScreen(),
      RosterTabRoutes.characterSelector: SuperheroSelectorScreen(),
      RosterTabRoutes.tacticSelector: TacticSelectorScreen(),
      RosterTabRoutes.crisisSelector: CrisisSelectorScreen(),
      RosterTabRoutes.superhero: SuperheroScreen(),
      RosterTabRoutes.tactic: TacticScreen()
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: RosterTabRoutes.root,
      onGenerateRoute: (routeSettings) {
        var route = routeBuilders[routeSettings.name!];
        return MaterialPageRoute(
            builder: (context) => route!,
            settings: RouteSettings(arguments: routeSettings.arguments));
      },
    );
  }
}
