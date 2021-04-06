import 'package:equatable/equatable.dart';

abstract class SuperheroEvent extends Equatable {
  const SuperheroEvent();

  @override
  List<Object> get props => [];
}

class SuperheroLoadById extends SuperheroEvent {
  final int id;

  SuperheroLoadById(this.id);

  @override
  List<Object> get props => [id];
}