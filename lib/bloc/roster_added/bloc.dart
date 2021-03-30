import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/repository/rosters/rosters_repository.dart';
import 'state.dart';

import 'event.dart';

class RosterAddedBloc extends Bloc<RosterAddedEvent, RosterAddedState> {
  final RostersRepository repo = getIt.get<RostersRepository>();

  RosterAddedBloc(): super(RosterAddedInit());

  @override
  Stream<RosterAddedState> mapEventToState(RosterAddedEvent event) async* {
    if (event is RosterAdded) {
      yield* _mapRosterAddedToState(event);
    } else if (event is RosterAddedReset) {
      yield* _mapRosterAddedResetToState(event);
    }
  }

  Stream<RosterAddedState> _mapRosterAddedToState(RosterAdded event) async* {
    yield RosterAddedInProgress();
    try {
      await Future.delayed(Duration(seconds: 2));
      // await repo.addNewRoster(event.roster);
      // final List<Roster> updatedRosters = ((state as RostersLoadSuccess)
      //     .rosters)
      //   ..add(event.roster);
      yield RosterAddedSuccess(roster: event.roster);
    } catch (e) {
      yield RosterAddedFailure();
    }
  }

  Stream<RosterAddedState> _mapRosterAddedResetToState(RosterAddedReset event) async* {
    yield RosterAddedInit();
  }
}
