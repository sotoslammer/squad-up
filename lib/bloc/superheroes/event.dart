import 'package:equatable/equatable.dart';

abstract class SuperheroesEvent extends Equatable {
  const SuperheroesEvent();

  @override
  List<Object> get props => [];
}

class SuperheroesLoad extends SuperheroesEvent {}
