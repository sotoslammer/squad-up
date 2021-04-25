import 'package:equatable/equatable.dart';
import 'package:squadup/models/crisis.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/tactic.dart';

abstract class RosterBuilderState extends Equatable {
  const RosterBuilderState();

  @override
  List<Object> get props => [];
}

class BuildingRosterInit extends RosterBuilderState {}

abstract class BuildingRoster extends RosterBuilderState {
  final Roster roster;

  const BuildingRoster({required this.roster});

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'BuildingRoster { Roster: $roster }';
}

class InitialRoster extends BuildingRoster {
  InitialRoster({required Roster roster}) : super(roster: roster);
}

class AddSuperheroFailed extends BuildingRoster {
  final Superhero hero;

  AddSuperheroFailed({required Roster roster, required this.hero})
      : super(roster: roster);

  @override
  List<Object> get props => [roster, hero];
}

class AddSuperheroSuccess extends BuildingRoster {
  AddSuperheroSuccess({required Roster roster}) : super(roster: roster);
}

class AddTacticFailed extends BuildingRoster {
  final Tactic tactic;

  AddTacticFailed({required Roster roster, required this.tactic})
      : super(roster: roster);

  @override
  List<Object> get props => [roster, tactic];
}

class AddTacticSuccess extends BuildingRoster {
  AddTacticSuccess({required Roster roster}) : super(roster: roster);
}

class AddCrisisFailed extends BuildingRoster {
  final Crisis crisis;

  AddCrisisFailed({required Roster roster, required this.crisis})
      : super(roster: roster);

  @override
  List<Object> get props => [roster, crisis];
}

class AddCrisisSuccess extends BuildingRoster {
  AddCrisisSuccess({required Roster roster }) : super(roster: roster);
}
