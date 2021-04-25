import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/crisis/get_all.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/crisis.dart';

import 'event.dart';
import 'state.dart';

class CrisesBloc extends Bloc<CrisesEvent, CrisesState> {
  final gqlClient = getIt.get<GraphQLClient>();

  CrisesBloc(): super(CrisesInit());

  @override
  Stream<CrisesState> mapEventToState(CrisesEvent event) async* {
    if (event is LoadCrises) {
      yield* _mapLoadToCrisesState(event);
    }
  }

  Stream<CrisesState> _mapLoadToCrisesState(CrisesEvent event) async* {
    yield CrisesLoading();
    try {
      final QueryOptions options = QueryOptions(
          document: allCrises, fetchPolicy: FetchPolicy.cacheAndNetwork);
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield CrisesLoadFailure();
      } else {
        List nodes = result.data?['allCrises']['nodes'];
        List<Crisis> crises = nodes.map((n) => Crisis.fromJson(n)).toList();
        yield CrisesLoadSuccess(crises: crises);
      }
    } catch (e) {
      yield CrisesLoadFailure();
    }
  }
}