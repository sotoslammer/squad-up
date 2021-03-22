import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';

abstract class RosterAddedEvent extends Equatable {
  const RosterAddedEvent();

  @override
  List<Object> get props => [];
}

class RosterAdded extends RosterAddedEvent {
  final Roster roster;

  const RosterAdded(this.roster);

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'RosterAdded { roster: $roster }';
}

class RosterAddedReset extends RosterAddedEvent {}