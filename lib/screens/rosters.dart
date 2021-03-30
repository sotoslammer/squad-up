import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/rosters/rosters.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/widgets/roster_create.dart';
import 'package:squadup/widgets/rosters_list.dart';
import 'package:squadup/widgets/error.dart';

class RostersScreen extends StatelessWidget {
  final rostersBloc = getIt.get<RostersBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => rostersBloc..add(RostersLoad()),
        child: Rosters(bloc: rostersBloc));
  }
}

class Rosters extends StatefulWidget {
  final RostersBloc? bloc;

  const Rosters({Key? key, this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RostersState();
}

class _RostersState extends State<Rosters> {
  void loadRosters() {
    widget.bloc!.add(RostersLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RostersBloc, RostersState>(builder: (context, state) {
      Widget? body;
      if (state is RostersLoadInProgress) {
        body = Center(child: CircularProgressIndicator());
      } else if (state is RostersLoadSuccess) {
        body = RostersList(rosters: state.rosters);
      } else if (state is RostersLoadFailure) {
        body = ErrorState(action: () {
          loadRosters();
        });
      }

      return SafeArea(
          child: Scaffold(
        body: body,
        floatingActionButton: RosterCreateButton(),
      ));
    });
  }
}
