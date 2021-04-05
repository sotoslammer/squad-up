import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:squadup/api/client.dart';
import 'package:squadup/bloc/roster_added/bloc.dart';
import 'package:squadup/bloc/roster_builder/bloc.dart';
import 'package:squadup/bloc/rosters/bloc.dart';
import 'package:squadup/bloc/superheroes/barrel.dart';
import 'package:squadup/repository/rosters/rosters.dart';
import 'package:squadup/repository/rosters/rosters_repository_hive.dart';

GetIt getIt = GetIt.instance;

void getServices(Store apiStore) {
  getIt.registerLazySingleton<RostersRepository>(() => RostersRepositoryHive());
  getIt.registerLazySingleton<RostersBloc>(() => RostersBloc());
  getIt.registerLazySingleton<RosterAddedBloc>(() => RosterAddedBloc());
  getIt.registerLazySingleton<RosterBuilderBloc>(() => RosterBuilderBloc());
  getIt.registerLazySingleton<GraphQLClient>(() => getClient(apiStore));
  getIt.registerLazySingleton<SuperheroesBloc>(() => SuperheroesBloc());
}
