import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';

abstract class RostersEvent extends Equatable {
  const RostersEvent();

  @override
  List<Object> get props => [];
}

class RostersLoad extends RostersEvent {}

class RosterUpdated extends RostersEvent {
  final Roster roster;

  const RosterUpdated(this.roster);

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'RosterUpdated { roster: $roster }';
}

class RosterRemoved extends RostersEvent {
  final Roster roster;

  const RosterRemoved(this.roster);

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'RosterRemoved { roster: $roster }';
}
