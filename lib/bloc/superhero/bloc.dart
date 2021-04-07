import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/superheros/by_id.dart';
import 'package:squadup/bloc/superhero/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/superhero.dart';

class SuperheroBloc extends Bloc<SuperheroEvent, SuperheroState> {
  final gqlClient = getIt.get<GraphQLClient>();

  SuperheroBloc() : super(SuperheroInit());

  @override
  Stream<SuperheroState> mapEventToState(SuperheroEvent event) async* {
    if (event is SuperheroLoadById) {
      yield* _mapSuperheroLoadToState(event);
    }
  }

  Stream<SuperheroState> _mapSuperheroLoadToState(
      SuperheroLoadById event) async* {
    yield SuperheroLoading();
    try {
      final QueryOptions options = QueryOptions(
          document: superheroById,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          variables: <String, dynamic>{'id': event.id});
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield SuperheroLoadFailure(event.id);
      } else {
        final data = result.data?['superheroById'];
        yield SuperheroLoadSuccess(Superhero.fromJson(data));
      }
    } catch (e) {
      yield SuperheroLoadFailure(event.id);
    }
  }
}
