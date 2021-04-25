import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/bloc/tactics/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/tactic.dart';
import 'package:squadup/widgets/error.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

class TacticSelectorScreen extends StatelessWidget {
  final tacticsBloc = getIt.get<TacticsBloc>();
  final rosterBuilder = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    int tacticPosition = ModalRoute
        .of(context)!
        .settings
        .arguments as int;
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: tacticsBloc..add(LoadTactics())),
          BlocProvider.value(value: rosterBuilder)
        ],
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(title: Text("Tactic Cards")),
              body: _TacticSelector(
                bloc: tacticsBloc,
                builderBloc: rosterBuilder,
                tacticPosition: tacticPosition,
              ),
            )));
  }
}

class _TacticSelector extends StatefulWidget {
  final TacticsBloc bloc;
  final RosterBuilderBloc builderBloc;
  final int tacticPosition;

  const _TacticSelector({Key? key,
    required this.bloc,
    required this.builderBloc,
    required this.tacticPosition})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TacticSelectorState();
}

class _TacticSelectorState extends State<_TacticSelector> {
  void loadTactics() {
    widget.bloc.add(LoadTactics());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RosterBuilderBloc, RosterBuilderState>(
      listener: (context, state) {
        if (state is AddTacticFailed) {
          var name = state.tactic.name;
          ScaffoldMessenger
              .of(context)
              .showSnackBar(
              SnackBar(content: Text("$name is already in the roster")));
        } else if (state is AddTacticSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TacticsBloc, TacticsState>(builder: (context, state) {
        if (state is TacticsLoading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        } else if (state is TacticsLoadFailure) {
          return ErrorState(action: loadTactics);
        } else if (state is TacticsLoadSuccess) {
          return RefreshIndicator(
              onRefresh: () async {
                loadTactics();
              },
              child: ListView.builder(
                itemCount: state.tactics.length,
                itemBuilder: (context, index) {
                  var tactic = state.tactics[index];
                  return Card(
                      child: ListTile(
                        title: Text(tactic.name ?? ''),
                        subtitle: renderSuperheros(tactic),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            widget.builderBloc
                                .add(AddTactic(tactic, widget.tacticPosition));
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              RosterTabRoutes.tactic,
                              arguments: tactic.id);
                        },
                      ));
                },
              ));
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text('Something went wrong.'));
        }
      }),
    );
  }

  Widget? renderSuperheros(Tactic tactic) {
    var heroes = tactic.superheroToTacticsByB?.nodes ?? [];
    if (heroes.length > 0) {
      var text = heroes.fold<String>('', (val, cur) {
        var name = cur.superheroByA?.name ?? '';
        if (val.isNotEmpty) {
          return val + ", $name";
        } else {
          return name;
        }
      });
      return Text(text);
    }
  }
}
