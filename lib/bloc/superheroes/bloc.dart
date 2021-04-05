import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/superheros/get_all.dart';
import 'package:squadup/bloc/superheroes/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/superhero.dart';

class SuperheroesBloc extends Bloc<SuperheroesEvent, SuperheroState> {
  final gqlClient = getIt.get<GraphQLClient>();

  SuperheroesBloc() : super(SuperheroesInit());

  @override
  Stream<SuperheroState> mapEventToState(SuperheroesEvent event) async* {
    if (event is SuperheroesLoad) {
      yield* _mapSuperheroesLoadToState(event);
    }
  }

  Stream<SuperheroState> _mapSuperheroesLoadToState(
      SuperheroesEvent event) async* {
    yield SuperheroesLoading();
    try {
      final QueryOptions options = QueryOptions(document: allSuperHeroes);
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield SuperheroesLoadFailure();
      } else {
        List nodes = result.data?['allSuperheroes']['nodes'];
        List<Superhero> heroes = nodes
            .map((n) => Superhero.fromJson(n))
            .toList();
        yield SuperheroesLoadSuccess(heroes);
      }
    } catch (e) {
      yield SuperheroesLoadFailure();
    }
  }
}
