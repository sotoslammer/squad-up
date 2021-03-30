import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';

abstract class RosterBuilderState extends Equatable {
  const RosterBuilderState();

  @override
  List<Object> get props => [];
}

class BuildingRosterInit extends RosterBuilderState{}

class BuildingRoster extends RosterBuilderState {
  final Roster roster;

  const BuildingRoster({required this.roster});

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'BuildingRoster { Roster: $roster }';
}