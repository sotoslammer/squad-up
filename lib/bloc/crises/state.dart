import 'package:equatable/equatable.dart';
import 'package:squadup/models/crisis.dart';

abstract class CrisesState extends Equatable {

  CrisesState();

  @override
  List<Object> get props => [];
}

class CrisesInit extends CrisesState {}

class CrisesLoading extends CrisesState {}

class CrisesLoadFailure extends CrisesState {}

class CrisesLoadSuccess extends CrisesState {
  final List<Crisis> crises;

  CrisesLoadSuccess({required this.crises});

  @override
  List<Object> get props => [crises];
}