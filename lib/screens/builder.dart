import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';

import '../get_it.dart';

class BuilderScreen extends StatelessWidget {
  final builderBloc = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    var roster = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
        create: (BuildContext context) => builderBloc..add(SetRoster(roster)),
        child: Builder(bloc: builderBloc));
  }
}

class Builder extends StatefulWidget {
  final RosterBuilderBloc bloc;

  Builder({this.bloc});

  @override
  State<StatefulWidget> createState() => BuilderState();
}

class BuilderState extends State<Builder> {
  final nameController = TextEditingController(text: '');

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RosterBuilderBloc, RosterBuilderState>(
        builder: (context, state) {
      Widget body;
      if (state is BuildingRosterInit) {
        body = Center(child: CircularProgressIndicator());
      } else if (state is BuildingRoster) {
        body = Container(
            child: Column(children: [
          Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "eg. Avengers, Brotherhood", labelText: "Name"),
                    )))
          ])
        ]));
      }

      return SafeArea(
          child: Scaffold(appBar: AppBar(title: Text("Builder")), body: body));
    });
  }
}
