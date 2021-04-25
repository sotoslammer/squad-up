import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';

class RosterBuilderBloc extends Bloc<RosterBuilderEvent, RosterBuilderState> {
  RosterBuilderBloc() : super(BuildingRosterInit());

  @override
  Stream<RosterBuilderState> mapEventToState(RosterBuilderEvent event) async* {
    if (event is SetRoster) {
      yield InitialRoster(roster: event.roster);
    } else if (event is AddSuperhero) {
      yield* _addSuperhero(event);
    } else if (event is AddTactic) {
      yield* _addTactic(event);
    }
  }

  Stream<RosterBuilderState> _addSuperhero(AddSuperhero event) async* {
    var currentState = (state as BuildingRoster);
    if (currentState.roster.containsHero(event.superhero)) {
      yield AddSuperheroFailed(roster: currentState.roster, hero: event.superhero);
    } else {
      currentState.roster.addSuperHero(event.superhero, event.index);
      yield AddSuperheroSuccess(roster: currentState.roster);
    }
  }

  Stream<RosterBuilderState> _addTactic(AddTactic event) async* {
    var currentState = (state as BuildingRoster);
    if (currentState.roster.containsTactic(event.tactic)) {
      yield AddTacticFailed(roster: currentState.roster, tactic: event.tactic);
    } else {
      currentState.roster.addTacticCard(event.tactic, event.index);
      yield AddTacticSuccess(roster: currentState.roster);
    }
  }
}