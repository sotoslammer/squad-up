import 'dart:async';
import 'dart:core';

import 'package:squadup/models/roster.dart';

abstract class RostersRepository {
  Future<List<Roster>> listRosters();

  Future<void> addNewRoster(Roster roster);

  Future<void>? removeRoster(Roster roster);
}
