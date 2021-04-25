import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/models/roster.dart';

class RosterBuilderBloc extends Bloc<RosterBuilderEvent, RosterBuilderState> {
  RosterBuilderBloc() : super(BuildingRosterInit());

  BuildingRoster get builderState => state as BuildingRoster;

  Roster get roster => builderState.roster;

  @override
  Stream<RosterBuilderState> mapEventToState(RosterBuilderEvent event) async* {
    if (event is SetRoster) {
      yield InitialRoster(roster: event.roster);
    } else if (event is AddSuperhero) {
      yield* _addSuperhero(event);
    } else if (event is AddTactic) {
      yield* _addTactic(event);
    } else if (event is AddCrisis) {
      yield* _addCrisis(event);
    }
  }

  Stream<RosterBuilderState> _addSuperhero(AddSuperhero event) async* {
    if (roster.containsHero(event.superhero)) {
      yield AddSuperheroFailed(roster: roster, hero: event.superhero);
    } else {
      roster.addSuperHero(event.superhero, event.index);
      yield AddSuperheroSuccess(roster: roster);
    }
  }

  Stream<RosterBuilderState> _addTactic(AddTactic event) async* {
    if (roster.containsTactic(event.tactic)) {
      yield AddTacticFailed(roster: roster, tactic: event.tactic);
    } else {
      roster.addTacticCard(event.tactic, event.index);
      yield AddTacticSuccess(roster: roster);
    }
  }

  Stream<RosterBuilderState> _addCrisis(AddCrisis event) async* {
    if (roster.containsCrisis(event.crisis)) {
      yield AddCrisisFailed(roster: roster, crisis: event.crisis);
    } else if (!roster.canAddCrisis(event.crisis)) {
      yield AddCrisisFailedMaxReached(roster: roster, type: event.crisis.type!);
    } else {
      roster.addCrisisCard(event.crisis, event.index);
      yield AddCrisisSuccess(roster: roster);
    }
  }
}
