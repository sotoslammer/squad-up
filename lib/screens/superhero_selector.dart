import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/superheroes/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/widgets/error.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

class SuperheroSelectorScreen extends StatelessWidget {
  final superheroesBloc = getIt.get<SuperheroesBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: superheroesBloc..add(SuperheroesLoad()),
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(title: Text("Select")),
              body: _SuperheroSelector(bloc: superheroesBloc))),
    );
  }
}

class _SuperheroSelector extends StatefulWidget {
  final SuperheroesBloc bloc;

  _SuperheroSelector({Key? key, required this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SuperheroSelectorState();
}

class SuperheroSelectorState extends State<_SuperheroSelector> {
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
          return RefreshIndicator(
              onRefresh: () async {
                loadSuperheroes();
              },
              child: ListView.builder(
                itemCount: state.superheroes.length,
                itemBuilder: (BuildContext context, int index) =>
                    SuperheroCard(hero: state.superheroes[index]),
              ));
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text('Something went wrong.'));
        }
      },
    );
  }
}

class SuperheroCard extends StatelessWidget {
  final Superhero hero;

  const SuperheroCard({Key? key, required this.hero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(hero.name ?? 'Unknown'),
            subtitle: Text(hero.affiliatedAsString()),
            leading: Text(
              hero.threat?.toString() ?? 'Unknown',
              style: TextStyle(fontSize: 34),
            ),
            onTap: () {
              Navigator.pushNamed(context, RosterTabRoutes.superhero, arguments: hero.id);
            },
        ));
  }
}
