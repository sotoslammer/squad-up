import 'package:equatable/equatable.dart';
import 'package:squadup/models/Crisis.dart';

abstract class CrisisState extends Equatable {

  CrisisState();

  @override
  List<Object> get props => [];
}

class CrisisInit extends CrisisState {}

class CrisisLoading extends CrisisState {}

class CrisisLoadFailed extends CrisisState {}

class CrisisLoadSuccess extends CrisisState {
  final Crisis crisis;

  CrisisLoadSuccess(this.crisis);

  @override
  List<Object> get props => [crisis];
}