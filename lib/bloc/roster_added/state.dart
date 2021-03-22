import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';

abstract class RosterAddedState extends Equatable {
  const RosterAddedState();

  @override
  List<Object> get props => [];
}

class RosterAddedInit extends RosterAddedState {}

class RosterAddedInProgress extends RosterAddedState {}

class RosterAddedFailure extends RosterAddedState {}

class RosterAddedSuccess extends RosterAddedState {
  final Roster roster;

  const RosterAddedSuccess([this.roster]);

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'RosterAddedSuccess { Roster: $roster }';
}