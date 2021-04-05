import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/superheroes/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/widgets/error.dart';

class CharacterSelectorScreen extends StatelessWidget {
  final superheroesBloc = getIt.get<SuperheroesBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: superheroesBloc..add(SuperheroesLoad()),
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(title: Text("Select")),
              body: _CharacterSelector(bloc: superheroesBloc))),
    );
  }
}

class _CharacterSelector extends StatefulWidget {
  final SuperheroesBloc bloc;

  _CharacterSelector({Key? key, required this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CharacterSelectorState();
}

class CharacterSelectorState extends State<_CharacterSelector> {
  void loadSuperheroes() {
    widget.bloc.add(SuperheroesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuperheroesBloc, SuperheroState>(
      builder: (context, state) {
        if (state is SuperheroesLoading) {
          return Container(
              alignment: Alignment.center, child: CircularProgressIndicator());
        } else if (state is SuperheroesLoadFailure) {
          return ErrorState(action: loadSuperheroes);
        } else if (state is SuperheroesLoadSuccess) {
          return ListView.builder(
            itemCount: state.superheroes.length,
            itemBuilder: (BuildContext context, int index) => Card(
                child: ListTile(
                    title: Text(state.superheroes[index].name ?? 'Unknown'),
                    subtitle: Text(state.superheroes[index].affiliatedAsString()),
                    trailing: Text(
                        state.superheroes[index].threat?.toString() ??
                            'Unknown'))),
          );
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text('Something went wrong.'));
        }
      },
    );
  }
}
