import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/models/superhero.dart';

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
