import 'package:equatable/equatable.dart';
import 'package:squadup/models/roster.dart';

abstract class RostersState extends Equatable {
  const RostersState();

  @override
  List<Object> get props => [];
}

class RostersLoadInProgress extends RostersState {}

class RostersLoadSuccess extends RostersState {
  final List<Roster> rosters;

  const RostersLoadSuccess([this.rosters = const []]);

  @override
  List<Object> get props => [rosters];

  @override
  String toString() => 'RostersLoadSuccess { Rosters: $rosters }';
}

class RostersLoadFailure extends RostersState {}
