import 'package:hive/hive.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/repository/rosters/entity.dart';
import 'package:squadup/repository/rosters/rosters.dart';

class RostersRepositoryHive extends RostersRepository {
  Box<RosterEntity> rosters = Hive.box<RosterEntity>(rostersBox);
  @override
  Future<void> addNewRoster(Roster roster) async {
    final entity = RosterEntity.fromRoster(roster);
    await rosters.add(entity);
  }

  @override
  Future<List<Roster>> listRosters() async  {
    return rosters.values.map((e) => e.toRoster()).toList();
  }

  @override
  Future<void>? removeRoster(Roster roster) {
    if (rosters.containsKey(roster.id)) {
      rosters.delete(roster.id);
    }

    return null;
  }

}