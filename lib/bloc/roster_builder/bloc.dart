import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';

class RosterBuilderBloc extends Bloc<RosterBuilderEvent, RosterBuilderState> {
  RosterBuilderBloc() : super(BuildingRosterInit());

  @override
  Stream<RosterBuilderState> mapEventToState(RosterBuilderEvent event) async* {
    if (event is SetRoster) {
      yield BuildingRoster(roster: event.roster);
    }

  }
}