import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/roster.dart';

abstract class RosterBuilderEvent extends Equatable {
  const RosterBuilderEvent();

  @override
  List<Object> get props => [];
}

class SetRoster extends RosterBuilderEvent {
  final Roster roster;

  const SetRoster({@required this.roster});

  @override
  List<Object> get props => [roster];

  @override
  String toString() => 'SetRoster { roster: $roster }';
}