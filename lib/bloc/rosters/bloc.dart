import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/repository/rosters/rosters_repository.dart';
import 'state.dart';

import 'event.dart';

class RostersBloc extends Bloc<RostersEvent, RostersState> {
  final RostersRepository repo = getIt.get<RostersRepository>();

  RostersBloc() : super(RostersLoadInProgress());

  @override
  Stream<RostersState> mapEventToState(RostersEvent event) async* {
    if (event is RostersLoad) {
      yield* _mapRostersLoadToState(event);
    } else if (event is RosterAdded) {
      yield* _mapRosterAddedToState(event);
    } else if (event is RosterRemoved) {
      yield* _mapRosterRemovedToStated(event);
    }
  }

  Stream<RostersState> _mapRostersLoadToState(RostersEvent event) async* {
    yield RostersLoadInProgress();
    try {
      final rosters = await repo.listRosters();
      yield RostersLoadSuccess(rosters);
    } catch (e) {
      yield RostersLoadFailure();
    }
  }

  Stream<RostersState> _mapRosterAddedToState(RosterAdded event) async* {
    if (state is RostersLoadSuccess) {
      await repo.addNewRoster(event.roster);
      final List<Roster> updatedRosters =
      ((state as RostersLoadSuccess).rosters)
        ..add(event.roster);
      yield RostersLoadSuccess(updatedRosters);
    }
  }

  Stream<RostersState> _mapRosterRemovedToStated(RosterRemoved event) async* {
    if (state is RostersLoadSuccess) {
      await repo.removeRoster(event.roster);
      final List<Roster> updatedRosters = ((state as RostersLoadSuccess)
          .rosters).where((r) => r.id != event.roster.id).toList();
      yield RostersLoadSuccess(updatedRosters);
    }
  }
}
