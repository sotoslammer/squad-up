import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/tactic/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/util.dart';
import 'package:squadup/widgets/error.dart';

class TacticScreen extends StatelessWidget {
  final bloc = getIt.get<TacticBloc>();

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider.value(
        value: bloc..add(LoadTacticById(id)),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(title: Text("Tactic Card")),
                body: _Tactic(bloc: bloc, id: id))));
  }
}

class _Tactic extends StatelessWidget {
  final TacticBloc bloc;
  final int id;

  const _Tactic({Key? key, required this.bloc, required this.id})
      : super(key: key);

  void loadTactic() {
    bloc.add(LoadTacticById(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TacticBloc, TacticState>(builder: (context, state) {
      if (state is TacticLoading) {
        return Container(
            alignment: Alignment.center, child: CircularProgressIndicator());
      } else if (state is TacticLoadFailed) {
        return ErrorState(action: loadTactic);
      } else if (state is TacticLoadSuccess) {
        var tactic = state.tactic;
        return Container(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(tactic.name ?? '',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(
                      tactic.affiliationByAffiliationId?.name ?? "Unaffiliated",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(enumToString(tactic.type),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(tactic.description ?? '')
                ])));
      } else {
        return Container(
            alignment: Alignment.center, child: Text('Something went wrong.'));
      }
    });
  }
}
