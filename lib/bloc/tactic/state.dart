import 'package:equatable/equatable.dart';
import 'package:squadup/models/tactic.dart';

abstract class TacticState extends Equatable {

  TacticState();

  @override
  List<Object> get props => [];
}

class TacticInit extends TacticState {}

class TacticLoading extends TacticState {}

class TacticLoadFailed extends TacticState {}

class TacticLoadSuccess extends TacticState {
  final Tactic tactic;

  TacticLoadSuccess(this.tactic);

  @override
  List<Object> get props => [tactic];
}