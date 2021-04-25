import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/crises/barrel.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/util.dart';
import 'package:squadup/widgets/error.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

class CrisisSelectorScreen extends StatelessWidget {
  final bloc = getIt.get<CrisesBloc>();
  final rosterBuilder = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    var crisisPosition = ModalRoute.of(context)!.settings.arguments as int;
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc..add(LoadCrises())),
          BlocProvider.value(value: rosterBuilder)
        ],
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Crisis Cards"),
                ),
                body: _CrisisSelector(
                    bloc: bloc,
                    builderBloc: rosterBuilder,
                    crisisPosition: crisisPosition))));
  }
}

class _CrisisSelector extends StatefulWidget {
  final CrisesBloc bloc;
  final RosterBuilderBloc builderBloc;
  final int crisisPosition;

  const _CrisisSelector(
      {Key? key,
      required this.bloc,
      required this.builderBloc,
      required this.crisisPosition})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CrisisSelectorState();
}

class _CrisisSelectorState extends State<_CrisisSelector> {
  void loadCrises() {
    widget.bloc.add(LoadCrises());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RosterBuilderBloc, RosterBuilderState>(
        listener: (context, state) {
      if (state is AddCrisisFailed) {
        var name = state.crisis.name;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$name is already in the roster")));
      } else if (state is AddCrisisFailedMaxReached) {
        var type = enumToString(state.type);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Max number of $type crises added")));
      } else if (state is AddCrisisSuccess) {
        Navigator.of(context).pop();
      }
    }, child: BlocBuilder<CrisesBloc, CrisesState>(builder: (context, state) {
      if (state is CrisesLoading) {
        return Container(
            alignment: Alignment.center, child: CircularProgressIndicator());
      } else if (state is CrisesLoadFailure) {
        return ErrorState(action: loadCrises);
      } else if (state is CrisesLoadSuccess) {
        return RefreshIndicator(
            onRefresh: () async {
              loadCrises();
            },
            child: ListView.builder(
                itemCount: state.crises.length,
                itemBuilder: (context, index) {
                  var crisis = state.crises[index];
                  return Card(
                      child: ListTile(
                          title: Text(crisis.name ?? ""),
                          subtitle: Text(enumToString(crisis.type)),
                          leading: Text(crisis.threat.toString(),
                              style: TextStyle(fontSize: 34)),
                          trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                widget.builderBloc.add(
                                    AddCrisis(crisis, widget.crisisPosition));
                              }),
                          onTap: () {
                            Navigator.pushNamed(context, RosterTabRoutes.crisis,
                                arguments: crisis.id);
                          }));
                }));
      } else {
        return Container(
            alignment: Alignment.center, child: Text('Something went wrong.'));
      }
    }));
  }
}
