import 'package:equatable/equatable.dart';

abstract class TacticEvent extends Equatable {

  TacticEvent();

  @override
  List<Object> get props => [];
}

class LoadTacticById extends TacticEvent {
  final int id;

  LoadTacticById(this.id);

  @override
  List<Object> get props => [id];
}