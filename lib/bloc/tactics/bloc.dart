import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/tactics/get_all.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/tactic.dart';

import 'event.dart';
import 'state.dart';

class TacticsBloc extends Bloc<TacticsEvent, TacticsState> {
  final gqlClient = getIt.get<GraphQLClient>();

  TacticsBloc(): super(TacticsInit());

  @override
  Stream<TacticsState> mapEventToState(TacticsEvent event) async* {
    if (event is LoadTactics) {
      yield* _mapLoadToTacticsState(event);
    }
  }

  Stream<TacticsState> _mapLoadToTacticsState(TacticsEvent event) async* {
    yield TacticsLoading();
    try {
      final QueryOptions options = QueryOptions(
          document: allTactics, fetchPolicy: FetchPolicy.cacheAndNetwork);
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield TacticsLoadFailure();
      } else {
        List nodes = result.data?['allTactics']['nodes'];
        List<Tactic> tactics = nodes.map((n) => Tactic.fromJson(n)).toList();
        yield TacticsLoadSuccess(tactics: tactics);
      }
    } catch (e) {
      yield TacticsLoadFailure();
    }
  }
}