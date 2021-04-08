import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/bloc/superheroes/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/widgets/error.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

class SuperheroSelectorScreen extends StatelessWidget {
  final superheroesBloc = getIt.get<SuperheroesBloc>();
  final rosterBuilder = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    int heroPosition = ModalRoute.of(context)!.settings.arguments as int;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: superheroesBloc..add(SuperheroesLoad())),
        BlocProvider.value(value: rosterBuilder)
      ],
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(title: Text("Select")),
              body: _SuperheroSelector(
                bloc: superheroesBloc,
                builderBloc: rosterBuilder,
                heroPosition: heroPosition,
              ))),
    );
  }
}

class _SuperheroSelector extends StatefulWidget {
  final SuperheroesBloc bloc;
  final RosterBuilderBloc builderBloc;
  final int heroPosition;

  _SuperheroSelector(
      {Key? key,
      required this.bloc,
      required this.builderBloc,
      required this.heroPosition})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SuperheroSelectorState();
}

class SuperheroSelectorState extends State<_SuperheroSelector> {
  void loadSuperheroes() {
    widget.bloc.add(SuperheroesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RosterBuilderBloc, RosterBuilderState>(
        listener: (context, state) {
      if (state is AddSuperheroFailed) {
        var heroName = state.hero.name;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$heroName is already in the roster')));
      } else if (state is AddSuperheroSuccess) {
        Navigator.pop(context);
      }
    }, child: BlocBuilder<SuperheroesBloc, SuperheroState>(
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
                itemBuilder: (BuildContext context, int index) => SuperheroCard(
                  hero: state.superheroes[index],
                  addSuperhero: () {
                    widget.builderBloc.add(AddSuperhero(
                        state.superheroes[index], widget.heroPosition));
                  },
                ),
              ));
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text('Something went wrong.'));
        }
      },
    ));
  }
}

class SuperheroCard extends StatelessWidget {
  final Superhero hero;
  final addSuperhero;

  const SuperheroCard(
      {Key? key, required this.hero, required this.addSuperhero})
      : super(key: key);

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
      trailing: IconButton(icon: Icon(Icons.add), onPressed: addSuperhero),
      onTap: () {
        Navigator.pushNamed(context, RosterTabRoutes.superhero,
            arguments: hero.id);
      },
    ));
  }
}
