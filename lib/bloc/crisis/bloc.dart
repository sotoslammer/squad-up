import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/crisis/by_id.dart';
import 'package:squadup/bloc/Crisis/barrel.dart';
import 'package:squadup/get_it.dart';
import 'package:squadup/models/Crisis.dart';

class CrisisBloc extends Bloc<CrisisEvent, CrisisState> {
  final gqlClient = getIt.get<GraphQLClient>();

  CrisisBloc() : super(CrisisInit());

  @override
  Stream<CrisisState> mapEventToState(CrisisEvent event) async* {
    if (event is LoadCrisisById) {
      yield* _mapLoadCrisisToState(event);
    }
  }

  Stream<CrisisState> _mapLoadCrisisToState(LoadCrisisById event) async* {
    yield CrisisLoading();
    try {
      final options = QueryOptions(
          document: crisisById, variables: <String, dynamic>{'id': event.id});
      final result = await gqlClient.query(options);
      if (result.hasException) {
        yield CrisisLoadFailed();
      } else {
        final data = result.data?['crisisById'];
        yield CrisisLoadSuccess(Crisis.fromJson(data));
      }
    } catch (e) {
      yield CrisisLoadFailed();
    }
  }
}
