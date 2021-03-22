import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_added/bloc.dart';
import 'package:squadup/bloc/roster_added/roster_added.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/util.dart';
import 'package:squadup/widgets/fab_loader.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

class RosterCreateButton extends StatelessWidget {
  final addedBloc = getIt.get<RosterAddedBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => addedBloc,
        child: RosterCreate(bloc: addedBloc));
  }
}

class RosterCreate extends StatefulWidget {
  final RosterAddedBloc bloc;

  const RosterCreate({Key key, this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RosterCreateState();
  }
}

class _RosterCreateState extends State<RosterCreate> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RosterAddedBloc, RosterAddedState>(
        listener: (context, state) {
          if (state is RosterAddedSuccess) {
            widget.bloc.add(RosterAddedReset());
            Navigator.pushNamed(context, RosterTabRoutes.editor);
          }
        },
        builder: (context, state) {
          if (state is RosterAddedInProgress) {
            return FabLoader(
                child: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)));
          } else if (state is RosterAddedSuccess) {
            return FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.check),
              backgroundColor: Colors.green,
            );
          }
          return FloatingActionButton(
            onPressed: create,
            child: Icon(Icons.add),
          );
        });
  }

  void create() {
    widget.bloc.add(RosterAdded(Roster(id: newID())));
  }
}
