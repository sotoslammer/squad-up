import 'package:equatable/equatable.dart';

abstract class CrisesEvent extends Equatable {

  CrisesEvent();

  @override
  List<Object> get props => [];
}

class LoadCrises extends CrisesEvent {}