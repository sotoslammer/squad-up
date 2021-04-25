import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/tactic.dart';

abstract class RosterBuilderEvent extends Equatable {
  const RosterBuilderEvent();

  @override
  List<Object> get props => [];
}

class SetRoster extends RosterBuilderEvent {
  final Roster roster;

  const SetRoster({required this.roster});

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'SetRoster { roster: $roster }';
}

class AddSuperhero extends RosterBuilderEvent {
  final Superhero superhero;
  final int index;

  AddSuperhero(this.superhero, this.index);

  @override
  List<Object> get props => [superhero, index];
}

class AddTactic extends RosterBuilderEvent {
  final Tactic tactic;
  final int index;

  AddTactic(this.tactic, this.index);

  @override
  List<Object> get props => [tactic, index];
}