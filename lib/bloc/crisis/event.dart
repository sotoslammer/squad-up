import 'package:equatable/equatable.dart';

abstract class CrisisEvent extends Equatable {

  CrisisEvent();

  @override
  List<Object> get props => [];
}

class LoadCrisisById extends CrisisEvent {
  final int id;

  LoadCrisisById(this.id);

  @override
  List<Object> get props => [id];
}