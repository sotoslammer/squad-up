import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/tactics/by_id.dart';
import 'package:squadup/bloc/tactic/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/tactic.dart';

class TacticBloc extends Bloc<TacticEvent, TacticState> {
  final gqlClient = getIt.get<GraphQLClient>();

  TacticBloc() : super(TacticInit());
  @override
  Stream<TacticState> mapEventToState(TacticEvent event) async* {
    if (event is LoadTacticById) {
      yield* _mapLoadTacticToState(event);
    }
  }

  Stream<TacticState> _mapLoadTacticToState(LoadTacticById event) async* {
    yield TacticLoading();
    try {
      final options = QueryOptions(
          document: tacticById, variables: <String, dynamic>{'id': event.id});
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield TacticLoadFailed();
      } else {
        final data = result.data?['tacticById'];
        yield TacticLoadSuccess(Tactic.fromJson(data));
      }
    } catch (e) {
      yield TacticLoadFailed();
    }
  }

}