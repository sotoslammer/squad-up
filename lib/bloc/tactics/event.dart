import 'package:equatable/equatable.dart';

abstract class TacticsEvent extends Equatable {

  TacticsEvent();

  @override
  List<Object> get props => [];
}

class LoadTactics extends TacticsEvent {}