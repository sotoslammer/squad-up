import 'package:equatable/equatable.dart';
import 'package:squadup/models/tactic.dart';

abstract class TacticsState extends Equatable {

  TacticsState();

  @override
  List<Object> get props => [];
}

class TacticsInit extends TacticsState {}

class TacticsLoading extends TacticsState {}

class TacticsLoadFailure extends TacticsState {}

class TacticsLoadSuccess extends TacticsState {
  final List<Tactic> tactics;

  TacticsLoadSuccess({required this.tactics});

  @override
  List<Object> get props => [tactics];
}