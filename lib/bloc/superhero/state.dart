import 'package:equatable/equatable.dart';
import 'package:squadup/models/superhero.dart';

abstract class SuperheroState extends Equatable {
  const SuperheroState();

  @override
  List<Object> get props => [];
}


class SuperheroInit extends SuperheroState {}

class SuperheroLoading extends SuperheroState {}

class SuperheroLoadFailure extends SuperheroState {
  final int id;

  SuperheroLoadFailure(this.id);

  @override
  List<Object> get props => [id];
}

class SuperheroLoadSuccess extends SuperheroState {
  final Superhero superhero;

  SuperheroLoadSuccess(this.superhero);

  @override
  List<Object> get props => [superhero];
}