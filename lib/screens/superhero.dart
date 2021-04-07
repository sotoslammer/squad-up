import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/superhero/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/widgets/error.dart';
import 'package:squadup/widgets/superhero_details.dart';

class SuperheroScreen extends StatelessWidget {
  final superheroBloc = getIt.get<SuperheroBloc>();

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider.value(
        value: superheroBloc..add(SuperheroLoadById(id)),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(title: Text("Superhero")),
                body: _Superhero(bloc: superheroBloc))));
  }
}

class _Superhero extends StatefulWidget {
  final SuperheroBloc bloc;

  const _Superhero({Key? key, required this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperheroState();
}

class _SuperheroState extends State<_Superhero> {
  void loadSuperhero(int id) {
    widget.bloc.add(SuperheroLoadById(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuperheroBloc, SuperheroState>(
        builder: (context, state) {
      if (state is SuperheroLoading) {
        return Container(
            alignment: Alignment.center, child: CircularProgressIndicator());
      } else if (state is SuperheroLoadFailure) {
        return ErrorState(action: () {
          loadSuperhero(state.id);
        });
      } else if (state is SuperheroLoadSuccess) {
        return SuperheroDetails(superhero: state.superhero);
      } else {
        return Container(
            alignment: Alignment.center, child: Text('Something went wrong.'));
      }
    });
  }
}
