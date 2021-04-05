import 'package:equatable/equatable.dart';
import 'package:squadup/models/superhero.dart';

abstract class SuperheroState extends Equatable {
  const SuperheroState();

  @override
  List<Object> get props => [];
}

class SuperheroesInit extends SuperheroState {}

class SuperheroesLoading extends SuperheroState {}

class SuperheroesLoadFailure extends SuperheroState {}

class SuperheroesLoadSuccess extends SuperheroState {
  final List<Superhero> superheroes;

  const SuperheroesLoadSuccess([this.superheroes = const []]);

  @override
  List<Object> get props => [superheroes];

  @override
  String toString() => 'SuperheroesLoadSuccess: { superheroes: $superheroes }';
}
